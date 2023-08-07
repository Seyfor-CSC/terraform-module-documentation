locals {
  location = "northeurope"

  naming = {
    rg     = "SEY-TERRAFORM-NE-RG01"
    vnet_1 = "SEY-TERRAFORM-NE-VNET01"
    vnet_2 = "SEY-TERRAFORM-NE-VNET02"
  }

  peering = [
    {
      name                      = local.naming.vnet_2
      virtual_network_name      = local.naming.vnet_1
      resource_group_name       = local.naming.rg
      remote_virtual_network_id = azurerm_virtual_network.vnet_2.id
      hub_spoke                 = true
      triggers = {
        remote_address_space = join(",", azurerm_virtual_network.vnet_2.address_space)
      }
    },
    {
      name                      = local.naming.vnet_1
      virtual_network_name      = local.naming.vnet_2
      resource_group_name       = local.naming.rg
      remote_virtual_network_id = azurerm_virtual_network.vnet_1.id
      spoke_hub                 = true
    }
  ]
}
