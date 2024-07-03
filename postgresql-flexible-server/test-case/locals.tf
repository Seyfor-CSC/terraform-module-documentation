locals {
  location = "northeurope"

  naming = {
    rg      = "SEY-TERRAFORM-NE-RG01"
    pgsql_1 = "seyterraformnepgsql01"
    pgsql_2 = "seyterraformnepgsql02"
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
          name = "flexibledbexample"
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
      storage_mb                    = "32768"
      public_network_access_enabled = true

      tags = {}
    }
  ]
}
