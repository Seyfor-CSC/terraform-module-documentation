locals {
  location = "northeurope"

  naming = {
    rg   = "SEY-BV-NE-RG01"
    bv_1 = "SEY-TERRAFORM-NE-BV01"
    bv_2 = "SEY-TERRAFORM-NE-BV02"
  }

  bv = [
    {
      name                = local.naming.bv_1
      location            = local.location
      resource_group_name = azurerm_resource_group.rg.name
      datastore_type      = "VaultStore"
      redundancy          = "LocallyRedundant"
      identity = {
        type = "SystemAssigned"
      }

      backup_policy_disk = [
        {
          name                            = "DailyBackupPolicyDisk"
          backup_repeating_time_intervals = ["R/2021-05-19T06:33:16+00:00/PT4H"]
          default_retention_duration      = "P7D"
          retention_rule = [
            {
              name     = "Daily"
              duration = "P7D"
              priority = 25
              criteria = {
                absolute_criteria = "FirstOfDay"
              }
            },
            {
              name     = "Weekly"
              duration = "P7D"
              priority = 20
              criteria = {
                absolute_criteria = "FirstOfWeek"
              }
            }
          ]
        }
      ]

      backup_policy_blob_storage = [
        {
          name                                   = "DailyBackupPolicyBlob"
          backup_repeating_time_intervals        = ["R/2021-05-19T06:33:16+00:00/PT4H"]
          operational_default_retention_duration = "P30D"
          vault_default_retention_duration       = "P90D"
          time_zone                              = "Central European Standard Time"
          retention_rule = [
            {
              name = "Daily"
              criteria = {
                absolute_criteria = "FirstOfDay"
              }
              life_cycle = {
                data_store_type = "VaultStore"
                duration        = "P30D"
              }
              priority = 25
            }
          ]
        }
      ]

      backup_policy_postgresql_flexible_server = [
        {
          name                            = "WeeklyBackupPolicyPostgresqlFlexibleServer"
          backup_repeating_time_intervals = ["R/2021-05-23T02:30:00+00:00/P1W"]
          time_zone                       = "UTC"
          default_retention_rule = {
            life_cycle = {
              data_store_type = "VaultStore"
              duration        = "P4M"
            }
          }
          retention_rule = [
            {
              name = "Weekly"
              criteria = {
                absolute_criteria = "FirstOfWeek"
              }
              life_cycle = {
                data_store_type = "VaultStore"
                duration        = "P12W"
              }
              priority = 20
            }
          ]
        }
      ]

      monitoring = [
        {
          diag_name                  = "Monitoring"
          log_analytics_workspace_id = azurerm_log_analytics_workspace.la.id
          categories = {
            core_azure_backup       = false
            addon_azure_backup_jobs = false
          }
        }
      ]

      tags = {}
    },
    {
      name                = local.naming.bv_2
      location            = local.location
      resource_group_name = azurerm_resource_group.rg.name
      datastore_type      = "VaultStore"
      redundancy          = "LocallyRedundant"

      tags = {}
    }
  ]
}
