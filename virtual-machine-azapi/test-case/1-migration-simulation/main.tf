terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.108.0"
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
  name     = "SEY-TERRAFORM-NE-RG01"
  location = local.location
}

data "azurerm_client_config" "current" {}

resource "azurerm_managed_disk" "os_disk" {
  name                 = "${local.naming.vm_1}-osdisk"
  location             = azurerm_resource_group.rg.location
  resource_group_name  = azurerm_resource_group.rg.name
  storage_account_type = "Standard_LRS"
  hyper_v_generation   = "V1"
  os_type              = "Windows"
  disk_size_gb         = "128"
  create_option        = "FromImage"
  image_reference_id   = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/Providers/Microsoft.Compute/Locations/northeurope/Publishers/MicrosoftWindowsServer/ArtifactTypes/VMImage/Offers/WindowsServer/Skus/2022-Datacenter/Versions/20348.1970.230905"
}

resource "azurerm_managed_disk" "data_disk" {
  name                 = "${local.naming.vm_1}-data01"
  location             = azurerm_resource_group.rg.location
  resource_group_name  = azurerm_resource_group.rg.name
  storage_account_type = "StandardSSD_LRS"
  disk_size_gb         = "256"
  create_option        = "Empty"
  zone                 = "2"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "example-network"
  location            = local.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet" {
  name                 = "example-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_interface" "nic0" {
  name                = "${local.naming.vm_1}-nic0"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.1.26"
    primary                       = true
  }
  ip_configuration {
    name                          = "ipconfig2"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface" "nic1" {
  name                = "${local.naming.vm_1}-nic1"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.1.28"
    primary                       = true
  }
  ip_configuration {
    name                          = "ipconfig2"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "vm" {
  name                         = local.naming.vm_1
  location                     = azurerm_resource_group.rg.location
  resource_group_name          = azurerm_resource_group.rg.name
  network_interface_ids        = [azurerm_network_interface.nic0.id, azurerm_network_interface.nic1.id]
  primary_network_interface_id = azurerm_network_interface.nic0.id
  vm_size                      = "Standard_D2s_v3"
  os_profile_windows_config {
    provision_vm_agent = true
  }
  storage_os_disk {
    name              = "${local.naming.vm_1}-osdisk"
    caching           = "ReadWrite"
    create_option     = "Attach"
    managed_disk_type = "Standard_LRS"
    managed_disk_id   = azurerm_managed_disk.os_disk.id
    os_type           = "Windows"
  }
}
