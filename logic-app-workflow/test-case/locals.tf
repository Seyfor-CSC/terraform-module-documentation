locals {
  location = "northeurope"

  naming = {
    rg      = "SEY-TERRAFORM-NE-RG01"
    logic_1 = "SEY-TERRAFORM-NE-LOGIC01"
    logic_2 = "SEY-TERRAFORM-NE-LOGIC02"
  }

  logic = [
    {
      name                = local.naming.logic_1
      location            = local.location
      resource_group_name = local.naming.rg
      identity = {
        type = "SystemAssigned"
      }

      monitoring = [
        {
          diag_name                  = "Monitoring"
          log_analytics_workspace_id = azurerm_log_analytics_workspace.la.id
          categories = {
            workflow_runtime = false
          }
        }
      ]

      tags = {}
    },
    {
      name                = local.naming.logic_2
      location            = local.location
      resource_group_name = local.naming.rg

      tags = {}
    }
  ]
}
