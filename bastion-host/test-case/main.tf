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

resource "azurerm_virtual_network" "vnet1" {
  name                = "example-network1"
  location            = local.location
  resource_group_name = local.naming.rg
  address_space       = ["10.0.0.0/24"]

  depends_on = [
    azurerm_resource_group.rg
  ]
}
resource "azurerm_virtual_network" "vnet2" {
  name                = "example-network2"
  location            = local.location
  resource_group_name = local.naming.rg
  address_space       = ["10.0.1.0/24"]

  depends_on = [
    azurerm_resource_group.rg
  ]
}

resource "azurerm_subnet" "subnet1" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = local.naming.rg
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = ["10.0.0.0/28"]
  depends_on = [
    azurerm_virtual_network.vnet1
  ]
}
resource "azurerm_subnet" "subnet2" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = local.naming.rg
  virtual_network_name = azurerm_virtual_network.vnet2.name
  address_prefixes     = ["10.0.1.0/28"]
  depends_on = [
    azurerm_virtual_network.vnet2
  ]
}

resource "azurerm_public_ip" "pip1" {
  name                = "example-pip1"
  location            = local.location
  resource_group_name = local.naming.rg
  allocation_method   = "Static"
  sku                 = "Standard"

  depends_on = [
    azurerm_resource_group.rg
  ]
}

resource "azurerm_public_ip" "pip2" {
  name                = "example-pip2"
  location            = local.location
  resource_group_name = local.naming.rg
  allocation_method   = "Static"
  sku                 = "Standard"

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

# bastion host
module "bastion_host" {
  source = "git@github.com:Seyfor-CSC/mit.bastion-host.git?ref=v1.1.0"
  config = local.bh

  depends_on = [
    azurerm_public_ip.pip1,
    azurerm_public_ip.pip2,
    azurerm_subnet.subnet1,
    azurerm_subnet.subnet2,
    azurerm_log_analytics_workspace.la
  ]
}

output "bastion_host" {
  value = module.bastion_host.outputs
}
