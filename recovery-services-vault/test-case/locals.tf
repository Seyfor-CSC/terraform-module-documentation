locals {
  location = "northeurope"

  naming = {
    rg    = "SEY-TERRAFORM-NE-RG01"
    rsv_1 = "SEY-TERRAFORM-NE-RSV01"
    rsv_2 = "SEY-TERRAFORM-NE-RSV02"
  }

  rsv = [
    {
      name                = local.naming.rsv_1
      location            = local.location
      resource_group_name = local.naming.rg
      sku                 = "Standard"
      identity = {
        type = "SystemAssigned"
      }

      backup_policy_vm = [
        {
          name     = "VMDailyBackupPolicy"
          timezone = "UTC"
          backup = {
            frequency = "Daily"
            time      = "23:00"
          }

          retention_daily = {
            count = 10
          }
        }
      ]

      backup_policy_file_share = [
        {
          name = "FileShareDailyBackupPolicy"
          backup = {
            frequency = "Daily"
            time      = "23:00"
          }
          retention_daily = {
            count = 10
          }
        }
      ]


      private_endpoint = [
        {
          name                          = "${local.naming.rsv_1}-PE01"
          subnet_id                     = azurerm_subnet.subnet.id
          custom_network_interface_name = "${local.naming.rsv_1}-PE01.nic"
          private_service_connection = [
            {
              name                 = "${local.naming.rsv_1}-PE01-connection"
              is_manual_connection = false
              subresource_names    = ["AzureBackup"]
            }
          ]
          private_dns_zone_group = [
            {
              name = azurerm_private_dns_zone.dns.name
              private_dns_zone_ids = [
                azurerm_private_dns_zone.dns.id
              ]
            }
          ]
        }
      ]

      monitoring = [
        {
          diag_name                  = "Monitoring - Recovery"
          log_analytics_workspace_id = azurerm_log_analytics_workspace.la.id
          recovery                   = true
        },
        {
          diag_name                  = "Monitoring - Backup"
          log_analytics_workspace_id = azurerm_log_analytics_workspace.la.id
          backup                     = true
        },
        {
          diag_name                  = "Monitoring - BackupReport"
          log_analytics_workspace_id = azurerm_log_analytics_workspace.la.id
          backup_report              = true
        }
      ]

      tags = {}
    },
    {
      name                = local.naming.rsv_2
      location            = local.location
      resource_group_name = local.naming.rg
      sku                 = "Standard"

      tags = {}
    }
  ]
}
