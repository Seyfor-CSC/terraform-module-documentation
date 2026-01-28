terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.56.0"
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

# capacity reservation group module
module "capacity_reservation_group" {
  source = "git@github.com:Seyfor-CSC/mit.capacity-reservation-group.git?ref=v2.0.0"
  config = local.capacity_reservation_group
}

output "capacity_reservation_group" {
  value = module.capacity_reservation_group.outputs
}
