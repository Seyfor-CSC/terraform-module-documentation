terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.96.0"
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

data "azurerm_client_config" "current" {}

# monitoring prerequisities
resource "azurerm_log_analytics_workspace" "la" {
  name                = "SEY-TERRAFORM-NE-LA01"
  location            = local.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

# postgresql flexible server
module "postgresql_flexible_server" {
  source = "git@github.com:Seyfor-CSC/mit.postgresql-flexible-server.git?ref=v1.4.0"
  config = local.pgsql
}

output "postgresql_flexible_server" {
  value = module.postgresql_flexible_server.outputs
}
