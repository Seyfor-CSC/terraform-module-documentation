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

# resource group
module "resource_group" {
  source = "git@github.com:Seyfor-CSC/mit.resource-group.git?ref=v1.5.0"
  config = local.rg
}

output "resource_group" {
  value = module.resource_group.outputs
}
