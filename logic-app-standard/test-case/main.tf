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

resource "azurerm_storage_account" "sa" {
  name                     = "seyterraformlogicsa01"
  resource_group_name      = local.naming.rg
  location                 = local.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  depends_on = [
    azurerm_resource_group.rg
  ]
}

resource "azurerm_service_plan" "asp" {
  name                = "SEY-TERRAFORM-NE-ASP01"
  resource_group_name = local.naming.rg
  location            = local.location
  os_type             = "Linux"
  sku_name            = "WS1"

  depends_on = [
    azurerm_resource_group.rg
  ]
}

# monitoring prerequisities
resource "azurerm_log_analytics_workspace" "la" {
  name                = "SEY-TERRAFORM-NE-LA01"
  location            = local.location
  resource_group_name = local.naming.rg
  sku                 = "PerGB2018"
  retention_in_days   = 30

  depends_on = [
    azurerm_resource_group.rg
  ]
}

# logic app standard
module "logic_app_standard" {
  source = "git@github.com:Seyfor-CSC/mit.logic-app-standard.git?ref=v1.1.0"
  config = local.logic

  depends_on = [
    azurerm_resource_group.rg,
    azurerm_service_plan.asp,
    azurerm_storage_account.sa
  ]
}

output "logic_app_standard" {
  value = module.logic_app_standard.outputs
}
