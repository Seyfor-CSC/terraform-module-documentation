terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.73.0"
    }
  }
  backend "local" {}
}

provider "azurerm" {
  skip_provider_registration = false
  features {}
}

# module deployment prerequisities
data "azurerm_subscription" "primary" {}

resource "azurerm_resource_group" "rg" {
  name     = local.naming.rg
  location = local.location
}

resource "azurerm_network_security_group" "nsg" {
  name                = local.naming.nsg
  location            = local.location
  resource_group_name = local.naming.rg

  depends_on = [
    azurerm_resource_group.rg
  ]
}

resource "azurerm_route_table" "rt" {
  name                          = local.naming.rt
  location                      = local.location
  resource_group_name           = local.naming.rg
  disable_bgp_route_propagation = true

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

# virtual network
module "virtual_network" {
  source = "git@github.com:Seyfor-CSC/mit.virtual-network.git?ref=v1.3.1"
  config = local.vnet

  depends_on = [
    azurerm_log_analytics_workspace.la,
    azurerm_network_security_group.nsg,
    azurerm_route_table.rt
  ]
}

output "virtual_network" {
  value = module.virtual_network.outputs
}
