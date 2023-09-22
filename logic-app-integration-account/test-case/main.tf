terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.73.0"
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

# logic app integration account
module "integration_account" {
  source = "git@github.com:Seyfor-CSC/mit.logic-app-integration-account.git?ref=v1.1.0"
  config = local.ia

  depends_on = [
    azurerm_log_analytics_workspace.la
  ]
}

output "integration_account" {
  value = module.integration_account.outputs
}
