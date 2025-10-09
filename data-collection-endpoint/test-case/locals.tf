locals {
  location = "northeurope"

  naming = {
    dce1 = "SEY-TERRAFORM-NE-DCE01"
    dce2 = "SEY-TERRAFORM-NE-DCE02"
  }

  dce = [
    {
      name                          = local.naming.dce1
      resource_group_name           = azurerm_resource_group.rg.name
      location                      = local.location
      description                   = "example description"
      kind                          = "Windows"
      public_network_access_enabled = true
      tags                          = { key = "value" }
    },
    {
      name                = local.naming.dce2
      resource_group_name = azurerm_resource_group.rg.name
      location            = local.location
    }
  ]
}
