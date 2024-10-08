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
          name                            = "DailyBackupPolicy"
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
