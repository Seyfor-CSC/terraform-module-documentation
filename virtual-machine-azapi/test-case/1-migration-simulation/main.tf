terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.1.0"
    }
    azapi = {
      source  = "azure/azapi"
      version = "=1.15.0"
    }
  }
  backend "local" {}
}

provider "azurerm" {
  resource_provider_registrations = "core"
  features {}
}
provider "azapi" {}

# module deployment prerequisities
resource "azurerm_resource_group" "rg" {
  name     = "SEY-AZAPIVM-NE-RG01"
  location = local.location
}

data "azurerm_client_config" "current" {}

resource "azurerm_virtual_network" "vnet" {
  name                = "SEY-AZAPIVM-NE-VNET01"
  location            = local.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet" {
  name                 = "sey-azapivm-ne-subnet01"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_interface" "nic0" {
  name                = "SEYWINDOWSVM01-nic0"
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
  name                = "${local.naming.vm_1}-nic0"
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

resource "azurerm_windows_virtual_machine" "vm" {
  name                              = "SEYWINDOWSVM01"
  resource_group_name               = azurerm_resource_group.rg.name
  location                          = azurerm_resource_group.rg.location
  size                              = "Standard_D2s_v4"
  admin_username                    = "adminuser"
  admin_password                    = "P@$$w0rd1234!"
  vm_agent_platform_updates_enabled = true
  network_interface_ids = [
    azurerm_network_interface.nic0.id
  ]

  os_disk {
    name                 = "SEYWINDOWSVM01-osdisk"
    disk_size_gb         = 128
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}

data "azurerm_managed_disk" "source-osdisk" {
  name                = "SEYWINDOWSVM01-osdisk"
  resource_group_name = azurerm_resource_group.rg.name

  depends_on = [azurerm_windows_virtual_machine.vm]
}

resource "azurerm_managed_disk" "os_disk" {
  name                 = "${local.naming.vm_1}-osdisk"
  location             = azurerm_resource_group.rg.location
  resource_group_name  = azurerm_resource_group.rg.name
  storage_account_type = "Standard_LRS"
  hyper_v_generation   = "V1"
  os_type              = "Windows"
  disk_size_gb         = "128"
  create_option        = "Copy"
  source_resource_id   = data.azurerm_managed_disk.source-osdisk.id
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

resource "azurerm_virtual_machine_data_disk_attachment" "data_disk" {
  managed_disk_id    = azurerm_managed_disk.data_disk.id
  virtual_machine_id = azapi_resource.vm.id
  lun                = 1
  caching            = "ReadWrite"
}

resource "azapi_resource" "vm" {
  type      = "Microsoft.Compute/virtualMachines@2024-07-01"
  location  = azurerm_resource_group.rg.location
  name      = local.naming.vm_1
  parent_id = azurerm_resource_group.rg.id
  body = {
    properties = {
      hardwareProfile = {
        vmSize = "Standard_D2s_v4"
      }
      networkProfile = {
        networkInterfaces = [
          {
            id = azurerm_network_interface.nic1.id
            properties = {
              primary = true
            }
          }
        ]
      }
      storageProfile = {
        osDisk = {
          caching      = "ReadWrite"
          createOption = "Attach"
          deleteOption = "Detach"
          diskSizeGB   = 128
          managedDisk = {
            id                 = azurerm_managed_disk.os_disk.id
            storageAccountType = "Standard_LRS"
          }
          name   = "${local.naming.vm_1}-osdisk"
          osType = "Windows"
        }
      }
    }
  }
}
