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

resource "azurerm_monitor_data_collection_rule" "dcr" {
  name                = "dcr"
  resource_group_name = local.naming.rg
  location            = local.location
  destinations {
    azure_monitor_metrics {
      name = "example-destination-metrics"
    }
  }
  data_flow {
    streams      = ["Microsoft-InsightsMetrics"]
    destinations = ["example-destination-metrics"]
  }

  depends_on = [
    azurerm_resource_group.rg
  ]

}

# windows virtual machine
module "windows_virtual_machine" {
  source = "git@github.com:Seyfor-CSC/mit.windows-virtual-machine.git?ref=v1.3.1"
  config = local.vm

  depends_on = [
    azurerm_subnet.subnet,
    azurerm_monitor_data_collection_rule.dcr,
    azurerm_resource_group.rg
  ]
}

output "windows_virtual_machine" {
  value = module.windows_virtual_machine.outputs
}
