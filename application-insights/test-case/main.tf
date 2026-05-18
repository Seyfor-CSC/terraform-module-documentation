terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.64.0"
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

resource "azurerm_log_analytics_workspace" "la" {
  name                = "SEY-APPI-NE-LA01"
  location            = local.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

# application insights
module "application_insights" {
  source = "git@github.com:Seyfor-CSC/mit.application-insights.git?ref=v2.0.0"
  config = local.config
}

output "application_insights" {
  value = module.application_insights.outputs
}
