locals {
  location = "northeurope"

  naming = {
    rg    = "SEY-COG-NE-RG01"
    cog_1 = "SEY-TERRAFORM-NE-COG01"
    cog_2 = "SEY-TERRAFORM-NE-COG02"
  }

  cog = [
    {
      name                  = local.naming.cog_1
      location              = local.location
      resource_group_name   = azurerm_resource_group.rg.name
      kind                  = "FormRecognizer"
      sku_name              = "F0"
      custom_subdomain_name = lower(local.naming.cog_1)
      identity = {
        type = "SystemAssigned"
      }

      private_endpoint = [
        {
          name                          = "${local.naming.cog_1}-PE01"
          subnet_id                     = azurerm_subnet.subnet.id
          custom_network_interface_name = "${local.naming.cog_1}-PE01.nic"
          private_service_connection = [
            {
              name                 = "${local.naming.cog_1}-PE01-connection"
              is_manual_connection = false
              subresource_names    = ["account"]
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
            request_response = false
          }
        }
      ]

      tags = {}
    },
    {
      name                = local.naming.cog_2
      location            = local.location
      resource_group_name = azurerm_resource_group.rg.name
      kind                = "Face"
      sku_name            = "S0"

      tags = {}
    }
  ]
}
