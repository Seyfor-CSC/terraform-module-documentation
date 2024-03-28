locals {
  location = "northeurope"

  naming = {
    rg    = "SEY-TERRAFORM-NE-RG01"
    pip_1 = "SEY-TERRAFORM-NE-PIP01"
    pip_2 = "SEY-TERRAFORM-NE-PIP02"
  }

  pip = [
    {
      name                = local.naming.pip_1
      location            = local.location
      resource_group_name = azurerm_resource_group.rg.name
      allocation_method   = "Static"

      monitoring = [
        {
          diag_name                  = "Monitoring"
          log_analytics_workspace_id = azurerm_log_analytics_workspace.la.id
          categories = {
            ddos_protection_notifications = false
          }
        }
      ]

      tags = {}
    },
    {
      name                = local.naming.pip_2
      location            = local.location
      resource_group_name = azurerm_resource_group.rg.name
      allocation_method   = "Static"

      tags = {}
    }
  ]
}
