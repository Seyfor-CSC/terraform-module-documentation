
locals {
  location = "westeurope"

  naming = {
    rg   = "SEY-PURVIEW-WE-RG01"
    pa_1 = "SEY-PURVIEW-WE-PA01"
  }


  purview_account = [
    {
      name                = local.naming.pa_1
      resource_group_name = azurerm_resource_group.rg.name
      location            = local.location
      identity = {
        type = "SystemAssigned"
      }
      managed_resource_group_name = "SEY-PURVIEW-WE-RG02"

      monitoring = [
        {
          diag_name                  = "Monitoring"
          log_analytics_workspace_id = azurerm_log_analytics_workspace.la.id
          categories = {
            security = false
          }
        }
      ]
    }
  ]
}
