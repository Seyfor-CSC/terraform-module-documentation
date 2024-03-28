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
  name     = "SEY-TERRAFORM-NE-RG01"
  location = local.location
}

resource "azurerm_log_analytics_workspace" "la" {
  name                = "SEY-TERRAFORM-NE-LA01"
  location            = local.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_storage_account" "sa" {
  name                     = "seyterraformdcrnesa01"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = local.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "container" {
  name                 = "mittestsac01"
  storage_account_name = azurerm_storage_account.sa.name
}

resource "azurerm_monitor_data_collection_endpoint" "example" {
  name                = "example-dcre"
  resource_group_name = azurerm_resource_group.rg.name
  location            = local.location

  lifecycle {
    create_before_destroy = true
  }
}

# data collection rule
module "data_collection_rule" {
  source = "git@github.com:Seyfor-CSC/mit.data-collection-rule.git?ref=v1.4.0"
  config = local.dcr
}

output "data_collection_rule" {
  value = module.data_collection_rule.outputs
}
