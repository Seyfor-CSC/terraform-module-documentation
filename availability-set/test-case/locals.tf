locals {
  location = "northeurope"

  naming = {
    rg      = "SEY-AVSET-NE-RG01"
    avset_1 = "SEY-TERRAFORM-NE-AVSET01"
    avset_2 = "SEY-TERRAFORM-NE-AVSET02"
  }

  avset = [
    {
      name                         = local.naming.avset_1
      location                     = local.location
      resource_group_name          = azurerm_resource_group.rg.name
      platform_update_domain_count = 4
      platform_fault_domain_count  = 2
      managed                      = false

      tags = {}
    },
    {
      name                = local.naming.avset_2
      location            = local.location
      resource_group_name = azurerm_resource_group.rg.name

      tags = {}
    }
  ]
}
