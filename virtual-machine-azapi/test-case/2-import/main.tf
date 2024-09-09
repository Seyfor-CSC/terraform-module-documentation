terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.108.0"
    }
    azapi = {
      source  = "azure/azapi"
      version = "=1.15.0"
    }
  }
  backend "local" {}
}

provider "azurerm" {
  skip_provider_registration = false
  features {}
}
provider "azapi" {
}

# module deployment prerequisities
resource "azurerm_resource_group" "rg" {
  name     = "SEY-TERRAFORM-NE-RG01"
  location = local.location
}

resource "azurerm_monitor_data_collection_rule" "dcr" {
  name                = "dcr"
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
  name                = "sey-terraform-bv01"
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
  name                            = "backup-policy"
  vault_id                        = azurerm_data_protection_backup_vault.bv.id
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
  name                = "sey-terraform-rsv01"
  location            = local.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard"
  soft_delete_enabled = false
}
resource "azurerm_backup_policy_vm" "bp" {
  name                = "recovery-vault-policy"
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

data "azurerm_client_config" "current" {}

data "azurerm_subnet" "subnet" {
  name                 = "example-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = "example-network"

}

module "vm" {
  source = "git@github.com:Seyfor-CSC/mit.virtual-machine-azapi.git?ref=v2.1.0"
  config = local.vm
}

output "outputs" {
  value = module.vm.outputs
}
