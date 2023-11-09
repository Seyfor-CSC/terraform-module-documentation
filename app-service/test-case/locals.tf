locals {
  location = "northeurope"

  naming = {
    rg    = "SEY-TERRAFORM-NE-RG01"
    app_1 = "SEY-TERRAFORM-NE-APP01"
    app_2 = "SEY-TERRAFORM-NE-APP02"
  }

  app = [
    {
      os_type             = "Windows"
      name                = local.naming.app_1
      resource_group_name = local.naming.rg
      location            = local.location
      service_plan_id     = azurerm_service_plan.windows_plan.id
      site_config         = {}
      identity = {
        type = "SystemAssigned"
      }
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
      os_type             = "Linux"
      name                = local.naming.app_2
      resource_group_name = local.naming.rg
      location            = local.location
      service_plan_id     = azurerm_service_plan.linux_plan.id
      site_config         = {}
    }
  ]
}
