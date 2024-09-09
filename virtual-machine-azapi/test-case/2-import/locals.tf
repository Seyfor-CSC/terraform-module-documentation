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
      }

      network_interfaces = [
        {
          name = "${local.naming.vm_1}-nic0"
          ip_configuration = [
            {
              name                          = "ipconfig1"
              subnet_id                     = data.azurerm_subnet.subnet.id
              private_ip_address_allocation = "Static"
              private_ip_address            = "10.0.1.26"
              primary                       = true
            },
            {
              name                          = "ipconfig2"
              subnet_id                     = data.azurerm_subnet.subnet.id
              private_ip_address_allocation = "Dynamic"
            }
          ]
        },
        {
          name                           = "${local.naming.vm_1}-nic1"
          accelerated_networking_enabled = false
          ip_configuration = [
            {
              name                          = "ipconfig1"
              subnet_id                     = data.azurerm_subnet.subnet.id
              private_ip_address_allocation = "Static"
              private_ip_address            = "10.0.1.28"
              primary                       = true
            },
            {
              name                          = "ipconfig2"
              subnet_id                     = data.azurerm_subnet.subnet.id
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
        # osdisk
        {
          os_disk                       = true
          name                          = "${local.naming.vm_1}-osdisk"
          resource_group_name           = azurerm_resource_group.rg.name
          create_option                 = "FromImage"
          hyper_v_generation            = "V1"
          storage_account_type          = "Standard_LRS"
          image_reference_id            = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/Providers/Microsoft.Compute/Locations/northeurope/Publishers/MicrosoftWindowsServer/ArtifactTypes/VMImage/Offers/WindowsServer/Skus/2022-Datacenter/Versions/20348.1970.230905"
          os_type                       = "Windows"
          public_network_access_enabled = "true"
          disk_size_gb                  = 128

          disk_backup = [
            {
              name             = "${local.naming.vm_1}-osdisk"
              vault_id         = azurerm_data_protection_backup_vault.bv.id
              backup_policy_id = azurerm_data_protection_backup_policy_disk.bp.id
            }
          ]
        },
        # data disks
        {
          name                      = "${local.naming.vm_1}-data01"
          resource_group_name       = azurerm_resource_group.rg.name
          disk_size_gb              = 256
          storage_account_type      = "StandardSSD_LRS"
          create_option             = "Empty"
          zone                      = "2"
          lun                       = 1
          write_accelerator_enabled = false

          disk_backup = [
            {
              name             = "${local.naming.vm_1}-data1"
              vault_id         = azurerm_data_protection_backup_vault.bv.id
              backup_policy_id = azurerm_data_protection_backup_policy_disk.bp.id
            }
          ]
        }
      ]

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
    }
  ]
}
