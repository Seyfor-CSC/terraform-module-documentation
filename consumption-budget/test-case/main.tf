terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.77.0"
    }
  }
  backend "local" {}
}

provider "azurerm" {
  resource_provider_registrations = "core"
  features {}
}
provider "azuread" {}

# module deployment prerequisites
data "azurerm_subscription" "primary" {}

resource "azurerm_resource_group" "rg" {
  name     = local.naming.rg
  location = local.location
}

# consumption budget
module "consumption_budget" {
  source = "git@github.com:Seyfor-CSC/mit.consumption-budget.git?ref=v2.7.0"
  config = local.consumption_budget
}

output "consumption_budget" {
  value = module.consumption_budget.outputs
}
