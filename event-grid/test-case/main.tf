terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.108.0"
    }
  }
  backend "local" {}
}

provider "azurerm" {
  skip_provider_registration = false
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = local.naming.rg
  location = local.location
  tags     = local.tags
}

resource "azurerm_storage_account" "sa" {
  name                     = "seyterraformnesa01"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = local.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = local.tags
}

module "eventgrid" {
  source = "git@github.com:Seyfor-CSC/mit.event-grid.git?ref=v1.0.0"
  config = local.eventgrid
}

output "eventgrid" {
  value = module.eventgrid.outputs

}
