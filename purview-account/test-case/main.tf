terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.73.0"
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

# purview account
module "purview_account" {
  source = "git@github.com:Seyfor-CSC/mit.purview-account.git?ref=v1.1.0"
  config = local.purview_account
  depends_on = [
    azurerm_resource_group.rg
  ]
}

output "outputs" {
  value = module.purview_account.outputs
}
