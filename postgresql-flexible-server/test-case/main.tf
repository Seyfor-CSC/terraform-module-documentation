terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.45.0"
    }
  }
  backend "local" {}
}

provider "azurerm" {
  resource_provider_registrations = "core"
  features {}
}

# module deployment prerequisites
resource "azurerm_resource_group" "rg" {
  name     = local.naming.rg
  location = local.location
}

data "azurerm_client_config" "current" {}

# private endpoint prerequisites
resource "azurerm_virtual_network" "vnet" {
  name                = "SEY-PGSQL-NE-VNET01"
  location            = local.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet" {
  name                 = "sey-pgsql-ne-subnet01"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_private_dns_zone" "dns" {
  name                = "sey.postgres.database.azure.com"
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "dns_link" {
  name                  = "SEY-PGSQL-NE-VNET01"
  resource_group_name   = azurerm_resource_group.rg.name
  private_dns_zone_name = azurerm_private_dns_zone.dns.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
}

# monitoring prerequisites
resource "azurerm_log_analytics_workspace" "la" {
  name                = "SEY-PGSQL-NE-LA01"
  location            = local.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

# backup prerequisites
resource "azurerm_data_protection_backup_vault" "backup_vault" {
  name                = "SEY-PGSQL-NE-BV01"
  resource_group_name = azurerm_resource_group.rg.name
  location            = local.location
  datastore_type      = "VaultStore"
  redundancy          = "LocallyRedundant"
  immutability        = "Disabled"
  soft_delete         = "Off"

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_role_assignment" "backup_vault_role" {
  scope                = azurerm_resource_group.rg.id
  role_definition_name = "Reader"
  principal_id         = azurerm_data_protection_backup_vault.backup_vault.identity[0].principal_id
}

resource "azurerm_data_protection_backup_policy_postgresql_flexible_server" "postgresql_policy" {
  name     = "postgresql-backup-policy"
  vault_id = azurerm_data_protection_backup_vault.backup_vault.id

  backup_repeating_time_intervals = ["R/2024-05-05T22:33:00+00:00/P1W"]

  default_retention_rule {
    life_cycle {
      duration        = "P4M"
      data_store_type = "VaultStore"
    }
  }
}

# postgresql flexible server
module "postgresql_flexible_server" {
  source = "git@github.com:Seyfor-CSC/mit.postgresql-flexible-server.git?ref=v2.6.0"
  config = local.pgsql
  depends_on = [
    azurerm_role_assignment.backup_vault_role
  ]
}

output "postgresql_flexible_server" {
  value = module.postgresql_flexible_server.outputs
}
