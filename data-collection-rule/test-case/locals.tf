locals {
  location = "northeurope"

  naming = {
    rg    = "SEY-TERRAFORM-NE-RG01"
    la    = "SEY-TERRAFORM-NE-LA01"
    sa    = "seyterraformdcrnesa01"
    dcr_1 = "SEY-TERRAFORM-NE-DCR01"
    dcr_2 = "SEY-TERRAFORM-NE-DCR02"
  }

  dcr = [
    {
      name                        = local.naming.dcr_1
      resource_group_name         = local.naming.rg
      location                    = local.location
      data_collection_endpoint_id = azurerm_monitor_data_collection_endpoint.example.id
      identity = {
        type = "SystemAssigned"
      }
      destinations = {
        log_analytics = [
          {
            workspace_resource_id = azurerm_log_analytics_workspace.la.id
            name                  = local.naming.la
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
          destinations = [local.naming.la]
        }
      ]

      tags = {}
    },
    {
      name                = local.naming.dcr_2
      resource_group_name = local.naming.rg
      location            = local.location
      destinations = {
        log_analytics = [
          {
            workspace_resource_id = azurerm_log_analytics_workspace.la.id
            name                  = local.naming.la
          }
        ]
        azure_monitor_metrics = {
          name = "test-destination-metrics"
        }
      }
      data_flow = [
        {
          streams      = ["Microsoft-InsightsMetrics", "Microsoft-Syslog", "Microsoft-Perf"]
          destinations = [local.naming.la]
        }
      ]

      tags = {}
    }
  ]
}
