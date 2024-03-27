locals {
  location = "northeurope"

  naming = {
    rg   = "SEY-TERRAFORM-NE-RG01"
    rt_1 = "SEY-TERRAFORM-NE-RT01"
    rt_2 = "SEY-TERRAFORM-NE-RT02"
  }

    rt = [
    {
      name                = local.naming.rt_1
      location            = local.location
      resource_group_name = azurerm_resource_group.rg.name
      routes = [
        {
          name           = "sey-route-01"
          address_prefix = "10.0.0.0/24"
          next_hop_type  = "VnetLocal"
        },
        {
          name           = "sey-route-02"
          address_prefix = "10.0.1.0/24"
          next_hop_type  = "VnetLocal"
        }
      ]

      tags = {}
    },
    {
      name                = local.naming.rt_2
      location            = local.location
      resource_group_name = azurerm_resource_group.rg.name

      tags = {}
    }
  ]
}
