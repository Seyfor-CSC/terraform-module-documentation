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
      resource_group_name = local.naming.rg
      prefix_length       = 31

      tags = {}
    },
    {
      name                = local.naming.pipp_2
      location            = local.location
      resource_group_name = local.naming.rg
      prefix_length       = 31

      tags = {}
    }
  ]
}
