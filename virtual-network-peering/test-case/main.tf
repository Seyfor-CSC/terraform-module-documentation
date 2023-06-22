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

resource "azurerm_virtual_network" "vnet_1" {
  name                = local.naming.vnet_1
  location            = local.location
  resource_group_name = local.naming.rg
  address_space       = ["10.0.0.0/24"]

  depends_on = [
    azurerm_resource_group.rg
  ]
}

resource "azurerm_virtual_network" "vnet_2" {
  name                = local.naming.vnet_2
  location            = local.location
  resource_group_name = local.naming.rg
  address_space       = ["10.0.1.0/24"]

  depends_on = [
    azurerm_resource_group.rg
  ]
}

# vnet peering
module "vnet_peering" {
  source = "git@github.com:Seyfor-CSC/mit.virtual-network-peering.git?ref=v1.1.1"
  config = local.peering

  depends_on = [
    azurerm_virtual_network.vnet_1,
    azurerm_virtual_network.vnet_2
  ]
}

output "vnet_peering" {
  value = module.vnet_peering.outputs
}
