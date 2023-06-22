locals {
  location = "northeurope"

  naming = {
    rg   = "SEY-TERRAFORM-NE-RG01"
    df_1 = "SEY-TERRAFORM-NE-DF01"
    df_2 = "SEY-TERRAFORM-NE-DF02"
  }

    df = [
    {
      name                = local.naming.df_1
      location            = local.location
      resource_group_name = local.naming.rg
      identity = {
        type = "SystemAssigned"
      }

      private_endpoint = [
        {
          name                          = "${local.naming.df_1}-PE01"
          subnet_id                     = azurerm_subnet.subnet.id
          custom_network_interface_name = "${local.naming.df_1}-PE01.nic"
          private_service_connection = [
            {
              name                 = "${local.naming.df_1}-PE01-connection"
              is_manual_connection = false
              subresource_names    = ["dataFactory"]
            }
          ]
          private_dns_zone_group = [
            {
              name = azurerm_private_dns_zone.dns.name
              private_dns_zone_ids = [
                azurerm_private_dns_zone.dns.id
              ]
            }
          ]
        }
      ]

      monitoring = [
        {
          diag_name                  = "Monitoring"
          log_analytics_workspace_id = azurerm_log_analytics_workspace.la.id
        }
      ]

      tags = {}
    },
    {
      name                = local.naming.df_2
      location            = local.location
      resource_group_name = local.naming.rg

      tags = {}
    }
  ]
}
