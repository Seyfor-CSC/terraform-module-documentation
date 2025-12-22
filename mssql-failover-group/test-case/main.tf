terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.56.0"
    }
  }
  backend "local" {}
}

provider "azurerm" {
  resource_provider_registrations = "core"
  features {}
}

# module deployment prerequisites
resource "azurerm_resource_group" "rg" {
  name     = "SEY-MSSQLFAILOVER-NE-RG01"
  location = local.location
}

resource "azurerm_mssql_server" "mssql1" {
  name                         = "sey-mssqlfailover-ne-sql01"
  location                     = local.location
  resource_group_name          = azurerm_resource_group.rg.name
  version                      = "12.0"
  administrator_login          = "sqladmin"
  administrator_login_password = "P@ssw0rd1234"
}

resource "azurerm_mssql_server" "mssql2" {
  name                         = "sey-mssqlfailover-ne-sql02"
  location                     = local.location
  resource_group_name          = azurerm_resource_group.rg.name
  version                      = "12.0"
  administrator_login          = "sqladmin"
  administrator_login_password = "P@ssw0rd1234"
}

resource "azurerm_mssql_database" "mssql1_db1" {
  name      = "sey-mssqlfailover-ne-db01"
  server_id = azurerm_mssql_server.mssql1.id
}

resource "azurerm_mssql_database" "mssql1_db2" {
  name      = "sey-mssqlfailover-ne-db02"
  server_id = azurerm_mssql_server.mssql1.id
}

# mssql failover group
module "mssql_failover_group" {
  source = "git@github.com:Seyfor-CSC/mit.mssql-failover-group.git?ref=v2.3.0"
  config = local.mssql_failover_group
}

output "mssql_failover_group" {
  value = module.mssql_failover_group.outputs
}
