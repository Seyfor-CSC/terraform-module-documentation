locals {
  location = "northeurope"

  naming = {
    rg   = "SEY-LA-NE-RG01"
    la_1 = "SEY-TERRAFORM-NE-LA01"
    la_2 = "SEY-TERRAFORM-NE-LA02"
    la_3 = "SEY-TERRAFORM-NE-LA03"
  }

  la = [
    {
      name                = local.naming.la_1
      location            = local.location
      resource_group_name = azurerm_resource_group.rg.name

      monitoring = [
        {
          diag_name                  = "Monitoring"
          log_analytics_workspace_id = azurerm_log_analytics_workspace.la.id
          categories = {
            audit = false
          }
        }
      ]

      tags = {}
    },
    {
      name                = local.naming.la_2
      location            = local.location
      resource_group_name = azurerm_resource_group.rg.name

      tags = {}

      monitoring = [
        {
          diag_name    = "Monitoring"
          self_logging = true
        }
      ]
    },
    {
      name                = local.naming.la_3
      location            = local.location
      resource_group_name = azurerm_resource_group.rg.name

      tags = {}
    }
  ]
}
