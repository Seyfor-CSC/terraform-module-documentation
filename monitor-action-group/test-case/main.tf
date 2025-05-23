terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.23.0"
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

# monitor action group
module "monitor_action_group" {
  source = "git@github.com:Seyfor-CSC/mit.monitor-action-group.git?ref=v2.2.2"
  config = local.ag
}

output "monitor_action_group" {
  value = module.monitor_action_group.outputs
}
