locals {
  location = "northeurope"

  naming = {
    rg   = "SEY-TERRAFORM-NE-RG01"
    avset_1 = "SEY-TERRAFORM-NE-AVSET01"
    avset_2 = "SEY-TERRAFORM-NE-AVSET02"
  }

    avset = [
    {
      name                = local.naming.avset_1
      location            = local.location
      resource_group_name = local.naming.rg

      tags = {}
    },
    {
      name                = local.naming.avset_2
      location            = local.location
      resource_group_name = local.naming.rg

      tags = {}
    }
  ]
}
