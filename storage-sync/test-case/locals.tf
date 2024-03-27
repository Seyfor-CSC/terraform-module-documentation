locals {
  location = "northeurope"

  naming = {
    rg      = "SEY-TERRAFORM-NE-RG01"
    sync_1  = "SEY-TERRAFORM-NE-SYNC01"
    sync_2  = "SEY-TERRAFORM-NE-SYNC02"
    group_1 = "SEY-TERRAFORM-NE-GROUP01"
    group_2 = "SEY-TERRAFORM-NE-GROUP02"
  }

  sync = [
    {
      name                = local.naming.sync_1
      location            = local.location
      resource_group_name = azurerm_resource_group.rg.name
      identity = {
        type = "SystemAssigned"
      }

      sync_group = [
        {
          name = local.naming.group_1
        },
        {
          name = local.naming.group_2
        }
      ]

      private_endpoint = [
        {
          name                          = "${local.naming.sync_1}-PE01"
          subnet_id                     = azurerm_subnet.subnet.id
          custom_network_interface_name = "${local.naming.sync_1}-PE01.nic"
          private_service_connection = [
            {
              name                 = "${local.naming.sync_1}-PE01-connection"
              is_manual_connection = false
              subresource_names    = ["Afs"]
            }
          ]
          private_dns_zone_group = {
            name = azurerm_private_dns_zone.dns.name
            private_dns_zone_ids = [
              azurerm_private_dns_zone.dns.id
            ]
          }
        }
      ]

      tags = {}
    },
    {
      name                = local.naming.sync_2
      location            = local.location
      resource_group_name = azurerm_resource_group.rg.name

      tags = {}
    }
  ]
}
