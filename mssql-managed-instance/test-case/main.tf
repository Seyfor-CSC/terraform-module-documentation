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

# module deployment prerequisities
resource "azurerm_resource_group" "rg" {
  name     = local.naming.rg
  location = local.location
}

resource "azurerm_network_security_group" "example" {
  name                = "mi-security-group"
  location            = local.location
  resource_group_name = local.naming.rg

  depends_on = [
    azurerm_resource_group.rg
  ]
}

resource "azurerm_network_security_rule" "allow_management_inbound" {
  name                        = "allow_management_inbound"
  priority                    = 106
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_ranges     = ["9000", "9003", "1438", "1440", "1452"]
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = local.naming.rg
  network_security_group_name = azurerm_network_security_group.example.name

  depends_on = [
    azurerm_network_security_group.example
  ]
}

resource "azurerm_network_security_rule" "allow_misubnet_inbound" {
  name                        = "allow_misubnet_inbound"
  priority                    = 200
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "10.0.0.0/24"
  destination_address_prefix  = "*"
  resource_group_name         = local.naming.rg
  network_security_group_name = azurerm_network_security_group.example.name

  depends_on = [
    azurerm_network_security_group.example
  ]
}

resource "azurerm_network_security_rule" "allow_health_probe_inbound" {
  name                        = "allow_health_probe_inbound"
  priority                    = 300
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "AzureLoadBalancer"
  destination_address_prefix  = "*"
  resource_group_name         = local.naming.rg
  network_security_group_name = azurerm_network_security_group.example.name

  depends_on = [
    azurerm_network_security_group.example
  ]
}

resource "azurerm_network_security_rule" "allow_tds_inbound" {
  name                        = "allow_tds_inbound"
  priority                    = 1000
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "1433"
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "*"
  resource_group_name         = local.naming.rg
  network_security_group_name = azurerm_network_security_group.example.name

  depends_on = [
    azurerm_network_security_group.example
  ]
}

resource "azurerm_network_security_rule" "deny_all_inbound" {
  name                        = "deny_all_inbound"
  priority                    = 4096
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = local.naming.rg
  network_security_group_name = azurerm_network_security_group.example.name

  depends_on = [
    azurerm_network_security_group.example
  ]
}

resource "azurerm_network_security_rule" "allow_management_outbound" {
  name                        = "allow_management_outbound"
  priority                    = 102
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_ranges     = ["80", "443", "12000"]
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = local.naming.rg
  network_security_group_name = azurerm_network_security_group.example.name

  depends_on = [
    azurerm_network_security_group.example
  ]
}

resource "azurerm_network_security_rule" "allow_misubnet_outbound" {
  name                        = "allow_misubnet_outbound"
  priority                    = 200
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "10.0.0.0/24"
  destination_address_prefix  = "*"
  resource_group_name         = local.naming.rg
  network_security_group_name = azurerm_network_security_group.example.name

  depends_on = [
    azurerm_network_security_group.example
  ]
}

resource "azurerm_network_security_rule" "deny_all_outbound" {
  name                        = "deny_all_outbound"
  priority                    = 4096
  direction                   = "Outbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = local.naming.rg
  network_security_group_name = azurerm_network_security_group.example.name

  depends_on = [
    azurerm_network_security_group.example
  ]
}

resource "azurerm_virtual_network" "example" {
  name                = "vnet-mi"
  resource_group_name = local.naming.rg
  address_space       = ["10.0.0.0/16"]
  location            = local.location

  depends_on = [
    azurerm_resource_group.rg
  ]
}

resource "azurerm_subnet" "example" {
  name                 = "subnet-mi"
  resource_group_name  = local.naming.rg
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.0.0/24"]
  delegation {
    name = "managedInstanceDelegation"
    service_delegation {
      name    = "Microsoft.Sql/managedInstances"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action", "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"]
    }
  }

  depends_on = [
    azurerm_virtual_network.example
  ]
}

data "azurerm_subnet" "example" {
  resource_group_name  = local.naming.rg
  virtual_network_name = azurerm_virtual_network.example.name
  name                 = azurerm_subnet.example.name
}

resource "azurerm_subnet_network_security_group_association" "example" {
  subnet_id                 = azurerm_subnet.example.id
  network_security_group_id = azurerm_network_security_group.example.id

  depends_on = [
    azurerm_subnet.example,
    azurerm_network_security_group.example
  ]
}

resource "azurerm_route_table" "example" {
  name                          = "routetable-mi"
  location                      = local.location
  resource_group_name           = local.naming.rg
  disable_bgp_route_propagation = false

  depends_on = [
    azurerm_subnet.example
  ]
}

resource "azurerm_subnet_route_table_association" "example" {
  subnet_id      = azurerm_subnet.example.id
  route_table_id = azurerm_route_table.example.id

  depends_on = [
    azurerm_subnet.example,
    azurerm_route_table.example
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

# mssql managed instance
module "mssql_managed_instance" {
  source = "git@github.com:Seyfor-CSC/mit.mssql-managed-instance.git?ref=v1.3.1"
  config = local.mi

  depends_on = [
    azurerm_log_analytics_workspace.la,
    azurerm_subnet_network_security_group_association.example,
    azurerm_subnet_route_table_association.example
  ]
}

output "mssql_managed_instance" {
  value = module.mssql_managed_instance.outputs
}
