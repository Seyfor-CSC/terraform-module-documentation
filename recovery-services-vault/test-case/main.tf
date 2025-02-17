terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.14.0"
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
  name     = local.naming.rg
  location = local.location
}

# private endpoint prerequisities
resource "azurerm_virtual_network" "vnet" {
  name                = "SEY-RSV-NE-VNET01"
  location            = local.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet" {
  name                 = "sey-rsv-ne-subnet01"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_private_dns_zone" "dns" {
  name                = "sey.rsv.private.dns"
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "dns_link" {
  name                  = "SEY-RESV-NE-VNET02"
  resource_group_name   = azurerm_resource_group.rg.name
  private_dns_zone_name = azurerm_private_dns_zone.dns.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
}

# monitoring prerequisities
resource "azurerm_log_analytics_workspace" "la" {
  name                = "SEY-RSV-NE-LA01"
  location            = local.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_eventhub_namespace" "eventhub_namespace" {
  name                = "SEY-RSV-NE-EVHNS01"
  location            = local.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Basic"
  capacity            = 2
}

resource "azurerm_eventhub" "eventhub" {
  name              = "SEY-RSV-NE-EVH01"
  namespace_id      = azurerm_eventhub_namespace.eventhub_namespace.id
  partition_count   = 2
  message_retention = 1
}

# recovery services vault
module "recovery_services_vault" {
  source = "git@github.com:Seyfor-CSC/mit.recovery-services-vault.git?ref=v2.2.0"
  config = local.rsv
}

output "recovery_services_vault" {
  value = module.recovery_services_vault.outputs
}
