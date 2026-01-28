locals {
  location = "northeurope"

  naming = {
    rg    = "SEY-CRG-NE-RG01"
    crg_1 = "SEY-TERRAFORM-NE-CRG01"
    crg_2 = "SEY-TERRAFORM-NE-CRG02"
  }

  capacity_reservation_group = [
    {
      name                = local.naming.crg_1
      location            = local.location
      resource_group_name = azurerm_resource_group.rg.name
      zones               = ["1", "2", "3"]
      tags                = {}
    },
    {
      name                = local.naming.crg_2
      location            = local.location
      resource_group_name = azurerm_resource_group.rg.name
    }
  ]
}
