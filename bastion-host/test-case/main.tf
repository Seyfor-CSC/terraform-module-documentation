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
resource "azurerm_resource_group" "rg" {
  name     = local.naming.rg
  location = local.location
}

resource "azurerm_virtual_network" "vnet1" {
  name                = "SEY-BASTION-NE-VNET01"
  location            = local.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/24"]
}
resource "azurerm_virtual_network" "vnet2" {
  name                = "SEY-BASTION-NE-VNET02"
  location            = local.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "subnet1" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = ["10.0.0.0/28"]
}
resource "azurerm_subnet" "subnet2" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet2.name
  address_prefixes     = ["10.0.1.0/28"]
}

resource "azurerm_public_ip" "pip1" {
  name                = "SEY-BASTION-NE-PIP01"
  location            = local.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_public_ip" "pip2" {
  name                = "SEY-BASTION-NE-PIP02"
  location            = local.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}


# monitoring prerequisites
resource "azurerm_log_analytics_workspace" "la" {
  name                = "SEY-BASTION-NE-LA01"
  location            = local.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

# bastion host
module "bastion_host" {
  source = "git@github.com:Seyfor-CSC/mit.bastion-host.git?ref=v2.5.0"
  config = local.bh
}

output "bastion_host" {
  value = module.bastion_host.outputs
}
