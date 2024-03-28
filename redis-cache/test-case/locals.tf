locals {
  location = "northeurope"

  naming = {
    rg   = "SEY-TERRAFORM-NE-RG01"
    rc_1 = "SEY-TERRAFORM-NE-RC01"
    rc_2 = "SEY-TERRAFORM-NE-RC02"
  }

  redis_cache = [
    {
      name                = local.naming.rc_1
      location            = local.location
      resource_group_name = azurerm_resource_group.rg.name
      capacity            = 2
      family              = "P"
      sku_name            = "Premium"
      enable_non_ssl_port = false
      redis_version       = 6
      identity = {
        type = "SystemAssigned"
      }
      patch_schedule = [
        {
          day_of_week    = "Monday"
          start_hour_utc = 20
        }
      ]
      redis_configuration = {
        maxmemory_reserved              = 3000
        rdb_storage_connection_string   = azurerm_storage_account.sa.primary_blob_connection_string
        enable_authentication           = true
        maxmemory_policy                = "volatile-random"
        maxfragmentationmemory_reserved = 5000
      }

      monitoring = [
        {
          diag_name                  = "Monitoring"
          log_analytics_workspace_id = azurerm_log_analytics_workspace.la.id
          categories = {
            connected_client_list = false
          }
        }
      ]

      private_endpoint = [
        {
          name                          = "${local.naming.rc_1}-PE01"
          subnet_id                     = azurerm_subnet.subnet.id
          custom_network_interface_name = "${local.naming.rc_1}-PE01.nic"
          private_service_connection = [
            {
              name                 = "${local.naming.rc_1}-PE01-connection"
              is_manual_connection = false
              subresource_names    = ["redisCache"]
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
      name                = local.naming.rc_2
      location            = local.location
      resource_group_name = azurerm_resource_group.rg.name
      capacity            = 2
      family              = "C"
      sku_name            = "Standard"
      patch_schedule = [
        {
          day_of_week    = "Friday"
          start_hour_utc = 20
        }
      ]
      redis_configuration = {
        maxmemory_reserved              = 350
        enable_authentication           = true
        maxfragmentationmemory_reserved = 300
      }

      tags = {}
    }
  ]
}
