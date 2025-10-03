terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.45.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "=3.5.0"
    }
  }
  backend "local" {}
}

provider "azurerm" {
  resource_provider_registrations = "core"
  features {}
}

# module deployment prerequisites
data "azurerm_client_config" "current" {}

data "azuread_user" "user" {
  object_id = data.azurerm_client_config.current.object_id
}

resource "azurerm_resource_group" "rg" {
  name     = "SEY-ROLEMANAGEMENTPOLICY-NE-RG01"
  location = local.location
}

data "azurerm_role_definition" "rg_contributor" {
  name  = "Contributor"
  scope = azurerm_resource_group.rg.id
}

module "role_management_policy" {
  source = "git@github.com:Seyfor-CSC/mit.role-management-policy.git?ref=v2.2.0"
  config = local.role_management_policy
}

output "role_management_policy" {
  value = module.role_management_policy.outputs
}
