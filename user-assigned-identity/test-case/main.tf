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

# user assigned identity
module "user_assigned_identity" {
  source = "git@github.com:Seyfor-CSC/mit.user-assigned-identity.git?ref=v1.0.0"
  config = local.uai

  depends_on = [
    azurerm_resource_group.rg
  ]
}

output "user_assigned_identity" {
  value = module.user_assigned_identity.outputs
}
