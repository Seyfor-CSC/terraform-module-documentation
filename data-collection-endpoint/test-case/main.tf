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

resource "azurerm_resource_group" "rg" {
  name     = "SEY-DCE-RG01"
  location = local.location
}

module "dce" {
  source = "git@github.com:Seyfor-CSC/mit.data-collection-endpoint.git?ref=v2.0.0"
  config = local.dce
}

output "data_collection_endpoint" {
  value = module.dce.outputs
}
