locals {
  location = "northeurope"

  naming = {
    rg    = "MIT-TERRAFORM-NE-RG01"
    cae_1 = "MIT-TERRAFORM-NE-CAE01"
    cae_2 = "MIT-TERRAFORM-NE-CAE02"
  }

  cae = [
    {
      name                       = local.naming.cae_1
      location                   = local.location
      resource_group_name        = azurerm_resource_group.rg.name
      infrastructure_subnet_id   = azurerm_subnet.subnet.id
      log_analytics_workspace_id = azurerm_log_analytics_workspace.la.id

      workload_profile = {
        name                  = "Consumption"
        workload_profile_type = "Consumption"
      }

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
