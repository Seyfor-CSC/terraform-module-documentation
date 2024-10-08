
locals {
  location = "northeurope"

  naming = {
    rg      = "SEY-PURVIEW-NE-RG01"
    purview = "SEY-TERRAFORM-NE-PURVIEW01"
  }


  purview_account = [
    {
      name                = local.naming.purview
      resource_group_name = azurerm_resource_group.rg.name
      location            = local.location
      identity = {
        type = "SystemAssigned"
      }
      managed_resource_group_name = "${local.naming.rg}-DYN"

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
