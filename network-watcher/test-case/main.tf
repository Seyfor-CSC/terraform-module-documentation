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
  location = local.location1
}

# network watcher
module "network_watcher" {
  source = "git@github.com:Seyfor-CSC/mit.network-watcher.git?ref=v2.5.0"
  config = local.nw
}

output "network_watcher" {
  value = module.network_watcher.outputs
}
