locals {
  location = "northeurope"

  naming = {
    rg      = "SEY-LASTANDARD-NE-RG01"
    logic_1 = "SEY-TERRAFORM-NE-LASTANDARD01"
    logic_2 = "SEY-TERRAFORM-NE-LASTANDARD02"
  }

  logic = [
    {
      name                       = local.naming.logic_1
      location                   = local.location
      resource_group_name        = azurerm_resource_group.rg.name
      app_service_plan_id        = azurerm_service_plan.asp.id
      storage_account_name       = azurerm_storage_account.sa.name
      storage_account_access_key = azurerm_storage_account.sa.primary_access_key
      identity = {
        type = "SystemAssigned"
      }
      app_settings = {
        "FUNCTIONS_WORKER_RUNTIME"     = "node"
        "WEBSITE_NODE_DEFAULT_VERSION" = "~18"
      }

      private_endpoint = [
        {
          name                          = "${local.naming.logic_1}-PE01"
          subnet_id                     = azurerm_subnet.subnet.id
          custom_network_interface_name = "${local.naming.logic_1}-PE01.nic"
          private_service_connection = [
            {
              name                 = "${local.naming.logic_1}-PE01-connection"
              is_manual_connection = false
              subresource_names    = ["sites"]
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
            function_app_logs = false
          }
        }
      ]

      tags = {}
    },
    {
      name                       = local.naming.logic_2
      location                   = local.location
      resource_group_name        = azurerm_resource_group.rg.name
      app_service_plan_id        = azurerm_service_plan.asp.id
      storage_account_name       = azurerm_storage_account.sa.name
      storage_account_access_key = azurerm_storage_account.sa.primary_access_key

      tags = {}
    }
  ]
}
