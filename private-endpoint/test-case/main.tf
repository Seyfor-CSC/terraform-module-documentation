terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.84.0"
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
  resource_group_name = local.naming.rg
  address_space       = ["10.0.0.0/16"]

  depends_on = [
    azurerm_resource_group.rg
  ]
}

resource "azurerm_subnet" "subnet" {
  name                 = "example-subnet"
  resource_group_name  = local.naming.rg
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
  depends_on = [
    azurerm_virtual_network.vnet
  ]
}

resource "azurerm_private_dns_zone" "dns" {
  name                = "test.private.dns"
  resource_group_name = local.naming.rg

  depends_on = [
    azurerm_resource_group.rg
  ]
}

resource "azurerm_private_dns_zone_virtual_network_link" "dns_link" {
  name                  = "test"
  resource_group_name   = local.naming.rg
  private_dns_zone_name = azurerm_private_dns_zone.dns.name
  virtual_network_id    = azurerm_virtual_network.vnet.id

  depends_on = [
    azurerm_private_dns_zone.dns,
    azurerm_virtual_network.vnet
  ]
}

resource "azurerm_automation_account" "aa" {
  name                = local.naming.aa_1
  location            = local.location
  resource_group_name = local.naming.rg
  sku_name            = "Basic"

  depends_on = [
    azurerm_resource_group.rg
  ]
}

resource "azurerm_recovery_services_vault" "rsv" {
  name                = local.naming.rsv_1
  location            = local.location
  resource_group_name = local.naming.rg
  sku                 = "Standard"

  depends_on = [
    azurerm_resource_group.rg
  ]
}

# private endpoint
module "private_endpoint" {
  source = "git@github.com:Seyfor-CSC/mit.private-endpoint.git?ref=v1.3.0"
  config = local.pe

  depends_on = [
    azurerm_private_dns_zone_virtual_network_link.dns_link,
    azurerm_automation_account.aa,
    azurerm_recovery_services_vault.rsv
  ]
}
