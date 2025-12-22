terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.56.0"
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

resource "azurerm_network_watcher" "nw" {
  name                = "SEY-FLOWLOG-NE-NW01"
  resource_group_name = azurerm_resource_group.rg.name
  location            = local.location
}

resource "azurerm_storage_account" "sa" {
  name                     = "seyflowlognesa01"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = local.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "SEY-FLOWLOG-NE-VNET01"
  resource_group_name = azurerm_resource_group.rg.name
  location            = local.location
  address_space       = ["10.0.1.0/28"]
}

resource "azurerm_subnet" "subnet" {
  name                 = "sey-flowlog-ne-subnet01"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/29"]
}

# network watcher flow log
module "flow_log" {
  source = "git@github.com:Seyfor-CSC/mit.network-watcher-flow-log.git?ref=v2.4.0"
  config = local.flow_log
}
