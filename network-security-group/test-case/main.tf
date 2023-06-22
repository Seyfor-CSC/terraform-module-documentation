terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.51.0"
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

resource "azurerm_network_watcher" "nw" {
  name                = local.naming.nw
  resource_group_name = local.naming.rg
  location            = local.location

  depends_on = [
    azurerm_resource_group.rg
  ]
}

resource "azurerm_storage_account" "sa" {
  name                     = local.naming.sa
  resource_group_name      = local.naming.rg
  location                 = local.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  depends_on = [
    azurerm_resource_group.rg
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

# network security group
module "network_security_group" {
  source = "git@github.com:Seyfor-CSC/mit.network-security-group.git?ref=v1.1.2"
  config = local.nsg

  depends_on = [
    azurerm_log_analytics_workspace.la,
    azurerm_network_watcher.nw,
    azurerm_storage_account.sa
  ]
}

output "network_security_group" {
  value = module.network_security_group.outputs
}
