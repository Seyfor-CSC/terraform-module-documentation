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

# monitoring prerequisities
resource "azurerm_log_analytics_workspace" "la" {
  name                = "SEY-TERRAFORM-NE-LA01"
  location            = local.location
  resource_group_name = local.naming.rg
  sku                 = "PerGB2018"
  retention_in_days   = 30

  depends_on = [
    azurerm_resource_group.rg
  ]
}

# public ip address
module "public_ip_address" {
  source = "git@github.com:Seyfor-CSC/mit.public-ip-address.git?ref=v1.4.1"
  config = local.pip

  depends_on = [
    azurerm_log_analytics_workspace.la
  ]
}

output "public_ip_address" {
  value = module.public_ip_address.outputs
}
