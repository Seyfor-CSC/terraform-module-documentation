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
  skip_provider_registration = false
  features {}
}

# module deployment prerequisites
resource "azurerm_resource_group" "rg" {
  name     = local.naming.rg
  location = local.location
}

resource "azurerm_virtual_network" "vnet" {
  name                = "example-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = local.location
  resource_group_name = local.naming.rg

  depends_on = [
    azurerm_resource_group.rg
  ]
}

resource "azurerm_subnet" "subnet" {
  name                 = "internal"
  resource_group_name  = local.naming.rg
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]

  depends_on = [
    azurerm_virtual_network.vnet
  ]
}

resource "azurerm_public_ip_prefix" "prefix" {
  name                = "sey-pip"
  location            = local.location
  resource_group_name = local.naming.rg

  depends_on = [
    azurerm_resource_group.rg
  ]
}


# monitoring prerequisites
resource "azurerm_log_analytics_workspace" "la" {
  name                = "SEY-VMSS-NE-LA01"
  location            = local.location
  resource_group_name = local.naming.rg
  sku                 = "PerGB2018"
  retention_in_days   = 30

  depends_on = [
    azurerm_resource_group.rg
  ]
}

# virtual machine scale set
module "vmss" {
  source = "git@github.com:Seyfor-CSC/mit.virtual-machine-scale-set.git?ref=v1.2.1"
  config = local.vmss

  depends_on = [
    azurerm_subnet.subnet,
    azurerm_public_ip_prefix.prefix,
    azurerm_log_analytics_workspace.la
  ]
}

output "vmss" {
  value = module.vmss.outputs
}
