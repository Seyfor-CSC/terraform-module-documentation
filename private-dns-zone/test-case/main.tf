terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.33.0"
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
  name                = "SEY-PDNSZONE-NE-VNET01"
  location            = local.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]
}
resource "azurerm_virtual_network" "vnet2" {
  name                = "SEY-PDNSZONE-NE-VNET02"
  location            = local.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]
}

# private dns zone
module "private_dns_zone" {
  source = "git@github.com:Seyfor-CSC/mit.private-dns-zone.git?ref=v2.3.0"
  config = local.dns
}

output "private_dns_zone" {
  value = module.private_dns_zone.outputs
}
