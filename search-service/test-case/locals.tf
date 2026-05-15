locals {
  location = "northeurope"

  naming = {
    rg       = "SEY-SEARCH-NE-RG01"
    search_1 = "sey-terraform-ne-srch01"
    search_2 = "sey-terraform-ne-srch02"
  }

  config = [
    {
      name                         = local.naming.search_1
      location                     = local.location
      resource_group_name          = azurerm_resource_group.rg.name
      sku                          = "standard"
      authentication_failure_mode  = "http403"
      local_authentication_enabled = true
      network_rule_bypass_option   = "AzureServices"
      replica_count                = 1
      identity = {
        type = "SystemAssigned"
      }
      monitoring = [
        {
          diag_name                  = "Monitoring"
          log_analytics_workspace_id = azurerm_log_analytics_workspace.la.id
          categories = {
            operation_logs = true
            all_metrics    = false
          }
        }
      ]
      private_endpoint = [
        {
          name                          = "${local.naming.search_1}-PE01"
          subnet_id                     = azurerm_subnet.subnet.id
          custom_network_interface_name = "${local.naming.search_1}-PE01.nic"
          private_service_connection = [
            {
              name                 = "${local.naming.search_1}-PE01-connection"
              is_manual_connection = false
              subresource_names    = ["searchService"]
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
    },
    {
      name                          = local.naming.search_2
      location                      = local.location
      resource_group_name           = azurerm_resource_group.rg.name
      sku                           = "free"
      public_network_access_enabled = true
    }
  ]
}
