terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.14.0"
    }
  }
  backend "local" {}
}

provider "azurerm" {
  resource_provider_registrations = "core"
  features {}
}

# module deployment prerequisities
data "azurerm_subscription" "primary" {}

resource "azurerm_resource_group" "rg" {
  name     = local.naming.rg
  location = local.location
}

resource "azurerm_network_security_group" "nsg" {
  name                = "SEY-NETWORK-NE-NSG01"
  location            = local.location
  resource_group_name = lower(azurerm_resource_group.rg.name) # using the lower function to showcase when to use the nsg_rg variable
}

resource "azurerm_route_table" "rt" {
  name                          = "SEY-NETWORK-NE-UDR01"
  location                      = local.location
  resource_group_name           = azurerm_resource_group.rg.name
  bgp_route_propagation_enabled = true
}

resource "azurerm_virtual_network" "vnet" {
  name                = "SEY-NETWORK-NE-VNET03"
  location            = local.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.2.0/24"]
}

# monitoring prerequisities
resource "azurerm_log_analytics_workspace" "la" {
  name                = "SEY-NETWORK-NE-LA01"
  location            = local.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

# virtual network
module "virtual_network" {
  source          = "git@github.com:Seyfor-CSC/mit.virtual-network.git?ref=v2.1.0"
  config          = local.vnet
  subscription_id = data.azurerm_subscription.primary.id
}
module "subnets" {
  source          = "git@github.com:Seyfor-CSC/mit.virtual-network.git?ref=v2.1.0"
  subnets         = local.subnets
  subscription_id = data.azurerm_subscription.primary.id
}

output "virtual_network" {
  value = module.virtual_network.outputs
}

output "subnets" {
  value = module.subnets.outputs
}
