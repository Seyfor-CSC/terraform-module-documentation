terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.73.0"
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

resource "azurerm_service_plan" "windows_plan" {
  name                = "SEY-WINDOWS-NE-ASP01"
  location            = local.location
  resource_group_name = local.naming.rg
  os_type             = "Windows"
  sku_name            = "P1v2"

  depends_on = [
    azurerm_resource_group.rg
  ]
}

resource "azurerm_service_plan" "linux_plan" {
  name                = "SEY-LINUX-NE-ASP01"
  location            = local.location
  resource_group_name = local.naming.rg
  os_type             = "Linux"
  sku_name            = "P1v2"

  depends_on = [
    azurerm_resource_group.rg
  ]
}

# private endpoint prerequisities
resource "azurerm_virtual_network" "vnet" {
  name                = "example-network"
  location            = local.location
  resource_group_name = local.naming.rg
  address_space       = ["10.0.0.0/16"]

  depends_on = [
    azurerm_resource_group.rg
  ]
}

resource "azurerm_subnet" "subnet" {
  name                 = "example-subnet"
  resource_group_name  = local.naming.rg
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
  depends_on = [
    azurerm_virtual_network.vnet
  ]
}

resource "azurerm_private_dns_zone" "dns" {
  name                = "test.private.dns"
  resource_group_name = local.naming.rg

  depends_on = [
    azurerm_resource_group.rg
  ]
}

resource "azurerm_private_dns_zone_virtual_network_link" "dns_link" {
  name                  = "test"
  resource_group_name   = local.naming.rg
  private_dns_zone_name = azurerm_private_dns_zone.dns.name
  virtual_network_id    = azurerm_virtual_network.vnet.id

  depends_on = [
    azurerm_private_dns_zone.dns,
    azurerm_virtual_network.vnet
  ]
}

# monitoring prerequisities
resource "azurerm_log_analytics_workspace" "la" {
  name                = "SEY-TERRAFORM-NE-LA01"
  location            = local.location
  resource_group_name = local.naming.rg
  sku                 = "PerGB2018"
  retention_in_days   = 30

  depends_on = [
    azurerm_resource_group.rg
  ]
}

# app service
module "app_service" {
  source = "git@github.com:Seyfor-CSC/mit.app-service.git?ref=v1.3.0"
  config = local.app

  depends_on = [
    azurerm_private_dns_zone_virtual_network_link.dns_link,
    azurerm_log_analytics_workspace.la,
    azurerm_service_plan.windows_plan,
    azurerm_service_plan.linux_plan
  ]
}

output "app_service" {
  value = module.app_service.outputs
}
