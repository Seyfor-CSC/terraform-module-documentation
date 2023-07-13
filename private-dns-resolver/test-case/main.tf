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
  address_space       = ["10.0.0.0/16"]

  depends_on = [
    azurerm_resource_group.rg
  ]
}

resource "azurerm_virtual_network" "vnet2" {
  name                = "example-network2"
  location            = local.location
  resource_group_name = local.naming.rg
  address_space       = ["10.1.0.0/16"]

  subnet {
    name           = "subnet"
    address_prefix = "10.1.0.0/24"
  }

  depends_on = [
    azurerm_resource_group.rg
  ]
}

resource "azurerm_subnet" "subnet1" {
  name                 = "example-subnet1"
  resource_group_name  = local.naming.rg
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = ["10.0.1.0/24"]

  depends_on = [
    azurerm_virtual_network.vnet1
  ]
}

resource "azurerm_subnet" "subnet2" {
  name                 = "example-subnet2"
  resource_group_name  = local.naming.rg
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = ["10.0.2.0/24"]

  depends_on = [
    azurerm_virtual_network.vnet1
  ]
}

# private dns resolver
module "private_dns_resolver" {
  source = "git@github.com:Seyfor-CSC/mit.private-dns-resolver.git?ref=v1.0.0"
  config = local.dnsres

  depends_on = [
    azurerm_subnet.subnet1,
    azurerm_subnet.subnet2
  ]
}

output "private_dns_resolver" {
  value = module.private_dns_resolver.outputs
}
