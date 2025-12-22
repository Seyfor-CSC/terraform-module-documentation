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
resource "azurerm_resource_group" "rg" {
  name     = local.naming.rg
  location = local.location
}

resource "azurerm_container_app_environment" "cae" {
  name                = "SEY-ACAJ-ACAE01"
  location            = local.location
  resource_group_name = azurerm_resource_group.rg.name
}

# container app job
module "caj" {
  source = "git@github.com:Seyfor-CSC/mit.container-app-job.git?ref=v2.5.0"
  config = local.caj
}

output "container_app_job" {
  value = module.caj.outputs
}
