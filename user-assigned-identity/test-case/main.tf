terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.23.0"
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

# user assigned identity
module "user_assigned_identity" {
  source = "git@github.com:Seyfor-CSC/mit.user-assigned-identity.git?ref=v2.2.1"
  config = local.uai
}

output "user_assigned_identity" {
  value = module.user_assigned_identity.outputs
}
