terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.84.0"
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

# dns zone
module "dns_zone" {
  source = "git@github.com:Seyfor-CSC/mit.dns-zone.git?ref=v1.1.0"
  config = local.dns

  depends_on = [
    azurerm_resource_group.rg
  ]
}

output "dns_zone" {
  value = module.dns_zone.outputs
}
