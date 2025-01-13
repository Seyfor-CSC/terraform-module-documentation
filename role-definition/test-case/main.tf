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

# deployment prerequisites
data "azurerm_subscription" "primary" {}

# role definition
module "role_definition" {
  source = "git@github.com:Seyfor-CSC/mit.role-definition.git?ref=v2.1.0"
  config = local.rd
}

output "role_definition" {
  value = module.role_definition.outputs
}
