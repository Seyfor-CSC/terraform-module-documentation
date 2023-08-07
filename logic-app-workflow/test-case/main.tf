terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.67.0"
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
  name                = "SEY-TERRAFORM-NE-LA01"
  location            = local.location
  resource_group_name = local.naming.rg
  sku                 = "PerGB2018"
  retention_in_days   = 30

  depends_on = [
    azurerm_resource_group.rg
  ]
}

# logic app workflow
module "logic_app_workflow" {
  source = "git@github.com:Seyfor-CSC/mit.logic-app-workflow.git?ref=v1.2.0"
  config = local.logic

  depends_on = [
    azurerm_resource_group.rg
  ]
}

output "logic_app_workflow" {
  value = module.logic_app_workflow.outputs
}
