locals {
  location = "northeurope"

  naming = {
    rg   = "SEY-MANAGEDREDIS-NE-RG01"
    mr_1 = "SEY-TERRAFORM-NE-MR01"
    mr_2 = "SEY-TERRAFORM-NE-MR02"
  }

  managed_redis = [
    {
      name                      = local.naming.mr_1
      location                  = local.location
      resource_group_name       = azurerm_resource_group.rg.name
      sku_name                  = "Balanced_B3"
      high_availability_enabled = true
      public_network_access     = "Disabled"

      identity = {
        type = "SystemAssigned"
      }

      default_database = {
        access_keys_authentication_enabled            = false
        client_protocol                               = "Encrypted"
        clustering_policy                             = "EnterpriseCluster"
        eviction_policy                               = "NoEviction"
        geo_replication_group_name                    = null
        persistence_append_only_file_backup_frequency = null
        persistence_redis_database_backup_frequency   = "6h"
        module = [
          {
            name = "RedisJSON"
            args = null
          },
          {
            name = "RediSearch"
            args = null
          },
          {
            name = "RedisBloom"
            args = "ERROR_RATE 0.01 INITIAL_SIZE 1000"
          }
        ]

        monitoring = [
          {
            diag_name                  = "Monitoring"
            log_analytics_workspace_id = azurerm_log_analytics_workspace.la.id
          }
        ]
      }

      monitoring = [
        {
          diag_name                  = "Monitoring"
          log_analytics_workspace_id = azurerm_log_analytics_workspace.la.id
        }
      ]

      private_endpoint = [
        {
          name                          = "${local.naming.mr_1}-PE01"
          subnet_id                     = azurerm_subnet.subnet.id
          custom_network_interface_name = "${local.naming.mr_1}-PE01.nic"
          private_service_connection = [
            {
              name                 = "${local.naming.mr_1}-PE01-connection"
              is_manual_connection = false
              subresource_names    = ["redisEnterprise"]
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

      tags = {
        Environment = "Test"
      }
    },
    {
      name                  = local.naming.mr_2
      location              = local.location
      resource_group_name   = azurerm_resource_group.rg.name
      sku_name              = "Balanced_B0"
      public_network_access = "Enabled"

      tags = {}
    }
  ]
}

