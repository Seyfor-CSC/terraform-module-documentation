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
resource "azurerm_resource_group" "rg" {
  name     = local.naming.rg
  location = local.location
}

resource "azurerm_application_insights" "ai" {
  name                = "SEY-ALERT-NE-AI01"
  location            = local.location
  resource_group_name = azurerm_resource_group.rg.name
  application_type    = "web"
}

resource "azurerm_storage_account" "sa" {
  name                     = "seyalertnesa01"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = local.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_monitor_action_group" "ag" {
  name                = "SEY-ALERT-NE-AG01"
  resource_group_name = azurerm_resource_group.rg.name
  short_name          = "SEYALERTAG01"
}

# monitor alert
module "monitor_alert" {
  source = "git@github.com:Seyfor-CSC/mit.monitor-alert.git?ref=v2.3.0"
  config = local.alerts
}
