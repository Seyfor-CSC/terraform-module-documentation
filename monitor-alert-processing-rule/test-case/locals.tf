locals {
  location = "northeurope"

  naming = {
    rg    = "SEY-ALERTRULE-NE-RG01"
    apr_1 = "SEY-TERRAFORM-NE-APR01"
    apr_2 = "SEY-TERRAFORM-NE-APR02"
  }

  apr = [
    {
      name                 = local.naming.apr_1
      resource_group_name  = azurerm_resource_group.rg.name
      add_action_group_ids = [azurerm_monitor_action_group.ag1.id, azurerm_monitor_action_group.ag2.id]
      scopes               = [azurerm_storage_account.sa.id]
      condition = {
        alert_context = {
          operator = "Contains"
          values   = ["SingleResourceMultipleMetricCriteria"]
        }
        alert_rule_id = {
          operator = "Equals"
          values   = [azurerm_monitor_metric_alert.alert.id]
        }
        alert_description = {
          operator = "Contains"
          values   = ["test"]
        }
        monitor_condition = {
          operator = "Equals"
          values   = ["Fired"]
        }
        monitor_service = {
          operator = "Equals"
          values   = ["Platform"]
        }
        severity = {
          operator = "Equals"
          values   = ["Sev0", "Sev1", "Sev2"]
        }
        signal_type = {
          operator = "Equals"
          values   = ["Metric"]
        }
        target_resource = {
          operator = "Equals"
          values   = [azurerm_storage_account.sa.id]
        }
        target_resource_group = {
          operator = "Equals"
          values   = [azurerm_resource_group.rg.id]
        }
        target_resource_type = {
          operator = "Equals"
          values   = ["Microsoft.Storage/storageAccounts"]
        }
      }
      description = "Test description"
      enabled     = true
      schedule = {
        effective_from  = "2023-12-04T13:00:00"
        effective_until = "2023-12-04T18:00:00"
        recurrence = {
          daily = [
            {
              start_time = "23:00:00"
              end_time   = "23:30:00"
            }
          ]
        }
        time_zone = "Pacific Standard Time"
      }
      tags = {}
    },
    {
      name                = local.naming.apr_2
      resource_group_name = azurerm_resource_group.rg.name
      scopes              = [azurerm_storage_account.sa.id]

      tags = {}
    }
  ]
}
