terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.51.0"
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

# logic app workflow
module "logic_app_workflow" {
  source = "git@github.com:Seyfor-CSC/mit.logic-app-workflow.git?ref=v1.0.0"
  config = local.logic

  depends_on = [
    azurerm_resource_group.rg
  ]
}

output "logic_app_workflow" {
  value = module.logic_app_workflow.outputs
}
