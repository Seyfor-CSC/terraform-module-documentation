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

resource "azurerm_virtual_network" "example" {
  name                = "example-network"
  address_space       = ["10.0.0.0/16"]
  location            = local.location
  resource_group_name = local.naming.rg

  depends_on = [
    azurerm_resource_group.rg
  ]
}

resource "azurerm_subnet" "example" {
  name                 = "internal"
  resource_group_name  = local.naming.rg
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.2.0/24"]

  depends_on = [
    azurerm_virtual_network.example
  ]
}

resource "azurerm_network_interface" "example1" {
  name                = "example-nic1"
  location            = local.location
  resource_group_name = local.naming.rg

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
  }

  depends_on = [
    azurerm_resource_group.rg
  ]
}

resource "azurerm_network_interface" "example2" {
  name                = "example-nic2"
  location            = local.location
  resource_group_name = local.naming.rg

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
  }

  depends_on = [
    azurerm_resource_group.rg
  ]
}

resource "azurerm_windows_virtual_machine" "example1" {
  name                = "SEY-VM1"
  resource_group_name = local.naming.rg
  location            = local.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  network_interface_ids = [
    azurerm_network_interface.example1.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }

  depends_on = [
    azurerm_subnet.example,
    azurerm_network_interface.example1
  ]
}

resource "azurerm_windows_virtual_machine" "example2" {
  name                = "SEY-VM2"
  resource_group_name = local.naming.rg
  location            = local.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  network_interface_ids = [
    azurerm_network_interface.example2.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

  depends_on = [
    azurerm_subnet.example,
    azurerm_network_interface.example2
  ]
}

# shared image gallery
module "shared_image_gallery" {
  source = "git@github.com:Seyfor-CSC/mit.shared-image-gallery.git?ref=v1.3.0"
  config = local.acg

  depends_on = [
    azurerm_resource_group.rg,
    azurerm_windows_virtual_machine.example1,
    azurerm_windows_virtual_machine.example2
  ]
}

output "shared_image_gallery" {
  value = module.shared_image_gallery.outputs
}
