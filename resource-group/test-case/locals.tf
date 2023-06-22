locals {
  location = "northeurope"

  naming = {
    rg_1 = "SEY-TERRAFORM-NE-RG01"
    rg_2 = "SEY-TERRAFORM-NE-RG02"
  }

  rg = [
    {
      name     = local.naming.rg_1
      location = local.location

      tags = {}
    },
    {
      name     = local.naming.rg_2
      location = local.location

      tags = {}
    }
  ]
}

