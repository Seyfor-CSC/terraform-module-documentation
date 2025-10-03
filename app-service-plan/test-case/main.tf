terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.45.0"
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

# monitoring prerequisites
resource "azurerm_log_analytics_workspace" "la" {
  name                = "SEY-ASP-NE-LA01"
  location            = local.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

# app service plan
module "app_service_plan" {
  source = "git@github.com:Seyfor-CSC/mit.app-service-plan.git?ref=v2.5.0"
  config = local.asp
}

output "app_service_plan" {
  value = module.app_service_plan.outputs
}
