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
data "azurerm_subscription" "primary" {}

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

resource "azurerm_network_interface" "nic" {
  name                = "example-nic"
  location            = local.location
  resource_group_name = local.naming.rg

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }

  depends_on = [
    azurerm_subnet.subnet
  ]
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                            = "example-machine"
  resource_group_name             = local.naming.rg
  location                        = local.location
  size                            = "Standard_F2"
  admin_username                  = "adminuser"
  admin_password                  = "Password1234"
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.nic.id
  ]
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  depends_on = [
    azurerm_network_interface.nic
  ]
}

# private endpoint prerequisities
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

# recovery services vault
module "recovery_services_vault" {
  source = "git@github.com:Seyfor-CSC/mit.recovery-services-vault.git?ref=v1.3.0"
  config = local.rsv

  depends_on = [
    azurerm_private_dns_zone_virtual_network_link.dns_link,
    azurerm_log_analytics_workspace.la,
    azurerm_linux_virtual_machine.vm
  ]
}

output "recovery_services_vault" {
  value = module.recovery_services_vault.outputs
}
