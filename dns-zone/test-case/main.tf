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

# dns zone
module "dns_zone" {
  source = "@github.com:Seyfor-CSC/mit.dns-zone.git?ref=v2.3.0"
  config = local.dns
}

output "dns_zone" {
  value = module.dns_zone.outputs
}
