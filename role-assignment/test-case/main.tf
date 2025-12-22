terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.56.0"
    }
  }
  backend "local" {}
}

provider "azurerm" {
  resource_provider_registrations = "core"
  features {}
}

# module deployment prerequisites
data "azurerm_client_config" "azurerm_client_config" {}
resource "azurerm_resource_group" "rg" {
  name     = local.naming.rg
  location = local.location
}

resource "azurerm_automation_account" "aa" {
  name                = local.naming.aa
  location            = local.location
  resource_group_name = azurerm_resource_group.rg.name
  sku_name            = "Free"
}

# role assignment
module "role_assignment" {
  source = "git@github.com:Seyfor-CSC/mit.role-assignment.git?ref=v2.5.0"
  config = local.rbac
}

output "role_assignment" {
  value = module.role_assignment.outputs
}
