
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

resource "azurerm_public_ip" "pip1" {
  name                = "public-ip-1"
  location            = local.location
  resource_group_name = local.naming.rg
  sku                 = "Standard"
  allocation_method   = "Static"

  depends_on = [
    azurerm_resource_group.rg
  ]
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet"
  address_space       = ["10.0.0.0/16"]
  location            = local.location
  resource_group_name = local.naming.rg

  depends_on = [
    azurerm_resource_group.rg
  ]
}

resource "azurerm_subnet" "subnet" {
  name                 = "subnet"
  resource_group_name  = local.naming.rg
  virtual_network_name = "vnet"
  address_prefixes     = ["10.0.2.0/24"]

  depends_on = [
    azurerm_virtual_network.vnet
  ]
}

resource "azurerm_network_interface" "nic0" {
  name                = local.naming.nic_0
  location            = local.location
  resource_group_name = local.naming.rg

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.2.4"
  }

  depends_on = [
    azurerm_subnet.subnet
  ]
}

resource "azurerm_network_interface" "nic1" {
  name                = local.naming.nic_1
  location            = local.location
  resource_group_name = local.naming.rg

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.2.100"
  }

  depends_on = [
    azurerm_subnet.subnet
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

# load balancer
module "load_balancer" {
  source ="git@github.com:Seyfor-CSC/mit.load-balancer.git?ref=v1.2.0"
  config = local.lb

  depends_on = [
    azurerm_resource_group.rg,
    azurerm_public_ip.pip1,
    azurerm_network_interface.nic0,
    azurerm_network_interface.nic1
  ]
}

output "load_balancer" {
  value = module.load_balancer.outputs
}
