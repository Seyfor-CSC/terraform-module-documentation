terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.33.0"
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

# maintenance configuration
module "maintenance_configuration" {
  source = "git@github.com:Seyfor-CSC/mit.maintenance-configuration.git?ref=v2.1.0"
  config = local.mc
}

output "maintenance_configuration" {
  value = module.maintenance_configuration.outputs
}
