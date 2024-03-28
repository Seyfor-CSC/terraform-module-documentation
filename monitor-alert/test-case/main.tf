terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.96.0"
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
  resource_group_name = azurerm_resource_group.rg.name
  application_type    = "web"
}

resource "azurerm_storage_account" "sa" {
  name                     = "seyterraformexample01"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = local.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_monitor_action_group" "ag" {
  name                = "actiongroup01"
  resource_group_name = azurerm_resource_group.rg.name
  short_name          = "exampleag"
}

# monitor alert
module "monitor_alert" {
  source = "git@github.com:Seyfor-CSC/mit.monitor-alert.git?ref=v1.4.0"
  config = local.alerts
}
