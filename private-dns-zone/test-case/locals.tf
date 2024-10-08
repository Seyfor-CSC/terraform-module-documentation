locals {
  location = "northeurope"

  naming = {
    rg    = "SEY-PDNSZONE-NE-RG01"
    dns_1 = "sey.blob.core.windows.net"
    dns_2 = "sey.file.core.windows.net"
  }

  dns = [
    {
      name                = local.naming.dns_1
      resource_group_name = azurerm_resource_group.rg.name
      virtual_network_links = [
        {
          name               = "sey-infra-ne-vnet01-link"
          virtual_network_id = azurerm_virtual_network.vnet1.id
        },
        {
          name               = "sey-infra-ne-vnet02-link"
          virtual_network_id = azurerm_virtual_network.vnet2.id
        }
      ]

      tags = {}
    },
    {
      name                = local.naming.dns_2
      resource_group_name = azurerm_resource_group.rg.name

      tags = {}
    }
  ]
}
