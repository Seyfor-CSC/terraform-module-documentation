locals {
  location = "northeurope"

  naming = {
    rg   = "SEY-TERRAFORM-NE-RG01"
    vm_1 = "SEY-TERRAFORM-NE-VM01"
    vm_2 = "SEY-TERRAFORM-NE-VM02"
  }

  vm = [
    {
      name                            = local.naming.vm_1
      location                        = local.location
      resource_group_name             = local.naming.rg
      size                            = "Standard_F2"
      admin_username                  = "adminuser"
      admin_password                  = "Password1234"
      disable_password_authentication = false
      identity = {
        type = "SystemAssigned"
      }
      os_disk = {
        name                 = "${local.naming.vm_1}-osdisk"
        caching              = "ReadWrite"
        storage_account_type = "StandardSSD_LRS"
        disk_size_gb         = 128
      }
      source_image_reference = {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "16.04-LTS"
        version   = "latest"
      }

      network_interfaces = [
        {
          name = "${local.naming.vm_1}-nic0"
          ip_configuration = [
            {
              name                          = "ipconfig1"
              subnet_id                     = azurerm_subnet.subnet.id
              private_ip_address_allocation = "Static"
              private_ip_address            = "10.0.1.26"
            }
          ]
        },
        {
          name = "${local.naming.vm_1}-nic1"
          ip_configuration = [
            {
              name                          = "ipconfig2"
              subnet_id                     = azurerm_subnet.subnet.id
              private_ip_address_allocation = "Dynamic"
            }
          ]
        }
      ]

      data_collection_rule_association = [
        {
          name                    = "${local.naming.vm_1}-dcra01"
          data_collection_rule_id = azurerm_monitor_data_collection_rule.dcr.id
        }
      ]

      managed_disks = [
        {
          name                 = "${local.naming.vm_1}-data01"
          disk_size_gb         = 128
          storage_account_type = "StandardSSD_LRS"
          zone                 = "2"
          disk_attachment = [{
            lun     = 2
            caching = "None"
          }]
        },
        {
          name                 = "${local.naming.vm_1}-data02"
          disk_size_gb         = 128
          storage_account_type = "StandardSSD_LRS"
          zone                 = "2"
          disk_attachment = [{
            lun     = 3
            caching = "None"
          }]
        }
      ]

      vm_extensions = [
        {
          name                 = "hostname"
          publisher            = "Microsoft.Azure.Extensions"
          type                 = "CustomScript"
          type_handler_version = "2.0"
          settings             = <<SETTINGS
          {
            "commandToExecute": "hostname && uptime"
          }
          SETTINGS
        },
        {
          name                       = "networkwatcher"
          publisher                  = "Microsoft.Azure.NetworkWatcher"
          type                       = "NetworkWatcherAgentLinux"
          type_handler_version       = "1.4"
          auto_upgrade_minor_version = "true"
        }
      ]

      tags = {}
    },
    {
      name                            = local.naming.vm_2
      location                        = local.location
      resource_group_name             = local.naming.rg
      size                            = "Standard_F2"
      admin_username                  = "adminuser"
      admin_password                  = "Password1234"
      disable_password_authentication = false
      os_disk = {
        name                 = "${local.naming.vm_2}-osdisk"
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
      }
      source_image_reference = {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "16.04-LTS"
        version   = "latest"
      }

      network_interfaces = [
        {
          name = "${local.naming.vm_2}-nic0"
          ip_configuration = [
            {
              name                          = "internal"
              subnet_id                     = azurerm_subnet.subnet.id
              private_ip_address_allocation = "Dynamic"
            }
          ]
        }
      ]

      tags = {}
    }
  ]
}
