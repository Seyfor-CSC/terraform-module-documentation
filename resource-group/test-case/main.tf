terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.45.0"
    }
  }
  backend "local" {}
}

provider "azurerm" {
  resource_provider_registrations = "core"
  features {}
}

# resource group
module "resource_group" {
  source = "git@github.com:Seyfor-CSC/mit.resource-group.git?ref=v2.4.0"
  config = local.rg
}

output "resource_group" {
  value = module.resource_group.outputs
}
