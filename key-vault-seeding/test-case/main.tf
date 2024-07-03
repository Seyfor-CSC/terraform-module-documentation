terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.108.0"
    }
  }
  backend "local" {}
}

provider "azurerm" {
  skip_provider_registration = false
  features {}
}

# module deployment prerequisites
data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "rg" {
  name     = local.naming.rg
  location = local.location
}

resource "azurerm_key_vault" "kv" {
  name                       = local.naming.kv
  location                   = azurerm_resource_group.rg.location
  resource_group_name        = azurerm_resource_group.rg.name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "premium"
  soft_delete_retention_days = 7
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id
    secret_permissions = [
      "Set",
      "List",
      "Get",
      "Delete",
      "Purge",
      "Recover"
    ]
  }
}


resource "azurerm_role_assignment" "rbac" {
  role_definition_name = "Key Vault Secrets Officer"
  scope                = azurerm_key_vault.kv.id
  principal_id         = data.azurerm_client_config.current.object_id
}

# key vault seeding
module "seeding" {
  source = "git@github.com:Seyfor-CSC/mit.key-vault-seeding.git?ref=v1.4.0"
  config = local.seeding
}

output "seeding" {
  value = module.seeding.outputs
}
