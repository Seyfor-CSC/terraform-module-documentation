
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

# monitoring prerequisites
resource "azurerm_log_analytics_workspace" "la" {
  name                = "SEY-FD-NE-LA01"
  location            = local.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}
resource "azurerm_eventhub_namespace" "eventhub_namespace" {
  name                = "SEY-FD-NE-EVHNS01"
  location            = local.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Basic"
  capacity            = 2
}
resource "azurerm_eventhub" "eventhub" {
  name              = "sey-fd-ne-evh01"
  namespace_id      = azurerm_eventhub_namespace.eventhub_namespace.id
  partition_count   = 2
  message_retention = 1
}

# frontdoor
module "frontdoor" {
  source = "git@github.com:Seyfor-CSC/mit.frontdoor.git?ref=v2.1.0"
  config = local.frontdoor
}

output "frontdoor" {
  value = module.frontdoor.outputs
}
