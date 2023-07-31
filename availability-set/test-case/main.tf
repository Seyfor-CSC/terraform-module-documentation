terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.67.0"
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

# availability set
module "availability_set" {
  source = "git@github.com:Seyfor-CSC/mit.availability-set.git?ref=v1.1.0"
  config = local.avset

  depends_on = [
    azurerm_resource_group.rg
  ]
}

output "availability_set" {
  value = module.availability_set.outputs
}
