locals {
  location = "northeurope"

  naming = {
    rg       = "SEY-TERRAFORM-NE-RG01"
    sqlsrv_1 = "SEY-TERRAFORM-NE-SQLSRV01"
    sqlsrv_2 = "SEY-TERRAFORM-NE-SQLSRV02"
  }

  sqlsrv = [
    {
      name                          = local.naming.sqlsrv_1
      location                      = local.location
      resource_group_name           = local.naming.rg
      administrator_login           = "useradmin"
      administrator_login_password  = "Password1234"
      public_network_access_enabled = true
      version                       = "12.0"
      identity = {
        type = "SystemAssigned"
      }
      mssql_elasticpool = [
        {
          name = "MSSQLElasticPool01"
          sku = {
            name     = "GP_Gen5"
            capacity = 4
            tier     = "GeneralPurpose"
            family   = "Gen5"
          }
          per_database_settings = {
            min_capacity = 0
            max_capacity = 4
          }
          max_size_gb = 500

          monitoring = [
            {
              diag_name                  = "Monitoring"
              log_analytics_workspace_id = azurerm_log_analytics_workspace.la.id
            }
          ]
        }
      ]
      mssql_db = [
        {
          name = "MSSQLDB01"

          db_auditing_policy = {
            enabled                = true
            log_monitoring_enabled = true
          }

          monitoring = [
            {
              diag_name                  = "Monitoring"
              log_analytics_workspace_id = azurerm_log_analytics_workspace.la.id
            }
          ]
        }
      ]
      firewall_rule = [
        {
          name             = "ClientIPAddress01"
          start_ip_address = "62.168.58.210"
          end_ip_address   = "62.168.58.210"
        }
      ]

      private_endpoint = [
        {
          name                          = "${local.naming.sqlsrv_1}-PE01"
          subnet_id                     = azurerm_subnet.subnet.id
          custom_network_interface_name = "${local.naming.sqlsrv_1}-PE01.nic"
          private_service_connection = [
            {
              name                 = "${local.naming.sqlsrv_1}-PE01-connection"
              is_manual_connection = false
              subresource_names    = ["sqlServer"]
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
        }
      ]

      tags = {}
    },
    {
      name                         = local.naming.sqlsrv_2
      location                     = local.location
      resource_group_name          = local.naming.rg
      administrator_login          = "seyadmin"
      administrator_login_password = "sqladm123+"
      version                      = "12.0"

      tags = {}
    }
  ]
}
