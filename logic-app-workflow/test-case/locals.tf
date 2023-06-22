locals {
  location = "northeurope"

  naming = {
    rg      = "SEY-TERRAFORM-NE-RG01"
    logic_1 = "SEY-TERRAFORM-NE-LOGIC01"
    logic_2 = "SEY-TERRAFORM-NE-LOGIC02"
  }

    logic = [
    {
      name                = local.naming.logic_1
      location            = local.location
      resource_group_name = local.naming.rg
      identity = {
        type = "SystemAssigned"
      }

      tags = {}
    },
    {
      name                = local.naming.logic_2
      location            = local.location
      resource_group_name = local.naming.rg

      tags = {}
    }
  ]
}
