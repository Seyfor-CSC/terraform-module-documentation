terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.1.0"
    }
  }
  backend "local" {}
}

provider "azurerm" {
  resource_provider_registrations = "core"
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
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/24"]
}

resource "azurerm_virtual_network" "vnet_2" {
  name                = local.naming.vnet_2
  location            = local.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.1.0/24"]
}

# vnet peering
module "vnet_peering" {
  source = "git@github.com:Seyfor-CSC/mit.virtual-network-peering.git?ref=v2.0.0"
  config = local.peering
}

output "vnet_peering" {
  value = module.vnet_peering.outputs
}
