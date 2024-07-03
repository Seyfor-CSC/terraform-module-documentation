terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.108.0"
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
  resource_group_name = azurerm_resource_group.rg.name
  location            = local.location
}

resource "azurerm_storage_account" "sa" {
  name                     = local.naming.sa
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = local.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# monitoring prerequisities
resource "azurerm_log_analytics_workspace" "la" {
  name                = "SEY-TERRAFORM-NE-LA01"
  location            = local.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

# network security group
module "network_security_group" {
  source = "git@github.com:Seyfor-CSC/mit.network-security-group.git?ref=v1.6.0"
  config = local.nsg
}

output "network_security_group" {
  value = module.network_security_group.outputs
}
