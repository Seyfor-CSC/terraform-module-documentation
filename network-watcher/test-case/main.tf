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

# network watcher
module "network_watcher" {
  source = "git@github.com:Seyfor-CSC/mit.network-watcher.git?ref=v1.2.0"
  config = local.nw

  depends_on = [
    azurerm_resource_group.rg
  ]
}

output "network_watcher" {
  value = module.network_watcher.outputs
}
