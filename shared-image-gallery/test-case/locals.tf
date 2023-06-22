locals {
  location = "northeurope"

  naming = {
    rg    = "SEY-TERRAFORM-NE-RG01"
    acg_1 = "seyterraformneacg01"
    acg_2 = "seyterraformneacg02"
  }

    acg = [
    {
      name                = local.naming.acg_1
      location            = local.location
      resource_group_name = local.naming.rg
      description         = "Shared Image Gallery with customized OS images for deployment across various subscriptions and locations."
      tags                = {}
    },
    {
      name                = local.naming.acg_2
      location            = local.location
      resource_group_name = local.naming.rg
      tags                = {}
    }
  ]
}
