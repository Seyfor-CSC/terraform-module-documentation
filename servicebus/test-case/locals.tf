locals {
  location = "northeurope"

  naming = {
    rg          = "SEY-SERVICEBUS-NE-RG01"
    namespace_1 = "SEY-TERRAFORM-NE-SERVICEBUS01"
    namespace_2 = "SEY-TERRAFORM-NE-SERVICEBUS02"
  }

  servicebus = [
    {
      name                         = local.naming.namespace_1
      resource_group_name          = azurerm_resource_group.rg.name
      location                     = local.location
      sku                          = "Premium"
      capacity                     = 2
      premium_messaging_partitions = 1
      identity = {
        type = "SystemAssigned"
      }

      private_endpoint = [
        {
          name                          = "${local.naming.namespace_1}-PE01"
          subnet_id                     = azurerm_subnet.subnet.id
          custom_network_interface_name = "${local.naming.namespace_1}-PE01.nic"
          private_service_connection = [
            {
              name                 = "${local.naming.namespace_1}-PE01-connection"
              is_manual_connection = false
              subresource_names    = ["namespace"]
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
            diagnostic_error_logs      = false
            operational_logs           = false
            vnet_and_ip_filtering_logs = false
            runtime_audit_logs         = false
          }
        }
      ]
    },
    {
      name                = local.naming.namespace_2
      resource_group_name = azurerm_resource_group.rg.name
      location            = local.location
      sku                 = "Basic"
    }
  ]

}
