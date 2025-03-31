terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.23.0"
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

resource "azurerm_monitor_action_group" "ag1" {
  name                = "SEY-ALERTRULE-NE-AG01"
  resource_group_name = azurerm_resource_group.rg.name
  short_name          = "SEYRULEAG01"
}

resource "azurerm_monitor_action_group" "ag2" {
  name                = "SEY-ALERTRULE-NE-AG02"
  resource_group_name = azurerm_resource_group.rg.name
  short_name          = "SEYRULEAG02"
}

resource "azurerm_storage_account" "sa" {
  name                     = "seyalertrulenesa01"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = local.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_monitor_metric_alert" "alert" {
  name                = "sey-metricalert"
  resource_group_name = azurerm_resource_group.rg.name
  scopes              = [azurerm_storage_account.sa.id]
  description         = "Action will be triggered when Transactions count is greater than 50."

  criteria {
    metric_namespace = "Microsoft.Storage/storageAccounts"
    metric_name      = "Transactions"
    aggregation      = "Total"
    operator         = "GreaterThan"
    threshold        = 50

    dimension {
      name     = "ApiName"
      operator = "Include"
      values   = ["*"]
    }
  }

  action {
    action_group_id = azurerm_monitor_action_group.ag1.id
  }
}

# monitor alert processing rule
module "apr" {
  source = "git@github.com:Seyfor-CSC/mit.monitor-alert-processing-rule.git?ref=v2.2.0"
  config = local.apr
}
