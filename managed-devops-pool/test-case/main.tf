terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.70.0"
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

resource "azurerm_dev_center" "dc" {
  name                = "seymdpswcdc01"
  resource_group_name = azurerm_resource_group.rg.name
  location            = local.location
}

resource "azurerm_dev_center_project" "dc_project" {
  dev_center_id       = azurerm_dev_center.dc.id
  location            = local.location
  name                = "seymdpswcdcp01"
  resource_group_name = azurerm_resource_group.rg.name
}

# monitoring prerequisites
resource "azurerm_log_analytics_workspace" "la" {
  name                = "SEY-MDP-SWC-LA01"
  location            = local.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

# managed devops pool
module "managed_devops_pool" {
  source = "git@github.com:Seyfor-CSC/mit.managed-devops-pool.git?ref=v2.0.0"
  config = local.config
}

output "managed_devops_pool" {
  value = module.managed_devops_pool.outputs
}
