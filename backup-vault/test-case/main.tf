terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.67.0"
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

# backup vault
module "backup_vault" {
  source = "git@github.com:Seyfor-CSC/mit.backup-vault.git?ref=v1.2.1"
  config = local.bv

  depends_on = [
    azurerm_resource_group.rg
  ]
}

output "backup_vault" {
  value = module.backup_vault.outputs
}
