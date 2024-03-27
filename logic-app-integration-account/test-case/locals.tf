locals {
  location = "northeurope"

  naming = {
    rg   = "SEY-TERRAFORM-NE-RG01"
    ia_1 = "SEY-TERRAFORM-NE-IA01"
    ia_2 = "SEY-TERRAFORM-NE-IA02"
  }

  ia = [
    {
      name                = local.naming.ia_1
      location            = local.location
      resource_group_name = azurerm_resource_group.rg.name
      sku_name            = "Basic"

      monitoring = [
        {
          diag_name                  = "Monitoring"
          log_analytics_workspace_id = azurerm_log_analytics_workspace.la.id
        }
      ]

      tags = {}
    },
    {
      name                = local.naming.ia_2
      location            = local.location
      resource_group_name = azurerm_resource_group.rg.name
      sku_name            = "Free"

      tags = {}
    }
  ]
}
