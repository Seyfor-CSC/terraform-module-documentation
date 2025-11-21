locals {
  location = "northeurope"

  naming = {
    rg   = "SEY-SA-NE-RG01"
    sa_1 = "seyterraformnesa01"
    sa_2 = "seyterraformnesa02"
  }

  sa = [
    {
      name                          = local.naming.sa_1
      location                      = local.location
      resource_group_name           = azurerm_resource_group.rg.name
      account_tier                  = "Standard"
      account_replication_type      = "LRS"
      public_network_access_enabled = true
      enable_https_traffic_only     = false
      network_rules = {
        default_action = "Allow"
      }
      identity = {
        type = "SystemAssigned"
      }
      blob_properties = {
        delete_retention_policy = {
          days = 35
        }
        restore_policy = {
          days = 30
        }
        versioning_enabled            = true
        change_feed_enabled           = true
        change_feed_retention_in_days = 35
        last_access_time_enabled      = false
        container_delete_retention_policy = {
          days = 30
        }
      }

      backup_container = {
        recovery_vault_name = azurerm_recovery_services_vault.rsv.name
      }

      backup_instance_blob_storage = {
        name                            = "${local.naming.sa_1}-blob-backup"
        vault_id                        = azurerm_data_protection_backup_vault.backup_vault.id
        backup_policy_id                = azurerm_data_protection_backup_policy_blob_storage.blob_policy.id
        storage_account_container_names = ["container1", "container2"]
      }

      containers = [
        {
          name = "container1"
        },
        {
          name = "container2"
        }
      ]

      file_shares = [
        {
          name  = "share1"
          quota = 50

          share_backup = {
            recovery_vault_name = azurerm_recovery_services_vault.rsv.name
            backup_policy_id    = azurerm_backup_policy_file_share.example.id
          }
        },
        {
          name  = "share2"
          quota = 100
        }
      ]

      queues = [
        {
          name = "queue1"
        }
      ]

      tables = [
        {
          name = "table1"
        },
        {
          name = "table2"
        }
      ]

      management_policy = {
        rule = [
          {
            name = "DeletePreviousVersions"
            filters = {
              blob_types = ["blockBlob", "appendBlob"]
            }
            actions = {
              version = {
                delete_after_days_since_creation = 30
              }
            }
          }
        ]
      }

      private_endpoint = [
        {
          name                          = "${local.naming.sa_1}-PE01"
          subnet_id                     = azurerm_subnet.subnet.id
          custom_network_interface_name = "${local.naming.sa_1}-PE01.nic"
          private_service_connection = [
            {
              name                 = "${local.naming.sa_1}-PE01-connection"
              is_manual_connection = false
              subresource_names    = ["blob"]
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

      monitoring = [
        {
          diag_name                  = "Monitoring"
          log_analytics_workspace_id = azurerm_log_analytics_workspace.la.id
          categories_queue = {
            storage_read = false
          }
        }
      ]

      tags = {}
    },
    {
      name                          = local.naming.sa_2
      location                      = local.location
      resource_group_name           = azurerm_resource_group.rg.name
      account_tier                  = "Standard"
      account_replication_type      = "LRS"
      public_network_access_enabled = true

      tags = {}
    }
  ]
}
