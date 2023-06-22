locals {
  location = "northeurope"

  naming = {
    rg   = "SEY-TERRAFORM-NE-RG01"
    kv_1 = "SEY-TERRAFORM-NE-KV01"
    kv_2 = "SEY-TERRAFORM-NE-KV02"
  }

  kv = [
    {
      name                = local.naming.kv_1
      location            = local.location
      resource_group_name = local.naming.rg
      sku_name            = "standard"
      secret = [
        {
          name = "FirstSecret" # Generates random password 12 characters long
        },
        {
          name   = "SecondSecret"
          length = 16 # Generates random password 16 characters long
        },
        {
          name  = "ThirdSecret"
          value = "Password1234" # Sets the secret value to "Password1234"
        }
      ]

      private_endpoint = [
        {
          name                          = "${local.naming.kv_1}-PE01"
          subnet_id                     = azurerm_subnet.subnet.id
          custom_network_interface_name = "${local.naming.kv_1}-PE01.nic"
          private_service_connection = [
            {
              name                 = "${local.naming.kv_1}-PE01-connection"
              is_manual_connection = false
              subresource_names    = ["vault"]
            }
          ]
          private_dns_zone_group = [
            {
              name = azurerm_private_dns_zone.dns.name
              private_dns_zone_ids = [
                azurerm_private_dns_zone.dns.id
              ]
            }
          ]
        }
      ]

      monitoring = [
        {
          diag_name                  = "Monitoring"
          log_analytics_workspace_id = azurerm_log_analytics_workspace.la.id
        }
      ]

      tags = {}
    },
    {
      name                = local.naming.kv_2
      location            = local.location
      resource_group_name = local.naming.rg
      sku_name            = "standard"

      tags = {}
    }
  ]
}
