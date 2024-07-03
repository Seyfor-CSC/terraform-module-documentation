locals {
  location = "northeurope"

  naming = {
    rg     = "SEY-TERRAFORM-NE-RG01"
    pipp_1 = "SEY-TERRAFORM-NE-PIPP01"
    pipp_2 = "SEY-TERRAFORM-NE-PIPP02"
  }

  pipp = [
    {
      name                = local.naming.pipp_1
      location            = local.location
      resource_group_name = azurerm_resource_group.rg.name
      prefix_length       = 31
      zones               = ["2"]

      tags = {}

      monitoring = [
        {
          diag_name                  = "Monitoring"
          log_analytics_workspace_id = azurerm_log_analytics_workspace.la.id
          categories = {
            ddos_protection_notifications = false
          }
        }
      ]
    },
    {
      name                = local.naming.pipp_2
      location            = local.location
      resource_group_name = azurerm_resource_group.rg.name
      prefix_length       = 31

      tags = {}
    }
  ]
}
