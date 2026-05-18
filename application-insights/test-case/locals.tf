locals {
  location = "northeurope"

  naming = {
    rg     = "SEY-APPI-NE-RG01"
    appi_1 = "SEY-TERRAFORM-NE-APPI01"
    appi_2 = "SEY-TERRAFORM-NE-APPI02"
  }

  config = [
    {
      name                = local.naming.appi_1
      location            = local.location
      resource_group_name = azurerm_resource_group.rg.name
      application_type    = "web"
      workspace_id        = azurerm_log_analytics_workspace.la.id
      retention_in_days   = 30

      tags = {}
    },
    {
      name                = local.naming.appi_2
      location            = local.location
      resource_group_name = azurerm_resource_group.rg.name
      application_type    = "web"

      tags = {}
    }
  ]
}
