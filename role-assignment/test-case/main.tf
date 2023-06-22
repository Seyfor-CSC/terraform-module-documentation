terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.51.0"
    }
  }
  backend "local" {}
}

provider "azurerm" {
  skip_provider_registration = false
  features {}
}

# module deployment prerequisities
data "azurerm_client_config" "azurerm_client_config" {}
resource "azurerm_resource_group" "rg" {
  name     = local.naming.rg
  location = local.location
}

resource "azurerm_automation_account" "aa" {
  name                = local.naming.aa
  location            = local.location
  resource_group_name = local.naming.rg
  sku_name            = "Free"

  depends_on = [
    azurerm_resource_group.rg
  ]
}

# role assignment
module "role_assignment" {
  source = "git@github.com:Seyfor-CSC/mit.role-assignment.git?ref=v1.1.1"
  config = local.rbac

  depends_on = [
    azurerm_resource_group.rg,
    azurerm_automation_account.aa
  ]
}

output "role_assignment" {
  value = module.role_assignment.outputs
}
