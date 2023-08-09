locals {
  location = "northeurope"

  naming = {
    rg    = "SEY-TERRAFORM-NE-RG01"
    asp_1 = "SEY-TERRAFORM-NE-ASP01"
    asp_2 = "SEY-TERRAFORM-NE-ASP02"
    app_1 = "SEY-TERRAFORM-NE-APP01"
    app_2 = "SEY-TERRAFORM-NE-APP02"
  }

  app = [
    {
      name                = local.naming.asp_1
      location            = local.location
      os_type             = "Windows"
      resource_group_name = local.naming.rg
      sku_name            = "P1v2"

      web_app = [
        {
          name        = local.naming.app_1
          location    = local.location
          site_config = {}
          application_stack = {
            dotnet_version = "v5.0"
          }
          public_network_access_enabled = false

          private_endpoint = [
            {
              name                          = "${local.naming.app_1}-PE01"
              subnet_id                     = azurerm_subnet.subnet.id
              custom_network_interface_name = "${local.naming.app_1}-PE01.nic"
              private_service_connection = [
                {
                  name                 = "${local.naming.app_1}-PE01-connection"
                  is_manual_connection = false
                  subresource_names    = ["sites"]
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
        },
        {
          name        = local.naming.app_2
          location    = local.location
          site_config = {}
        }
      ]

      tags = {}
    },
    {
      name                = local.naming.asp_2
      location            = local.location
      resource_group_name = local.naming.rg
      os_type             = "Linux"
      sku_name            = "F1"

      tags = {}
    }
  ]
}
