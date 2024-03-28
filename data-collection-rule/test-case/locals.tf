locals {
  location = "northeurope"

  naming = {
    dcr_1 = "SEY-TERRAFORM-NE-DCR01"
    dcr_2 = "SEY-TERRAFORM-NE-DCR02"
  }

  dcr = [
    {
      name                        = local.naming.dcr_1
      resource_group_name         = azurerm_resource_group.rg.name
      location                    = local.location
      data_collection_endpoint_id = azurerm_monitor_data_collection_endpoint.example.id
      identity = {
        type = "SystemAssigned"
      }
      destinations = {
        log_analytics = [
          {
            workspace_resource_id = azurerm_log_analytics_workspace.la.id
            name                  = azurerm_log_analytics_workspace.la.name
          }
        ]
        storage_blob = [
          {
            storage_account_id = azurerm_storage_account.sa.id
            container_name     = azurerm_storage_container.container.name
            name               = "test-destination-storage"
          }
        ]
        azure_monitor_metrics = {
          name = "test-destination-metrics"
        }
      }
      data_flow = [
        {
          streams      = ["Microsoft-InsightsMetrics", "Microsoft-Syslog", "Microsoft-Perf"]
          destinations = [azurerm_log_analytics_workspace.la.name]
        }
      ]

      tags = {}

      monitoring = [
        {
          diag_name                  = "Monitoring"
          log_analytics_workspace_id = azurerm_log_analytics_workspace.la.id
          categories = {
            log_errors = false
          }
        }
      ]
    },
    {
      name                = local.naming.dcr_2
      resource_group_name = azurerm_resource_group.rg.name
      location            = local.location
      destinations = {
        log_analytics = [
          {
            workspace_resource_id = azurerm_log_analytics_workspace.la.id
            name                  = azurerm_log_analytics_workspace.la.name
          }
        ]
        azure_monitor_metrics = {
          name = "test-destination-metrics"
        }
      }
      data_flow = [
        {
          streams      = ["Microsoft-InsightsMetrics", "Microsoft-Syslog", "Microsoft-Perf"]
          destinations = [azurerm_log_analytics_workspace.la.name]
        }
      ]

      tags = {}
    }
  ]
}
