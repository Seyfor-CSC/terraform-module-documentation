locals {
  location = "northeurope"

  naming = {
    rg = "SEY-TERRAFORM-NE-RG01"
  }

  alerts = [
    {
      resource_group_name = azurerm_resource_group.rg.name
      location            = local.location
      logv2_alerts = [
        {
          name                 = "example-msqrv2"
          evaluation_frequency = "PT10M"
          window_duration      = "PT10M"
          scopes               = [azurerm_application_insights.ai.id]
          severity             = 4

          criteria = {
            query                   = <<-QUERY
            requests | summarize CountByCountry=count() by client_CountryOrRegion
            QUERY
            time_aggregation_method = "Maximum"
            threshold               = 17.5
            operator                = "LessThan"

            resource_id_column    = "client_CountryOrRegion"
            metric_measure_column = "CountByCountry"
            dimension = {
              name     = "client_CountryOrRegion"
              operator = "Exclude"
              values   = ["123"]
            }
            failing_periods = {
              minimum_failing_periods_to_trigger_alert = 1
              number_of_evaluation_periods             = 1
            }
          }
        }
      ]

      activity_alerts = [
        {
          name        = "example-activitylogalert"
          scopes      = [azurerm_resource_group.rg.id]
          description = "This alert will monitor a specific storage account updates."

          criteria = {
            resource_id    = azurerm_storage_account.sa.id
            operation_name = "Microsoft.Storage/storageAccounts/write"
            category       = "Recommendation"
          }
        }
      ]

      metric_alerts = [
        {
          name   = "example-metricalert"
          scopes = [azurerm_storage_account.sa.id]
          criteria = [
            {
              metric_namespace = "Microsoft.Storage/storageAccounts"
              metric_name      = "Transactions"
              aggregation      = "Total"
              operator         = "GreaterThan"
              threshold        = 50

              dimension = [
                {
                  name     = "ApiName"
                  operator = "Include"
                  values   = ["*"]
                },
                {
                  name     = "GeoType"
                  operator = "Include"
                  values   = ["*"]
                }
              ]
            }
          ]
          action = [
            {
              action_group_id = azurerm_monitor_action_group.ag.id
            }
          ]
          target_resource_type     = "Microsoft.Storage/storageAccounts"
          target_resource_location = local.location
        }
      ]
    }
  ]
}
