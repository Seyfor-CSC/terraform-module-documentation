locals {
  location = "northeurope"

  naming = {
    rg   = "SEY-TERRAFORM-NE-RG01"
    nw1 = "SEY-TERRAFORM-NE-NW01"
    nw2 = "SEY-TERRAFORM-NE-NW02"
  }

    nw = [
    {
      name                = local.naming.nw1
      resource_group_name = local.naming.rg
      location            = local.location

      tags = {}
    },
    {
      name                = local.naming.nw2
      resource_group_name = local.naming.rg
      location            = local.location

      tags = {}
    }
  ]
}
