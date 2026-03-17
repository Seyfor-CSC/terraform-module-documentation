locals {
  location = "northeurope"

  naming = {
    rg    = "SEY-ACAE-NE-RG01"
    cae_1 = "SEY-TERRAFORM-NE-ACAE01"
    cae_2 = "SEY-TERRAFORM-NE-ACAE02"
  }

  cae = [
    {
      name                               = local.naming.cae_1
      location                           = local.location
      resource_group_name                = azurerm_resource_group.rg.name
      infrastructure_resource_group_name = "${azurerm_resource_group.rg.name}-DYN"
      infrastructure_subnet_id           = azurerm_subnet.subnet.id
      log_analytics_workspace_id         = azurerm_log_analytics_workspace.la.id

      workload_profile = [
        {
          name                  = "Consumption"
          workload_profile_type = "Consumption"
        }
      ]

      storage = [
        {
          name         = "seyacaenesa01"
          account_name = azurerm_storage_account.sa.name
          access_key   = azurerm_storage_account.sa.primary_access_key
          share_name   = azurerm_storage_share.share.name
          access_mode  = "ReadWrite"
        }
      ]

      monitoring = [
        {
          diag_name                  = "Monitoring"
          log_analytics_workspace_id = azurerm_log_analytics_workspace.la.id
          categories = {
            container_app_system_logs = false
          }
        }
      ]

      private_endpoint = [
        {
          name                          = "${local.naming.cae_1}-PE01"
          subnet_id                     = azurerm_subnet.private_endpoints.id
          custom_network_interface_name = "${local.naming.cae_1}-PE01.nic"
          private_service_connection = [
            {
              name                 = "${local.naming.cae_1}-PE01-connection"
              is_manual_connection = false
              subresource_names    = ["managedEnvironments"]
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

      tags = {}
    },
    {
      name                  = local.naming.cae_2
      location              = local.location
      resource_group_name   = azurerm_resource_group.rg.name
      public_network_access = "Enabled"

      tags = {}
    }
  ]
}
