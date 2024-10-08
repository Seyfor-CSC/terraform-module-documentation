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

resource "azurerm_virtual_network" "vnet" {
  name                = "SEY-ACAE-NE-VNET01"
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.12.0/24"]
  location            = local.location
}

resource "azurerm_subnet" "subnet" {
  name                 = "sey-acae-ne-aubnet01"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.12.0/27"]
  delegation {
    name = "managedInstanceDelegation"
    service_delegation {
      name    = "Microsoft.App/environments"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    }
  }
}

# monitoring prerequisities
resource "azurerm_log_analytics_workspace" "la" {
  name                = "SEY-ACAE-NE-LA01"
  location            = local.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

# container app environment
module "container_app_environment" {
  source = "git@github.com:Seyfor-CSC/mit.container-app-environment.git?ref=v2.0.0"
  config = local.cae
}

output "container_app_environment" {
  value = module.container_app_environment.outputs
}

