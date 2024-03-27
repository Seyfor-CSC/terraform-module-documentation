locals {
  location = "northeurope"

  naming = {
    rg    = "SEY-TERRAFORM-NE-RG01"
    asp_1 = "SEY-TERRAFORM-NE-ASP01"
    asp_2 = "SEY-TERRAFORM-NE-ASP02"
  }

  asp = [
    {
      name                         = local.naming.asp_1
      resource_group_name          = azurerm_resource_group.rg.name
      location                     = local.location
      os_type                      = "Windows"
      sku_name                     = "P1v2"
      worker_count                 = 3
      per_site_scaling_enabled     = true
      zone_balancing_enabled       = true

      monitoring = [
        {
          diag_name                  = "Monitoring"
          log_analytics_workspace_id = azurerm_log_analytics_workspace.la.id
        }
      ]

      tags = {}
    },
    {
      name                = local.naming.asp_2
      resource_group_name = azurerm_resource_group.rg.name
      location            = local.location
      os_type             = "Linux"
      sku_name            = "B1"

      tags = {}
    }
  ]
}
