locals {
  location = "northeurope"

  naming = {
    vm_1 = "SEYWINDOWSVM01"
  }
  vm = [
    {
      name                = local.naming.vm_1
      location            = local.location
      resource_group_name = azurerm_resource_group.rg.name
      parent_id           = azurerm_resource_group.rg.id
      identity = {
        type = "SystemAssigned"
      }
      properties = {
        hardwareProfile = {
          vmSize = "Standard_D2s_v3"
        }
        networkProfile = {
          networkInterfaces = [
            {
              id = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/SEY-TERRAFORM-NE-RG01/providers/Microsoft.Network/networkInterfaces/${local.naming.vm_1}-nic0"
            }
          ]
        }

        storageProfile = {
          osDisk = {
            name         = "${local.naming.vm_1}-osdisk"
            osType       = "Windows"
            createOption = "Attach"
            deleteOption = "Detach"
            diskSizeGB   = 128
            caching      = "ReadWrite"
            managedDisk = {
              id                 = azurerm_managed_disk.os_disk.id
              storageAccountType = "Standard_LRS"
            }
          }
          dataDisks = [
            {
              name         = "${local.naming.vm_1}-data01"
              createOption = "Attach"
              deleteOption = "Detach"
              diskSizeGB   = 256
              lun          = 1
              caching      = "None"
              zones        = ["2"]
              managedDisk = {
                id                 = azurerm_managed_disk.data_disk.id
                storageAccountType = "StandardSSD_LRS"
              }
              toBeDetached            = false
              writeAcceleratorEnabled = false
            }
          ]
        }
      }

      disk_backup = [
        {
          name             = "${local.naming.vm_1}-osdisk"
          vault_id         = azurerm_data_protection_backup_vault.bv.id
          backup_policy_id = azurerm_data_protection_backup_policy_disk.bp.id
        }
      ]

      network_interfaces = [
        {
          name = "${local.naming.vm_1}-nic0"
          ip_configuration = [
            {
              name                          = "ipconfig1"
              subnet_id                     = azurerm_subnet.subnet.id
              private_ip_address_allocation = "Static"
              private_ip_address            = "10.0.1.26"
              primary                       = true
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

      # needs to be imported to manage disk properties
      # managed_disks = [
      #   # osdisk
      #   {
      #     name                          = "SEYWINDOWSVM01-osdisk"
      #     create_option                 = "FromImage"
      #     hyper_v_generation            = "V1"
      #     image_reference_id            = "/Subscriptions/${data.azurerm_client_config.current.subscription_id}/Providers/Microsoft.Compute/Locations/northeurope/Publishers/MicrosoftWindowsServer/ArtifactTypes/VMImage/Offers/WindowsServer/Skus/2022-Datacenter/Versions/20348.1970.230905"
      #     os_type                       = "Windows"
      #     public_network_access_enabled = "false"
      #   },
      #   # data disks
      #   {
      #     name                 = "${local.naming.vm_1}-data01"
      #     disk_size_gb         = 128
      #     storage_account_type = "StandardSSD_LRS"
      #     zone                 = "2"

      #     disk_backup = [
      #       {
      #         name             = "${local.naming.vm_1}-data1"
      #         vault_id         = azurerm_data_protection_backup_vault.bv.id
      #         backup_policy_id = azurerm_data_protection_backup_policy_disk.bp.id
      #       }
      #     ]
      #   }
      # ]

      vm_extensions = [
        {
          name                 = "vmAgentExtension"
          publisher            = "Microsoft.Azure.Monitor"
          type                 = "AzureMonitorWindowsAgent"
          type_handler_version = "1.18"
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
    }
  ]
}
