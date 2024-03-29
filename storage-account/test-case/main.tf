terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.84.0"
    }
  }
  backend "local" {}
}

provider "azurerm" {
  skip_provider_registration = false
  features {}
}

# module deployment prerequisities

resource "azurerm_resource_group" "rg" {
  name     = local.naming.rg
  location = local.location
}

resource "azurerm_recovery_services_vault" "rsv" {
  name                = "SEY-TERRAFORM-RSV01"
  location            = local.location
  resource_group_name = local.naming.rg
  sku                 = "Standard"
  soft_delete_enabled = false

  depends_on = [
    azurerm_resource_group.rg
  ]
}

resource "azurerm_backup_policy_file_share" "example" {
  name                = "daily-share-backup"
  resource_group_name = local.naming.rg
  recovery_vault_name = azurerm_recovery_services_vault.rsv.name

  backup {
    frequency = "Daily"
    time      = "23:00"
  }

  retention_daily {
    count = 10
  }

  depends_on = [
    azurerm_recovery_services_vault.rsv
  ]
}

# private endpoint prerequisities
resource "azurerm_virtual_network" "vnet" {
  name                = "example-network"
  location            = local.location
  resource_group_name = local.naming.rg
  address_space       = ["10.0.0.0/16"]

  depends_on = [
    azurerm_resource_group.rg
  ]
}

resource "azurerm_subnet" "subnet" {
  name                 = "example-subnet"
  resource_group_name  = local.naming.rg
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
  depends_on = [
    azurerm_virtual_network.vnet
  ]
}

resource "azurerm_private_dns_zone" "dns" {
  name                = "test.private.dns"
  resource_group_name = local.naming.rg

  depends_on = [
    azurerm_resource_group.rg
  ]
}

resource "azurerm_private_dns_zone_virtual_network_link" "dns_link" {
  name                  = "test"
  resource_group_name   = local.naming.rg
  private_dns_zone_name = azurerm_private_dns_zone.dns.name
  virtual_network_id    = azurerm_virtual_network.vnet.id

  depends_on = [
    azurerm_private_dns_zone.dns,
    azurerm_virtual_network.vnet
  ]
}

# monitoring prerequisities
resource "azurerm_log_analytics_workspace" "la" {
  name                = "SEY-TERRAFORM-NE-LA01"
  location            = local.location
  resource_group_name = local.naming.rg
  sku                 = "PerGB2018"
  retention_in_days   = 30

  depends_on = [
    azurerm_resource_group.rg
  ]
}

# storage account
module "storage_account" {
  source = "git@github.com:Seyfor-CSC/mit.storage-account.git?ref=v1.7.1"
  config = local.sa

  depends_on = [
    azurerm_private_dns_zone_virtual_network_link.dns_link,
    azurerm_log_analytics_workspace.la,
    azurerm_backup_policy_file_share.example
  ]
}

output "storage_account" {
  value = module.storage_account.outputs
}
