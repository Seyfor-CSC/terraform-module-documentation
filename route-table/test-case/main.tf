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

# module deployment prerequisites
resource "azurerm_resource_group" "rg" {
  name     = local.naming.rg
  location = local.location
}

# route table
module "route_table" {
  source = "git@github.com:Seyfor-CSC/mit.route-table.git?ref=v2.4.0"
  config = local.rt
}

output "route_table" {
  value = module.route_table.outputs
}
