terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.77.0"
    }
  }
  backend "local" {}
}

provider "azurerm" {
  resource_provider_registrations = "core"
  resource_providers_to_register  = ["Microsoft.Search"]
  features {}
}

# module deployment prerequisites
resource "azurerm_resource_group" "rg" {
  name     = local.naming.rg
  location = local.location
}

# private endpoint prerequisites
resource "azurerm_virtual_network" "vnet" {
  name                = "SEY-SEARCH-NE-VNET01"
  location            = local.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.10.0.0/28"]
}

resource "azurerm_subnet" "subnet" {
  name                 = "sey-search-ne-subnet01"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.10.0.0/28"]
}

resource "azurerm_private_dns_zone" "dns" {
  name                = "sey.search.private.dns"
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "dns_link" {
  name                  = "SEY-SEARCH-NE-VNET01"
  resource_group_name   = azurerm_resource_group.rg.name
  private_dns_zone_name = azurerm_private_dns_zone.dns.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
}

# monitoring prerequisites
resource "azurerm_log_analytics_workspace" "la" {
  name                = "SEY-SEARCH-NE-LA01"
  location            = local.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

# search service
module "search_service" {
  source = "git@github.com:Seyfor-CSC/mit.search-service.git?ref=v2.1.0"
  config = local.config

  depends_on = [azurerm_private_dns_zone_virtual_network_link.dns_link]
}

output "search_service" {
  value = module.search_service.outputs
}