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

# public ip prefix
module "public_ip_prefix" {
  source = "git@github.com:Seyfor-CSC/mit.public-ip-prefix.git?ref=v1.4.0"
  config = local.pipp

  depends_on = [
    azurerm_resource_group.rg
  ]
}

output "public_ip_prefix" {
  value = module.public_ip_prefix.outputs
}
