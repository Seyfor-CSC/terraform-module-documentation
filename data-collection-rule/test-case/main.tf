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

resource "azurerm_log_analytics_workspace" "la" {
  name                = local.naming.la
  location            = local.location
  resource_group_name = local.naming.rg
  sku                 = "PerGB2018"
  retention_in_days   = 30

  depends_on = [
    azurerm_resource_group.rg
  ]
}

resource "azurerm_storage_account" "sa" {
  name                     = local.naming.sa
  resource_group_name      = local.naming.rg
  location                 = local.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  depends_on = [
    azurerm_resource_group.rg
  ]
}

resource "azurerm_storage_container" "container" {
  name                 = "mittestsac01"
  storage_account_name = local.naming.sa

  depends_on = [
    azurerm_storage_account.sa
  ]
}

resource "azurerm_monitor_data_collection_endpoint" "example" {
  name                = "example-dcre"
  resource_group_name = local.naming.rg
  location            = local.location

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [
    azurerm_resource_group.rg
  ]
}

# data collection rule
module "data_collection_rule" {
  source = "git@github.com:Seyfor-CSC/mit.data-collection-rule.git?ref=v1.1.0"
  config = local.dcr

  depends_on = [
    azurerm_log_analytics_workspace.la,
    azurerm_storage_container.container,
    azurerm_monitor_data_collection_endpoint.example
  ]
}

output "data_collection_rule" {
  value = module.data_collection_rule.outputs
}
