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

# module deployment prerequisites
resource "azurerm_resource_group" "rg" {
  name     = local.naming.rg
  location = local.location
}

resource "azurerm_container_app_environment" "cae" {
  name                = "SEY-ACA-ACAE01"
  location            = local.location
  resource_group_name = azurerm_resource_group.rg.name
}

# container app
module "ca" {
  source = "git@github.com:Seyfor-CSC/mit.container-app.git?ref=v2.2.1"
  config = local.ca
}

output "container_app" {
  value = module.ca.outputs
}
