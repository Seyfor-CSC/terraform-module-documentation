locals {
  location = "northeurope"

  naming = {
    rg    = "SEY-TERRAFORM-NE-RG01"
    aa_1  = "SEY-TERRAFROM-NE-AA01"
    rsv_1 = "SEY-TERRAFORM-NE-RSV01"
  }

  pe = [
    {
      name                = "${local.naming.aa_1}-PE01"
      location            = local.location
      resource_group_name = local.naming.rg
      subnet_id           = azurerm_subnet.subnet.id
      resource_id         = azurerm_automation_account.aa.id
      private_service_connection = [
        {
          name                 = "${local.naming.aa_1}-PE01-connection"
          is_manual_connection = false
          subresource_names    = ["Webhook"]
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
          subresource_name   = "webhook"
        }
      ]

      tags = {}
    },
    {
      name                = "${local.naming.rsv_1}-PE01"
      location            = local.location
      resource_group_name = local.naming.rg
      subnet_id           = azurerm_subnet.subnet.id
      resource_id         = azurerm_recovery_services_vault.rsv.id
      private_service_connection = [
        {
          name                 = "${local.naming.rsv_1}-PE01-connection"
          is_manual_connection = false
          subresource_names    = ["AzureBackup"]
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
