terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.45.0"
    }
  }
  backend "local" {}
}

provider "azurerm" {
  resource_provider_registrations = "core"
  features {}
}

# module deployment prerequisites
data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "rg" {
  name     = local.naming.rg
  location = local.location
}

resource "azurerm_virtual_network" "vnet" {
  name                = "SEY-VM-NE-VNET01"
  location            = local.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet" {
  name                 = "sey-vm-ne-subnet01"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_monitor_data_collection_rule" "dcr" {
  name                = "SEY-VM-NE-DCR01"
  resource_group_name = azurerm_resource_group.rg.name
  location            = local.location
  destinations {
    azure_monitor_metrics {
      name = "example-destination-metrics"
    }
  }
  data_flow {
    streams      = ["Microsoft-InsightsMetrics"]
    destinations = ["example-destination-metrics"]
  }
}

resource "azurerm_data_protection_backup_vault" "bv" {
  name                = "SEY-VM-NE-BV01"
  resource_group_name = azurerm_resource_group.rg.name
  location            = local.location
  datastore_type      = "VaultStore"
  redundancy          = "LocallyRedundant"
  soft_delete         = "Off"
  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_role_assignment" "rbac1" {
  scope                = azurerm_resource_group.rg.id
  role_definition_name = "Disk Snapshot Contributor"
  principal_id         = azurerm_data_protection_backup_vault.bv.identity[0].principal_id
}

resource "azurerm_role_assignment" "rbac2" {
  scope                = azurerm_resource_group.rg.id
  role_definition_name = "Disk Backup Reader"
  principal_id         = azurerm_data_protection_backup_vault.bv.identity[0].principal_id
}

resource "azurerm_data_protection_backup_policy_disk" "bp" {
  name     = "daily-policy"
  vault_id = azurerm_data_protection_backup_vault.bv.id

  backup_repeating_time_intervals = ["R/2021-05-19T06:33:16+00:00/PT4H"]
  default_retention_duration      = "P7D"

  retention_rule {
    name     = "Daily"
    duration = "P7D"
    priority = 25
    criteria {
      absolute_criteria = "FirstOfDay"
    }
  }
}

resource "azurerm_recovery_services_vault" "rsv" {
  name                = "SEY-VM-NE-RSV01"
  location            = local.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard"
  soft_delete_enabled = false
}

resource "azurerm_backup_policy_vm" "bp" {
  name                = "daily-policy"
  resource_group_name = azurerm_resource_group.rg.name
  recovery_vault_name = azurerm_recovery_services_vault.rsv.name

  backup {
    frequency = "Daily"
    time      = "23:00"
  }
  retention_daily {
    count = 10
  }
}

# virtual machine
module "virtual_machine" {
  source          = "git@github.com:Seyfor-CSC/mit.virtual-machine.git?ref=v2.4.1"
  config          = local.vm
  subscription_id = data.azurerm_client_config.current.subscription_id
}

output "virtual_machine" {
  value = module.virtual_machine.outputs
}
