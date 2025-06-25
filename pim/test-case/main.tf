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
data "azurerm_subscription" "primary" {}

data "azurerm_client_config" "example" {}

data "azurerm_role_definition" "reader" {
  name = "Reader"
}

data "azurerm_role_definition" "contributor" {
  name = "Contributor"
}

# pim
module "pim" {
  source = "git@github.com:Seyfor-CSC/mit.pim.git?ref=v2.1.0"
  config = local.pim
}

output "outputs" {
  value = module.pim.outputs
}
