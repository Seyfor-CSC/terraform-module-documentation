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

# monitoring prerequisites
resource "azurerm_log_analytics_workspace" "la" {
  name                = "SEY-PIPPREFIX-NE-LA01"
  location            = local.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

# public ip prefix
module "public_ip_prefix" {
  source = "git@github.com:Seyfor-CSC/mit.public-ip-prefix.git?ref=v2.4.0"
  config = local.pipp
}

output "public_ip_prefix" {
  value = module.public_ip_prefix.outputs
}
