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

# container instance
module "container_instance" {
  source = "git@github.com:Seyfor-CSC/mit.container-instance.git?ref=v1.3.0"
  config = local.cg

  depends_on = [
    azurerm_resource_group.rg
  ]
}

output "container_instance" {
  value = module.container_instance.outputs
}
