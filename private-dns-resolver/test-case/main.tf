terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.14.0"
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

resource "azurerm_virtual_network" "vnet1" {
  name                = "SEY-DNSRES-NE-VNET01"
  location            = local.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_virtual_network" "vnet2" {
  name                = "SEY-DNSRES-NE-VNET02"
  location            = local.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.1.0.0/16"]

  subnet {
    name             = "sey-dnsres-ne-subnet01"
    address_prefixes = ["10.1.0.0/24"]
  }
}

resource "azurerm_subnet" "subnet1" {
  name                 = "sey-dnsres-ne-subnet01"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "subnet2" {
  name                 = "sey-dnsres-ne-subnet02"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = ["10.0.2.0/24"]
}

# private dns resolver
module "private_dns_resolver" {
  source = "git@github.com:Seyfor-CSC/mit.private-dns-resolver.git?ref=v2.1.0"
  config = local.dnsres
}

output "private_dns_resolver" {
  value = module.private_dns_resolver.outputs
}
