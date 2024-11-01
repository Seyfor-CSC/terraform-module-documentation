locals {
  location = "northeurope"
  naming = {
    mlw_1 = "SEY-TERRAFORM-NE-MLW01"
  }

  mlw = [
    {
      name                    = local.naming.mlw_1
      resource_group_name     = azurerm_resource_group.rg.name
      location                = local.location
      application_insights_id = azurerm_application_insights.ai.id
      key_vault_id            = azurerm_key_vault.kv.id
      storage_account_id      = azurerm_storage_account.sa.id
      description             = "Machine Learning Workspace"
      high_business_impact    = true

      identity = {
        type = "SystemAssigned"
      }

      encryption = {
        key_vault_id = azurerm_key_vault.kv.id
        key_id       = azurerm_key_vault_key.kvk.id
      }

      private_endpoint = [
        {
          name                          = "${local.naming.mlw_1}-PE01"
          subnet_id                     = azurerm_subnet.subnet.id
          custom_network_interface_name = "${local.naming.mlw_1}-PE01.nic"
          private_service_connection = [
            {
              name                 = "${local.naming.mlw_1}-PE01-connection"
              is_manual_connection = false
              subresource_names    = ["amlworkspace"]
            }
          ]
          private_dns_zone_group = {
            name = azurerm_private_dns_zone.dns.name
            private_dns_zone_ids = [
              azurerm_private_dns_zone.dns.id
            ]
          }
        }
      ]

      monitoring = [
        {
          diag_name                  = "Monitoring"
          log_analytics_workspace_id = azurerm_log_analytics_workspace.la.id
          categories = {
            aml_compute_cluster_event       = false
            aml_compute_cluster_node_event  = false
            aml_compute_job_event           = false
            aml_compute_cpu_gpu_utilization = false
            aml_run_status_changed_event    = false
            models_change_event             = false
            models_read_event               = false
            models_action_event             = false
            deployment_read_event           = false
            deployment_event_aci            = false
            deployment_event_aks            = false
            inferencing_operation_aks       = false
            inferencing_operation_aci       = false
          }
        },
        {
          diag_name                      = "SecurityMonitoring"
          eventhub_name                  = azurerm_eventhub.eh.name
          eventhub_authorization_rule_id = "${azurerm_eventhub_namespace.eventhub_namespace.id}/authorizationRules/RootManageSharedAccessKey"
        }
      ]
    }
  ]
}
