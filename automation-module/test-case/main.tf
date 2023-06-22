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
resource "azurerm_resource_group" "rg" {
  name     = local.naming.rg
  location = local.location
}

resource "azurerm_automation_account" "aa" {
  name                = local.naming.aa
  location            = local.location
  resource_group_name = local.naming.rg
  sku_name            = "Basic"

  depends_on = [
    azurerm_resource_group.rg
  ]
}

# automation module
module "automation_module_parent" {
  source = "git@github.com:Seyfor-CSC/mit.automation-module.git?ref=v1.0.0"
  config = local.amp

  depends_on = [
    azurerm_automation_account.aa
  ]
}

module "automation_module_child" {
  source = "git@github.com:Seyfor-CSC/mit.automation-module.git?ref=v1.0.0"
  config = local.amd

  depends_on = [
    module.automation_module_parent
  ]
}

output "automation_module_parent" {
  value = module.automation_module_parent.outputs
}

output "automation_module_child" {
  value = module.automation_module_child.outputs
}
