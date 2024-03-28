locals {
  location = "northeurope"

  naming = {
    rg   = "SEY-TERRAFORM-NE-RG01"
    vm_1 = "SEYWINDOWSVM01"
    vm_2 = "SEYWINDOWSVM02"
    vm_3 = "SEYLINUXVM01"
    vm_4 = "SEYLINUXVM02"
  }

  vm = [
    {
      os_type                         = "Windows"
      name                            = local.naming.vm_1
      location                        = local.location
      resource_group_name             = azurerm_resource_group.rg.name
      size                            = "Standard_F2"
      admin_username                  = "adminuser"
      admin_password                  = "Password1234"
      disable_password_authentication = false
      computer_name                   = "EX3TESTVM01"
      identity = {
        type = "SystemAssigned"
      }
      os_disk = {
        name                 = "${local.naming.vm_1}-osdisk"
        caching              = "ReadWrite"
        storage_account_type = "StandardSSD_LRS"
        disk_size_gb         = 128

        disk_backup = [
          {
            name             = "${local.naming.vm_1}-osdisk"
            vault_id         = azurerm_data_protection_backup_vault.bv.id
            backup_policy_id = azurerm_data_protection_backup_policy_disk.bp.id
          }
        ]
      }
      source_image_reference = {
        publisher = "MicrosoftWindowsServer"
        offer     = "WindowsServer"
        sku       = "2022-Datacenter"
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
          disk_attachment = [
            {
              lun     = 2
              caching = "None"
            }
          ]

          disk_backup = [
            {
              name             = "${local.naming.vm_1}-data1"
              vault_id         = azurerm_data_protection_backup_vault.bv.id
              backup_policy_id = azurerm_data_protection_backup_policy_disk.bp.id
            }
          ]
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
          name                 = "vmAgentExtension"
          publisher            = "Microsoft.Compute"
          type                 = "VMAccessAgent"
          type_handler_version = "2.0"
          settings             = <<SETTINGS
          {
            "protectedSettings": {
              "username": "adminuser",
              "password": "P@ssw0rd1234!"
          }
        }
          SETTINGS
        }
      ]

      vm_backup = [
        {
          custom_name         = "${local.naming.vm_1}-backup"
          resource_group_name = azurerm_resource_group.rg.name
          recovery_vault_name = azurerm_recovery_services_vault.rsv.name
          backup_policy_id    = azurerm_backup_policy_vm.bp.id
        }
      ]

      tags = {}
    },
    {
      os_type                         = "Windows"
      name                            = local.naming.vm_2
      location                        = local.location
      resource_group_name             = azurerm_resource_group.rg.name
      size                            = "Standard_F2"
      admin_username                  = "adminuser"
      admin_password                  = "Password1234"
      disable_password_authentication = false
      computer_name                   = "EX3TESTVM02"
      os_disk = {
        name                 = "${local.naming.vm_2}-osdisk"
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
      }
      source_image_reference = {
        publisher = "MicrosoftWindowsServer"
        offer     = "WindowsServer"
        sku       = "2022-Datacenter"
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
    },
    {
      os_type                         = "Linux"
      name                            = local.naming.vm_3
      location                        = local.location
      resource_group_name             = azurerm_resource_group.rg.name
      size                            = "Standard_F2"
      admin_username                  = "adminuser"
      admin_password                  = "Password1234"
      disable_password_authentication = false
      identity = {
        type = "SystemAssigned"
      }
      os_disk = {
        name                 = "${local.naming.vm_3}-osdisk"
        caching              = "ReadWrite"
        storage_account_type = "StandardSSD_LRS"
        disk_size_gb         = 128

        disk_backup = [
          {
            vault_id         = azurerm_data_protection_backup_vault.bv.id
            backup_policy_id = azurerm_data_protection_backup_policy_disk.bp.id
          }
        ]
      }
      source_image_reference = {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "16.04-LTS"
        version   = "latest"
      }

      network_interfaces = [
        {
          name = "${local.naming.vm_3}-nic0"
          ip_configuration = [
            {
              name                          = "ipconfig1"
              subnet_id                     = azurerm_subnet.subnet.id
              private_ip_address_allocation = "Static"
              private_ip_address            = "10.0.1.27"
            }
          ]
        },
        {
          name = "${local.naming.vm_3}-nic1"
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
          name                    = "${local.naming.vm_3}-dcra01"
          data_collection_rule_id = azurerm_monitor_data_collection_rule.dcr.id
        }
      ]

      managed_disks = [
        {
          name                 = "${local.naming.vm_3}-data01"
          disk_size_gb         = 128
          storage_account_type = "StandardSSD_LRS"
          zone                 = "2"
          disk_attachment = [
            {
              lun     = 2
              caching = "None"
            }
          ]

          disk_backup = [
            {
              name             = "${local.naming.vm_3}-data1"
              vault_id         = azurerm_data_protection_backup_vault.bv.id
              backup_policy_id = azurerm_data_protection_backup_policy_disk.bp.id
            }
          ]
        },
        {
          name                 = "${local.naming.vm_3}-data02"
          disk_size_gb         = 128
          storage_account_type = "StandardSSD_LRS"
          zone                 = "2"
          disk_attachment = [
            {
              lun     = 3
              caching = "None"
            }
          ]
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

      vm_backup = [
        {
          custom_name         = "${local.naming.vm_3}-backup"
          resource_group_name = azurerm_resource_group.rg.name
          recovery_vault_name = azurerm_recovery_services_vault.rsv.name
          backup_policy_id    = azurerm_backup_policy_vm.bp.id
        }
      ]

      tags = {}
    },
    {
      os_type                         = "Linux"
      name                            = local.naming.vm_4
      location                        = local.location
      resource_group_name             = azurerm_resource_group.rg.name
      size                            = "Standard_F2"
      admin_username                  = "adminuser"
      admin_password                  = "Password1234"
      disable_password_authentication = false
      os_disk = {
        name                 = "${local.naming.vm_4}-osdisk"
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
          name = "${local.naming.vm_4}-nic0"
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
