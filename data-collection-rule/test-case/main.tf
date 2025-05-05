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

# module deployment prerequisities
resource "azurerm_resource_group" "rg" {
  name     = "SEY-DCR-NE-RG01"
  location = local.location
}

resource "azurerm_log_analytics_workspace" "la" {
  name                = "SEY-DCR-NE-LA01"
  location            = local.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_storage_account" "sa" {
  name                     = "seydcrnesa01"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = local.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "container" {
  name               = "seydcrnec01"
  storage_account_id = azurerm_storage_account.sa.id
}

resource "azurerm_monitor_data_collection_endpoint" "example" {
  name                = "SEY-DCR-NE-DCE01"
  resource_group_name = azurerm_resource_group.rg.name
  location            = local.location

  lifecycle {
    create_before_destroy = true
  }
}

# data collection rule
module "data_collection_rule" {
  source = "git@github.com:Seyfor-CSC/mit.data-collection-rule.git?ref=v2.3.1"
  config = local.dcr
}

output "data_collection_rule" {
  value = module.data_collection_rule.outputs
}
