terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.84.0"
    }
  }
  backend "local" {}
}

provider "azurerm" {
  skip_provider_registration = true
  features {}
}

# module deployment prerequisites
resource "azurerm_resource_group" "rg" {
  name     = local.naming.rg
  location = local.location
}

resource "azurerm_monitor_action_group" "ag1" {
  name                = "mit-actiongroup01"
  resource_group_name = azurerm_resource_group.rg.name
  short_name          = "action1"
}

resource "azurerm_monitor_action_group" "ag2" {
  name                = "mit-actiongroup02"
  resource_group_name = azurerm_resource_group.rg.name
  short_name          = "action2"
}

resource "azurerm_storage_account" "sa" {
  name                     = "mitmonitorsa01"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = local.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_monitor_metric_alert" "alert" {
  name                = "example-metricalert"
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
  source = "git@github.com:Seyfor-CSC/mit.monitor-alert-processing-rule.git?ref=v1.0.0"
  config = local.apr

  depends_on = [
    azurerm_resource_group.rg,
    azurerm_monitor_action_group.ag1,
    azurerm_monitor_action_group.ag2,
    azurerm_storage_account.sa,
    azurerm_monitor_metric_alert.alert
  ]
}
