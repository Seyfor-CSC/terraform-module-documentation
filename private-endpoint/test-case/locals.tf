locals {
  location = "northeurope"

  naming = {
    rg   = "SEY-PE-NE-RG01"
    sa_1 = "seypenesa01"
    sa_2 = "seypenesa02"
  }

  pe = [
    {
      name                = "${local.naming.sa_1}-PE01"
      location            = local.location
      resource_group_name = azurerm_resource_group.rg.name
      subnet_id           = azurerm_subnet.subnet.id
      resource_id         = azurerm_storage_account.sa_1.id
      private_service_connection = [
        {
          name                 = "${local.naming.sa_1}-PE01-connection"
          is_manual_connection = false
          subresource_names    = ["Blob"]
        }
      ]
      private_dns_zone_group = {
        name = azurerm_private_dns_zone.dns.name
        private_dns_zone_ids = [
          azurerm_private_dns_zone.dns.id
        ]
      }
      ip_configuration = [
        {
          name               = "privateEndpointIpConfig01"
          private_ip_address = "10.0.1.10"
          subresource_name   = "blob"
          member_name        = "blob"
        },
        {
          name               = "privateEndpointIpConfig02"
          private_ip_address = "10.0.1.11"
          subresource_name   = "blob"
          member_name        = "sync"
        },
        {
          name               = "privateEndpointIpConfig03"
          private_ip_address = "10.0.1.12"
          subresource_name   = "blob"
          member_name        = "ops"
        }
      ]

      tags = {}
    },
    {
      name                = "${local.naming.sa_2}-PE01"
      location            = local.location
      resource_group_name = azurerm_resource_group.rg.name
      subnet_id           = azurerm_subnet.subnet.id
      resource_id         = azurerm_storage_account.sa_2.id
      private_service_connection = [
        {
          name                 = "${local.naming.sa_2}-PE01-connection"
          is_manual_connection = false
          subresource_names    = ["Blob"]
        }
      ]
      private_dns_zone_group = {
        name = azurerm_private_dns_zone.dns.name
        private_dns_zone_ids = [
          azurerm_private_dns_zone.dns.id
        ]
      }

      tags = {}
    }
  ]
}
