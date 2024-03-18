terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.96.0"
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

resource "azurerm_virtual_network" "vnet" {
  name                = "example-network"
  location            = local.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet" {
  name                 = "example-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_private_dns_zone" "dns" {
  name                = "test.private.dns"
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "dns_link" {
  name                  = "test"
  resource_group_name   = azurerm_resource_group.rg.name
  private_dns_zone_name = azurerm_private_dns_zone.dns.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
}

resource "azurerm_automation_account" "aa" {
  name                = local.naming.aa_1
  location            = local.location
  resource_group_name = azurerm_resource_group.rg.name
  sku_name            = "Basic"
}

resource "azurerm_recovery_services_vault" "rsv" {
  name                = local.naming.rsv_1
  location            = local.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard"
}

# private endpoint
module "private_endpoint" {
  source = "git@github.com:Seyfor-CSC/mit.private-endpoint.git?ref=v1.4.0"
  config = local.pe
}
