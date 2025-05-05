terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.23.0"
    }
    azapi = {
      source  = "azure/azapi"
      version = "=2.3.0"
    }
  }
  backend "local" {}
}

provider "azurerm" {
  resource_provider_registrations = "core"
  features {}
}
provider "azapi" {
}

# module deployment prerequisities
resource "azurerm_resource_group" "rg" {
  name     = "SEY-AZAPIVM-NE-RG01"
  location = local.location
}

resource "azurerm_monitor_data_collection_rule" "dcr" {
  name                = "SEY-AZAPIVM-NE-DCR01"
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
  name                = "SEY-AZAPIVM-NE-BV01"
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
  name                            = "weekly-policy"
  vault_id                        = azurerm_data_protection_backup_vault.bv.id
  backup_repeating_time_intervals = ["R/2021-05-19T06:33:16+00:00/PT4H"]
  default_retention_duration      = "P7D"
  retention_rule {
    name     = "Weekly"
    duration = "P7D"
    priority = 20
    criteria {
      absolute_criteria = "FirstOfWeek"
    }
  }
}
resource "azurerm_recovery_services_vault" "rsv" {
  name                = "SEY-AZAPIVM-NE-RSV01"
  location            = local.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard"
  soft_delete_enabled = false
}
resource "azurerm_backup_policy_vm" "bp" {
  name                = "weekly-policy"
  resource_group_name = azurerm_resource_group.rg.name
  recovery_vault_name = azurerm_recovery_services_vault.rsv.name
  backup {
    frequency = "Weekly"
    time      = "23:00"
    weekdays  = ["Sunday"]
  }
  retention_weekly {
    count    = 5
    weekdays = ["Sunday"]
  }
}

data "azurerm_client_config" "current" {}

data "azurerm_subnet" "subnet" {
  name                 = "sey-azapivm-ne-subnet01"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = "SEY-AZAPIVM-NE-VNET01"

}

data "azurerm_managed_disk" "source-osdisk" {
  name                = "SEYWINDOWSVM01-osdisk"
  resource_group_name = "SEY-AZAPIVM-NE-RG01"
}

module "vm" {
  source = "git@github.com:Seyfor-CSC/mit.virtual-machine-azapi.git?ref=v2.4.1"
  config = local.vm
}

output "outputs" {
  value = module.vm.outputs
}

