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

      tags = {}
    },
    {
      name                = local.naming.cae_2
      location            = local.location
      resource_group_name = azurerm_resource_group.rg.name

      tags = {}
    }
  ]
}
