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

# monitor action group
module "monitor_action_group" {
  source = "git@github.com:Seyfor-CSC/mit.monitor-action-group.git?ref=v1.0.0"
  config = local.ag

  depends_on = [
    azurerm_resource_group.rg
  ]
}

output "monitor_action_group" {
  value = module.monitor_action_group.outputs
}
