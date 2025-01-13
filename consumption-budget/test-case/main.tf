terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.14.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "=3.0.2"
    }
  }
  backend "local" {}
}

provider "azurerm" {
  resource_provider_registrations = "core"
  features {}
}
provider "azuread" {}

# module deployment prerequisities
data "azurerm_subscription" "primary" {}

data "azurerm_client_config" "current" {}

data "azuread_user" "user" {
  object_id = data.azurerm_client_config.current.object_id
}

resource "azurerm_resource_group" "rg" {
  name     = local.naming.rg
  location = local.location
}

# consumption budget
module "consumption_budget" {
  source = "git@github.com:Seyfor-CSC/mit.consumption-budget.git?ref=v2.1.0"
  config = local.consumption_budget
}

output "consumption_budget" {
  value = module.consumption_budget.outputs
}
