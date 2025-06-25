terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.33.0"
    }
  }
  backend "local" {}
}

provider "azurerm" {
  resource_provider_registrations = "core"
  features {}
}

# module deployment prerequisites
resource "azurerm_resource_group" "rg" {
  name     = local.naming.rg
  location = local.location
}

# availability set
module "availability_set" {
  source = "git@github.com:Seyfor-CSC/mit.availability-set.git?ref=v2.3.0"
  config = local.avset
}

output "availability_set" {
  value = module.availability_set.outputs
}
