locals {
  location = "northeurope"

  naming = {
    rg     = "SEY-TERRAFORM-NE-RG01"
    vnet_1 = "SEY-TERRAFORM-NE-VNET01"
    vnet_2 = "SEY-TERRAFORM-NE-VNET02"
  }

  peering = [
    {
      name                      = azurerm_virtual_network.vnet_2.name
      virtual_network_name      = azurerm_virtual_network.vnet_1.name
      resource_group_name       = azurerm_resource_group.rg.name
      remote_virtual_network_id = azurerm_virtual_network.vnet_2.id
      hub_spoke                 = true
      triggers = {
        remote_address_space = join(",", azurerm_virtual_network.vnet_2.address_space)
      }
    },
    {
      name                      = azurerm_virtual_network.vnet_1.name
      virtual_network_name      = azurerm_virtual_network.vnet_2.name
      resource_group_name       = azurerm_resource_group.rg.name
      remote_virtual_network_id = azurerm_virtual_network.vnet_1.id
      spoke_hub                 = true
    }
  ]
}
