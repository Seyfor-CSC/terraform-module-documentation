locals {
  location = "northeurope"

  naming = {
    rg   = "SEY-TERRAFORM-NE-RG01"
    la_1 = "SEY-TERRAFORM-NE-LA01"
    la_2 = "SEY-TERRAFORM-NE-LA02"
  }

    la = [
    {
      name                = local.naming.la_1
      location            = local.location
      resource_group_name = local.naming.rg

      monitoring = [
        {
          diag_name                  = "Monitoring"
          log_analytics_workspace_id = azurerm_log_analytics_workspace.la.id
        }
      ]

      tags = {}
    },
    {
      name                = local.naming.la_2
      location            = local.location
      resource_group_name = local.naming.rg

      tags = {}
    }
  ]
}
