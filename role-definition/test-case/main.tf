terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.84.0"
    }
  }
  backend "local" {}
}

provider "azurerm" {
  skip_provider_registration = false
  features {}
}

# deployment prerequisites
data azurerm_subscription "primary" {}

# role definition
module "role_definition" {
  source = "git@github.com:Seyfor-CSC/mit.role-definition.git?ref=v1.4.0"
  config = local.rd
}

output "role_definition" {
  value = module.role_definition.outputs
}
