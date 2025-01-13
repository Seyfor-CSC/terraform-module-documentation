locals {
  location1 = "northeurope"
  location2 = "westeurope"

  naming = {
    rg  = "SEY-NETWORKW-NE-RG01"
    nw1 = "SEY-TERRAFORM-NE-NW01"
    nw2 = "SEY-TERRAFORM-WE-NW02"
  }

  nw = [
    {
      name                = local.naming.nw1
      resource_group_name = azurerm_resource_group.rg.name
      location            = local.location1

      tags = {}
    },
    {
      name                = local.naming.nw2
      resource_group_name = azurerm_resource_group.rg.name
      location            = local.location2

      tags = {}
    }
  ]
}
