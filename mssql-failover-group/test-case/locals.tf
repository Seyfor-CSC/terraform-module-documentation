locals {
  location = "northeurope"

  naming = {
    fg1 = "sey-terrafrom-ne-fg01"
  }

  mssql_failover_group = [
    {
      name      = local.naming.fg1
      server_id = azurerm_mssql_server.mssql1.id
      partner_server = {
        id = azurerm_mssql_server.mssql2.id
      }
      databases = [
        azurerm_mssql_database.mssql1_db1.id,
        azurerm_mssql_database.mssql1_db2.id
      ]
      readonly_endpoint_failover_policy_enabled = true
      read_write_endpoint_failover_policy = {
        mode          = "Automatic"
        grace_minutes = 60
      }
    }
  ]
}
