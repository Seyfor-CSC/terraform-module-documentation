terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.105.0"
    }
  }
  backend "local" {}
}

provider "azurerm" {
  skip_provider_registration = false
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = local.naming.rg
  location = local.location
}

resource "azurerm_container_app_environment" "cae" {
  name                = "sey-containerappjob-cae01"
  location            = local.location
  resource_group_name = azurerm_resource_group.rg.name
}

module "caj" {
  source = "git@github.com:Seyfor-CSC/mit.container-app-job.git?ref=v1.0.0"
  config = local.caj
}

output "container_app_job" {
  value = module.caj.outputs
}
