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
resource "azurerm_resource_group" "rg" {
  name     = local.naming.rg
  location = local.location
}

# monitoring prerequisities
resource "azurerm_log_analytics_workspace" "la" {
  name                = "SEY-LAWORKFLOW-NE-LA01"
  location            = local.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

# logic app workflow
module "logic_app_workflow" {
  source = "git@github.com:Seyfor-CSC/mit.logic-app-workflow.git?ref=v2.2.0"
  config = local.logic
}

output "logic_app_workflow" {
  value = module.logic_app_workflow.outputs
}
