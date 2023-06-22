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

# route table
module "route_table" {
  source = "git@github.com:Seyfor-CSC/mit.route-table.git?ref=v1.1.0"
  config = local.rt

  depends_on = [
    azurerm_resource_group.rg
  ]
}

output "route_table" {
  value = module.route_table.outputs
}
