locals {
  location = "westeurope"

  naming = {
    rg   = "SEY-TERRAFORM-WE-RG01"
    crg  = "SEY-CR-NE-CRG01"
    vm_1 = "SEYCRVM01"
    vm_2 = "SEYCRVM02"
    vm_3 = "SEYCRVM03"
    vm_4 = "SEYCRVM04"
    vm_5 = "SEYCRVM05"
  }

  vm = [
    {
      os_type                         = "Linux"
      name                            = local.naming.vm_1
      location                        = local.location
      resource_group_name             = azurerm_resource_group.rg.name
      size                            = "Standard_B1s"
      zone                            = "1"
      use_capacity_reservation        = true
      capacity_reservation_group_id   = azurerm_capacity_reservation_group.crg.id
      admin_username                  = "adminuser"
      admin_password                  = "Password1234!"
      disable_password_authentication = false
      os_disk = {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
      }
      source_image_reference = {
        publisher = "Canonical"
        offer     = "0001-com-ubuntu-server-jammy"
        sku       = "22_04-lts-gen2"
        version   = "latest"
      }
      network_interfaces = [
        {
          name = "${local.naming.vm_1}-nic"
          ip_configuration = [
            {
              name                          = "ipconfig1"
              subnet_id                     = azurerm_subnet.subnet.id
              private_ip_address_allocation = "Dynamic"
            }
          ]
        }
      ]
    },
    {
      os_type                         = "Linux"
      name                            = local.naming.vm_2
      location                        = local.location
      resource_group_name             = azurerm_resource_group.rg.name
      size                            = "Standard_B1s"
      zone                            = "1"
      use_capacity_reservation        = true
      capacity_reservation_group_id   = azurerm_capacity_reservation_group.crg.id
      admin_username                  = "adminuser"
      admin_password                  = "Password1234!"
      disable_password_authentication = false
      os_disk = {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
      }
      source_image_reference = {
        publisher = "Canonical"
        offer     = "0001-com-ubuntu-server-jammy"
        sku       = "22_04-lts-gen2"
        version   = "latest"
      }
      network_interfaces = [
        {
          name = "${local.naming.vm_2}-nic"
          ip_configuration = [
            {
              name                          = "ipconfig1"
              subnet_id                     = azurerm_subnet.subnet.id
              private_ip_address_allocation = "Dynamic"
            }
          ]
        }
      ]
    },
    {
      os_type                         = "Linux"
      name                            = local.naming.vm_3
      location                        = local.location
      resource_group_name             = azurerm_resource_group.rg.name
      size                            = "Standard_B1s"
      zone                            = "2"
      use_capacity_reservation        = true
      capacity_reservation_group_id   = azurerm_capacity_reservation_group.crg.id
      admin_username                  = "adminuser"
      admin_password                  = "Password1234!"
      disable_password_authentication = false
      os_disk = {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
      }
      source_image_reference = {
        publisher = "Canonical"
        offer     = "0001-com-ubuntu-server-jammy"
        sku       = "22_04-lts-gen2"
        version   = "latest"
      }
      network_interfaces = [
        {
          name = "${local.naming.vm_3}-nic"
          ip_configuration = [
            {
              name                          = "ipconfig1"
              subnet_id                     = azurerm_subnet.subnet.id
              private_ip_address_allocation = "Dynamic"
            }
          ]
        }
      ]
    },
    {
      os_type                         = "Linux"
      name                            = local.naming.vm_4
      location                        = local.location
      resource_group_name             = azurerm_resource_group.rg.name
      size                            = "Standard_B2s"
      zone                            = "1"
      use_capacity_reservation        = true
      capacity_reservation_group_id   = azurerm_capacity_reservation_group.crg.id
      admin_username                  = "adminuser"
      admin_password                  = "Password1234!"
      disable_password_authentication = false
      os_disk = {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
      }
      source_image_reference = {
        publisher = "Canonical"
        offer     = "0001-com-ubuntu-server-jammy"
        sku       = "22_04-lts-gen2"
        version   = "latest"
      }
      network_interfaces = [
        {
          name = "${local.naming.vm_4}-nic"
          ip_configuration = [
            {
              name                          = "ipconfig1"
              subnet_id                     = azurerm_subnet.subnet.id
              private_ip_address_allocation = "Dynamic"
            }
          ]
        }
      ]
    },
    {
      os_type                         = "Linux"
      name                            = local.naming.vm_5
      location                        = local.location
      resource_group_name             = azurerm_resource_group.rg.name
      size                            = "Standard_B1s"
      zone                            = "2"
      use_capacity_reservation        = false # This VM will NOT use capacity reservation
      admin_username                  = "adminuser"
      admin_password                  = "Password1234!"
      disable_password_authentication = false
      os_disk = {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
      }
      source_image_reference = {
        publisher = "Canonical"
        offer     = "0001-com-ubuntu-server-jammy"
        sku       = "22_04-lts-gen2"
        version   = "latest"
      }
      network_interfaces = [
        {
          name = "${local.naming.vm_5}-nic"
          ip_configuration = [
            {
              name                          = "ipconfig1"
              subnet_id                     = azurerm_subnet.subnet.id
              private_ip_address_allocation = "Dynamic"
            }
          ]
        }
      ]
    }
  ]
}
