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

resource "azurerm_application_insights" "ai" {
  name                = "appinsight01"
  location            = local.location
  resource_group_name = local.naming.rg
  application_type    = "web"

  depends_on = [
    azurerm_resource_group.rg
  ]
}

resource "azurerm_storage_account" "sa" {
  name                     = "seyterraformexample01"
  resource_group_name      = local.naming.rg
  location                 = local.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  depends_on = [
    azurerm_resource_group.rg
  ]
}

# monitor alert
module "monitor_alert" {
  source = "git@github.com:Seyfor-CSC/mit.monitor-alert.git?ref=v1.1.0"
  config = local.alerts

  depends_on = [
    azurerm_application_insights.ai,
    azurerm_storage_account.sa
  ]
}
