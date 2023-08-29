locals {
  location = "northeurope"

  naming = {
    rg             = "SEY-TERRAFORM-SCALESET-RG01"
    vmss_windows01 = "SEY-TERRAFORM-SCALESET-WINDOWS01"
    vmss_windows02 = "SEY-TERRAFORM-SCALESET-WINDOWS02"
    vmss_linux01   = "SEY-TERRAFORM-SCALESET-LINUX01"
  }

  vmss = [
    {
      os_type              = "Windows"
      name                 = local.naming.vmss_windows01
      resource_group_name  = local.naming.rg
      location             = local.location
      sku                  = "Standard_DS3_v2"
      instances            = 3
      admin_username       = "adminuser"
      admin_password       = "P@ssw0rd1234!"
      computer_name_prefix = "sey"
      custom_data          = base64encode("example custom data")
      license_type         = "Windows_Server"
      zones                = [1, 2, 3]
      zone_balance         = true
      identity = {
        type = "SystemAssigned"
      }
      source_image_reference = {
        publisher = "MicrosoftWindowsServer"
        offer     = "WindowsServer"
        sku       = "2019-Datacenter"
        version   = "latest"
      }
      network_interface = [
        {
          name    = "primary"
          primary = true

          ip_configuration = [
            {
              name      = "internal"
              primary   = true
              subnet_id = azurerm_subnet.subnet.id
            }
          ]
        },
        {
          name = "secondary"

          ip_configuration = [
            {
              name      = "internal"
              primary   = true
              subnet_id = azurerm_subnet.subnet.id
            },
            {
              name      = "external"
              subnet_id = azurerm_subnet.subnet.id

              public_ip_address = {
                name                = "first"
                public_ip_prefix_id = azurerm_public_ip_prefix.prefix.id
              }
            }
          ]
        }
      ]
      os_disk = {
        storage_account_type = "Standard_LRS"
        caching              = "ReadOnly"
        disk_size_gb         = 128
        diff_disk_settings = {
          option = "Local"
        }
      }
      data_disk = [
        {
          storage_account_type = "Standard_LRS"
          caching              = "ReadWrite"
          disk_size_gb         = 10
          lun                  = 1
        },
        {
          storage_account_type = "Standard_LRS"
          caching              = "ReadWrite"
          disk_size_gb         = 10
          lun                  = 2
        }
      ]
      extension = [
        {
          name                       = "CustomScript"
          publisher                  = "Microsoft.Compute"
          type                       = "CustomScriptExtension"
          type_handler_version       = "1.10"
          auto_upgrade_minor_version = true
          settings                   = jsonencode({ "commandToExecute" = "powershell.exe -c \"Get-Content env:computername\"" })
          protected_settings         = jsonencode({ "managedIdentity" = {} })
        },
        {
          name                       = "AADLoginForWindows"
          publisher                  = "Microsoft.Azure.ActiveDirectory"
          type                       = "AADLoginForWindows"
          type_handler_version       = "1.0"
          auto_upgrade_minor_version = true
        }
      ]

      tags = {}
    },
    {
      os_type              = "Windows"
      name                 = local.naming.vmss_windows02
      autoscale            = true
      resource_group_name  = local.naming.rg
      location             = local.location
      sku                  = "Standard_F2"
      instances            = 2
      admin_username       = "adminuser"
      admin_password       = "P@ssw0rd1234!"
      computer_name_prefix = "sey"
      identity = {
        type = "SystemAssigned"
      }
      os_disk = {
        storage_account_type = "Standard_LRS"
        caching              = "ReadWrite"
      }
      source_image_reference = {
        publisher = "MicrosoftWindowsServer"
        offer     = "WindowsServer"
        sku       = "2019-Datacenter"
        version   = "latest"
      }
      network_interface = [
        {
          name    = "primary"
          primary = true

          ip_configuration = [
            {
              name      = "internal"
              primary   = true
              subnet_id = azurerm_subnet.subnet.id
            }
          ]
        }
      ]

      tags = {}

      autoscale_settings = {
        name = "autoscale-config"
        profile = [
          {
            name = "AutoScale"
            capacity = {
              default = 3
              minimum = 1
              maximum = 5
            }
            rule = [
              {
                metric_trigger = {
                  metric_name      = "Percentage CPU"
                  time_grain       = "PT1M"
                  statistic        = "Average"
                  time_window      = "PT5M"
                  time_aggregation = "Average"
                  operator         = "GreaterThan"
                  threshold        = 75
                }
                scale_action = {
                  direction = "Increase"
                  type      = "ChangeCount"
                  value     = "1"
                  cooldown  = "PT1M"
                }
              },
              {
                metric_trigger = {
                  metric_name      = "Percentage CPU"
                  time_grain       = "PT1M"
                  statistic        = "Average"
                  time_window      = "PT5M"
                  time_aggregation = "Average"
                  operator         = "LessThan"
                  threshold        = 25
                }
                scale_action = {
                  direction = "Decrease"
                  type      = "ChangeCount"
                  value     = "1"
                  cooldown  = "PT1M"
                }
              }
            ]
            recurrence = {
              days    = ["Monday"]
              hours   = [12]
              minutes = [0]
            }
          },
          {
            name = "AutoScale2"
            capacity = {
              default = 2
              minimum = 1
              maximum = 5
            }
            rule = [
              {
                metric_trigger = {
                  metric_name      = "Percentage CPU"
                  time_grain       = "PT1M"
                  statistic        = "Average"
                  time_window      = "PT5M"
                  time_aggregation = "Average"
                  operator         = "GreaterThan"
                  threshold        = 70
                }
                scale_action = {
                  direction = "Increase"
                  type      = "ChangeCount"
                  value     = "1"
                  cooldown  = "PT1M"
                }
              },
              {
                metric_trigger = {
                  metric_name      = "Percentage CPU"
                  time_grain       = "PT1M"
                  statistic        = "Average"
                  time_window      = "PT5M"
                  time_aggregation = "Average"
                  operator         = "LessThan"
                  threshold        = 20
                }
                scale_action = {
                  direction = "Decrease"
                  type      = "ChangeCount"
                  value     = "1"
                  cooldown  = "PT1M"
                }
              }
            ]
          }
        ]
        recurrence = {
          days    = ["Saturday", "Sunday"]
          hours   = [12]
          minutes = [0]
        }

        monitoring = [
          {
            log_analytics_workspace_id = azurerm_log_analytics_workspace.la.id
            diag_name                  = "Monitoring"
          }
        ]
      }
    },
    {
      os_type                         = "Linux"
      name                            = local.naming.vmss_linux01
      resource_group_name             = local.naming.rg
      location                        = local.location
      sku                             = "Standard_F2"
      instances                       = 2
      admin_username                  = "adminuser"
      admin_password                  = "P@ssw0rd1234!"
      disable_password_authentication = false
      computer_name_prefix            = "sey"
      source_image_reference = {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "16.04-LTS"
        version   = "latest"
      }
      network_interface = [
        {
          name    = "example"
          primary = true
          ip_configuration = [
            {
              name      = "internal"
              primary   = true
              subnet_id = azurerm_subnet.subnet.id
            }
          ]
        }
      ]
      os_disk = {
        storage_account_type = "Standard_LRS"
        caching              = "ReadWrite"
      }

      tags = {}
    }
  ]
}
