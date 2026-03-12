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

# module deployment prerequisites
resource "azurerm_resource_group" "rg" {
  name     = local.naming.rg
  location = local.location
}

resource "azurerm_virtual_network" "vnet" {
  name                = "SEY-CR-WE-VNET01"
  location            = local.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet" {
  name                 = "sey-cr-we-subnet01"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_capacity_reservation_group" "crg" {
  name                = local.naming.crg
  resource_group_name = azurerm_resource_group.rg.name
  location            = local.location
  zones               = ["1", "2"]
}

# capacity reservation module - must be created BEFORE VMs
module "capacity_reservation" {
  source = "git@github.com:Seyfor-CSC/mit.solution.capacity-reservation.git?ref=v2.0.0"

  config = [
    {
      capacity_reservation_group_id = azurerm_capacity_reservation_group.crg.id
      location                      = local.location
      vm_config                     = local.vm
      tags = {
        Environment = "Production"
      }
    }
  ]
}

# virtual machines - depend on capacity reservations
module "vms" {
  source = "git@github.com:Seyfor-CSC/mit.virtual-machine.git?ref=v2.5.2"
  config = local.vm

  depends_on = [
    module.capacity_reservation
  ]
}

output "capacity_reservation" {
  value = module.capacity_reservation.outputs
}
