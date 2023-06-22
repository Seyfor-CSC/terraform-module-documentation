locals {
  location = "northeurope"

  naming = {
    rg = "SEY-TERRAFORM-NE-RG01"
  }

  alerts = [
    {
      resource_group_name = local.naming.rg
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
    }
  ]
}
