terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.56.0"
    }
  }
  backend "local" {}
}

provider "azurerm" {
  resource_provider_registrations = "core"
  features {}
}

data "azurerm_client_config" "current" {}

# module deployment prerequisities
resource "azurerm_resource_group" "rg" {
  name     = local.naming.rg
  location = local.location
}

# private endpoint prerequisities
resource "azurerm_virtual_network" "vnet" {
  name                = "SEY-MANAGEDREDIS-NE-VNET01"
  location            = local.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/28"]
}

resource "azurerm_subnet" "subnet" {
  name                 = "sey-managedredis-ne-subnet01"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.0.0/29"]
}

resource "azurerm_private_dns_zone" "dns" {
  name                = "sey.managedredis.private.dns"
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "dns_link" {
  name                  = "SEY-MANAGEDREDIS-NE-VNET01"
  resource_group_name   = azurerm_resource_group.rg.name
  private_dns_zone_name = azurerm_private_dns_zone.dns.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
}

# monitoring prerequisities
resource "azurerm_log_analytics_workspace" "la" {
  name                = "SEY-MANAGEDREDIS-NE-LA01"
  location            = local.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

# managed redis
module "managed_redis" {
  source     = "git@github.com:Seyfor-CSC/mit.managed-redis.git?ref=v2.0.0"
  config     = local.managed_redis
  depends_on = [azurerm_private_dns_zone_virtual_network_link.dns_link]
}

output "managed_redis" {
  value = module.managed_redis.outputs
}

