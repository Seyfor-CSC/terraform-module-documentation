terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.96.0"
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

# user assigned identity
module "user_assigned_identity" {
  source = "git@github.com:Seyfor-CSC/mit.user-assigned-identity.git?ref=v1.4.0"
  config = local.uai
}

output "user_assigned_identity" {
  value = module.user_assigned_identity.outputs
}
