# Introduction
MSSQL Database module can deploy these resources:
* azurerm_mssql_server (required)
* azurerm_mssql_database (optional)
* azurerm_mssql_database_extended_auditing_policy (optional)
* azurerm_mssql_firewall_rule (optional)
* azurerm_mssql_elasticpool (optional)
* azurerm_monitor_diagnostic_setting (optional)
* azurerm_private_endpoint (optional)

Example variables structure is located in [variables.md](variables.md).

Example use case is located in [test-case/locals.tf](test-case/locals.tf).

You can also see [changelog](CHANGELOG.md).

Terraform documentation:

https://registry.terraform.io/providers/hashicorp/azurerm/4.1.0/docs/resources/mssql_server

https://registry.terraform.io/providers/hashicorp/azurerm/4.1.0/docs/resources/mssql_database

https://registry.terraform.io/providers/hashicorp/azurerm/4.1.0/docs/resources/mssql_database_extended_auditing_policy

https://registry.terraform.io/providers/hashicorp/azurerm/4.1.0/docs/resources/mssql_elasticpool

https://registry.terraform.io/providers/hashicorp/azurerm/4.1.0/docs/resources/mssql_firewall_rule

https://registry.terraform.io/providers/hashicorp/azurerm/4.1.0/docs/resources/monitor_diagnostic_setting

https://registry.terraform.io/providers/hashicorp/azurerm/4.1.0/docs/resources/private_endpoint

&nbsp;

> **WARNING:** AzureRM provider had been updated to a new major version. Many breaking changes were implemented. See the [providers guide](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/4.0-upgrade-guide) for more information.

# Terraform Import
There are a few things you need to do to import resources into .tfstate. In the example below there are resources which can be imported within the module. You may need to modify these commands to the OS on which they will be running (Refer to the [documentation](https://developer.hashicorp.com/terraform/cli/commands/import#example-import-into-resource-configured-with-for_each) for additional details).
### MSSQL Server
* terraform import '`<path-to-module>`.azurerm_mssql_server.mssql_server["`<mssql-server-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Sql/servers/`<mssql-server-name>`'
### MSSQL Database
* terraform import '`<path-to-module>`.azurerm_mssql_database.mssql_database["`<mssql-server-name>`_`<mssql-database-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Sql/servers/`<mssql-server-name>`/databases/`<mssql-database-name>`'
### MSSQL Database Extended Auditing Policy
* terraform import '`<path-to-module>`.azurerm_mssql_database_extended_auditing_policy.mssql_database_extended_auditing_policy["`<mssql-server-name>`_`<mssql-database-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Sql/servers/`<mssql-server-name>`/databases/`<mssql-database-name>`/extendedAuditingSettings/default'
### MSSQL Elastic Pool
* terraform import '`<path-to-module>`.azurerm_mssql_elasticpool.mssql_elasticpool["`<mssql-server-name>`_`<mssql-elasticpool-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Sql/servers/`<mssql-server-name>`/elasticPools/`<mssql-elasticpool-name>`'
### MSSQL Firewall Rule
* terraform import '`<path-to-module>`.azurerm_mssql_firewall_rule.mssql_firewall_rule["`<mssql-server-name>`_`<mssql-firewall-rule-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Sql/servers/`<mssql-server-name>`/firewallRules/`<mssql-firewall-rule-name>`'
### Diagnostic Setting
#### MSSQL Database
* terraform import '`<path-to-module>`.azurerm_monitor_diagnostic_setting.diagnostic_setting["`<mssql-server-name>`_`<mssql-database-name>`_`<diag-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Sql/servers/`<mssql-server-name>`/databases/`<mssql-database-name>`|`<diag-name>`'
#### MSSQL Elastic Pool
* terraform import '`<path-to-module>`.azurerm_monitor_diagnostic_setting.mssql_elasticpool["`<mssql-server-name>`_`<mssql-elasticpool-name>`_`<diag-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Sql/servers/`<mssql-server-name>`/elasticPools/`<mssql-elasticpool-name>`|`<diag-name>`'
### Private Endpoint
* terraform import '`<path-to-module>`.module.private_endpoint.azurerm_private_endpoint.private_endpoint["`<private-endpoint-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Network/privateEndpoints/`<private-endpoint-name>`'

 > **_NOTE:_** `<path-to-module>` is terraform logical path from root. e.g. _module.mssql\_server_

&nbsp;

# Outputs
## Structure

| Output Name | Value          | Comment                                              |
| ----------- | -------------- | ---------------------------------------------------- |
| outputs     | name           |                                                      |
|             | id             |                                                      |
|             | principal_id   | principal_id (object_id) of system assigned identity |
|             | databases      | MSSQL Database outputs                               |
|             | &nbsp;name     |                                                      |
|             | &nbsp;id       |                                                      |
|             | elasticpools   | MSSQL Elastic Pool outputs                           |
|             | &nbsp;id       |                                                      |


## Example usage of outputs
In the example below, outputted _id_ of the deployed MSSQL Database module is used as a value for the _scope_ variable in Role Assignment resource.
```
module "sqlsrv" {
    source = "git@github.com:Seyfor-CSC/mit.mssql-database.git?ref=v1.0.0"
    config = [
        {
            name                         = "SEY-TERRAFORM-NE-SQLSRV01"
            location                     = "northeurope"
            resource_group_name          = "SEY-TERRAFORM-NE-RG01"
            administrator_login          = "useradmin"
            administrator_login_password = "Password1234"
            version                      = "12.0"
        }
    ]
}

data "azurerm_client_config" "azurerm_client_config" {
}

resource "azurerm_role_assignment" "role_assignment" {
    scope                = module.sqlsrv.outputs.sey-terraform-ne-sqlsrv01.id # This is how to use output values
    role_definition_name = "Contributor"
    principal_id         = data.azurerm_client_config.azurerm_client_config.object_id
}
```

&nbsp;

# Module Features
## Lifecycle
This module has a lifecycle block set up like this:
```
lifecycle {
  ignore_changes = [
    administrator_login,
    administrator_login_password
  ]
}
```


&nbsp;

# Known Issues
We currently log no issues in this module.