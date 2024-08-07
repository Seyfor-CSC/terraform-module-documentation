terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.108.0"
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
  resource_group_name = lower(azurerm_resource_group.rg.name) # using the lower function to showcase when to use the nsg_rg variable
}

resource "azurerm_route_table" "rt" {
  name                          = local.naming.rt
  location                      = local.location
  resource_group_name           = azurerm_resource_group.rg.name
  disable_bgp_route_propagation = true
}

resource "azurerm_virtual_network" "vnet" {
  name                = "example-network"
  location            = local.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.2.0/24"]
}

# monitoring prerequisities
resource "azurerm_log_analytics_workspace" "la" {
  name                = "SEY-TERRAFORM-NE-LA01"
  location            = local.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

# virtual network
module "virtual_network" {
  source          = "git@github.com:Seyfor-CSC/mit.virtual-network.git?ref=v1.8.1"
  config          = local.vnet
  subscription_id = data.azurerm_subscription.primary.id
}
module "subnets" {
  source          = "git@github.com:Seyfor-CSC/mit.virtual-network.git?ref=v1.8.1"
  subnets         = local.subnets
  subscription_id = data.azurerm_subscription.primary.id
}

output "virtual_network" {
  value = module.virtual_network.outputs
}

output "subnets" {
  value = module.subnets.outputs
}
