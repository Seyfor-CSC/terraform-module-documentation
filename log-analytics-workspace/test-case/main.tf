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
resource "azurerm_resource_group" "rg" {
  name     = local.naming.rg
  location = local.location
}

# monitoring prerequisities
resource "azurerm_log_analytics_workspace" "la" {
  name                = "SEY-TERRAFORM-NE-LA04"
  location            = local.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}
# log analytics workspace
module "log_analytics_workspace" {
  source = "git@github.com:Seyfor-CSC/mit.log-analytics-workspace.git?ref=v1.6.0"
  config = local.la
}

output "log_analytics_workspace" {
  value = module.log_analytics_workspace.outputs
}
