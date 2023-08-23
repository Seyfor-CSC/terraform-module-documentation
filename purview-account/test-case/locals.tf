
locals {
  location = "westeurope"

  naming = {
    rg   = "SEY-PURVIEW-WE-RG01"
    pa_1 = "SEY-PURVIEW-WE-PA01"
    pa_2 = "SEY-PURVIEW-WE-PA02"
  }


  purview_account = [
    {
      name                = local.naming.pa_1
      resource_group_name = local.naming.rg
      location            = local.location
      identity = {
        type = "SystemAssigned"
      }
      public_network_enabled      = true
      managed_resource_group_name = "SEY-PURVIEW-WE-RG02"
    },
    {
      name                = local.naming.pa_2
      resource_group_name = local.naming.rg
      location            = local.location
      identity = {
        type = "SystemAssigned"
      }
    }
  ]
}
