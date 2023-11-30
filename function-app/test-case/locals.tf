locals {
  location = "northeurope"

  naming = {
    rg   = "SEY-TERRAFORM-NE-RG01"
    fa_1 = "SEY-TERRAFORM-NE-FA01"
    fa_2 = "SEY-TERRAFORM-NE-FA02"
  }

  func_app = [
    {
      os_type                    = "Linux"
      name                       = local.naming.fa_1
      location                   = local.location
      resource_group_name        = local.naming.rg
      service_plan_id            = azurerm_service_plan.plan.id
      storage_account_name       = azurerm_storage_account.sa.name
      storage_account_access_key = azurerm_storage_account.sa.primary_access_key

      site_config = {}

      identity = {
        type = "SystemAssigned"
      }

      private_endpoint = [
        {
          name                          = "${local.naming.fa_1}-PE01"
          subnet_id                     = azurerm_subnet.subnet.id
          custom_network_interface_name = "${local.naming.fa_1}-PE01.nic"
          private_service_connection = [
            {
              name                 = "${local.naming.fa_1}-PE01-connection"
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

      tags = {}
    },
    {
      os_type                    = "Windows"
      name                       = local.naming.fa_2
      location                   = local.location
      resource_group_name        = local.naming.rg
      service_plan_id            = azurerm_service_plan.plan.id
      storage_account_name       = azurerm_storage_account.sa.name
      storage_account_access_key = azurerm_storage_account.sa.primary_access_key

      site_config = {}

      tags = {}
    }
  ]
}
