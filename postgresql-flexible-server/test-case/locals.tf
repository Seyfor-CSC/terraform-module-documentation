locals {
  location = "northeurope"

  naming = {
    rg      = "SEY-PGSQL-NE-RG01"
    pgsql_1 = "sey-terraform-ne-pgsql01"
    pgsql_2 = "sey-terraform-ne-pgsql02"
  }

  pgsql = [
    {
      name                   = local.naming.pgsql_1
      location               = local.location
      resource_group_name    = azurerm_resource_group.rg.name
      version                = "14"
      sku_name               = "GP_Standard_D4s_v3"
      administrator_login    = "useradmin"
      administrator_password = "Password1234+"
      storage_mb             = "32768"
      authentication = {
        active_directory_auth_enabled = true
      }

      flexible_db = [
        {
          name = "seypgsqldb01"
        }
      ]

      server_configuration = [
        {
          name  = "backslash_quote"
          value = "on"
        }
      ]

      server_ad_administrator = [
        {
          tenant_id      = data.azurerm_client_config.current.tenant_id
          object_id      = data.azurerm_client_config.current.object_id
          principal_name = "exampleuser"
          principal_type = "User"
        }
      ]

      private_endpoint = [
        {
          name                          = "${local.naming.pgsql_1}-PE01"
          subnet_id                     = azurerm_subnet.subnet.id
          custom_network_interface_name = "${local.naming.pgsql_1}-PE01.nic"
          private_service_connection = [
            {
              name                 = "${local.naming.pgsql_1}-PE01-connection"
              is_manual_connection = false
              subresource_names    = ["postgresqlServer"]
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
          categories = {
            postgre_sql_logs = false
          }
        }
      ]

      tags = {}
    },
    {
      name                          = local.naming.pgsql_2
      location                      = local.location
      resource_group_name           = azurerm_resource_group.rg.name
      version                       = "14"
      sku_name                      = "GP_Standard_D4s_v3"
      administrator_login           = "useradmin"
      administrator_password        = "Password1234+"
      backup_retention_days         = 14
      geo_redundant_backup_enabled  = true
      storage_mb                    = "32768"
      public_network_access_enabled = true

      backup_instance_postgresql = {
        name               = "${local.naming.pgsql_2}-backup"
        vault_id           = azurerm_data_protection_backup_vault.backup_vault.id
        backup_policy_id   = azurerm_data_protection_backup_policy_postgresql_flexible_server.postgresql_policy.id
        vault_principal_id = azurerm_data_protection_backup_vault.backup_vault.identity[0].principal_id
      }

      tags = {}
    }
  ]
}
