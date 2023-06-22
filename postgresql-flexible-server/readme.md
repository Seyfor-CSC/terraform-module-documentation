# Introduction
PostgreSQL Flexible Server module can deploy these resources:
* azurerm_postgresql_flexible_server (required)
* azurerm_postgresql_flexible_server_database (optional)
* azurerm_postgresql_flexible_server_configuration (optional)
* azurerm_postgresql_flexible_server_active_directory_administrator (optional)
* azurerm_monitor_diagnostic_setting (optional)

Example variables structure is located in [variables.md](variables.md).

Example use case is located in [test-case/locals.tf](test-case/locals.tf).

You can also see [changelog](changelog.md).

Terraform documentation:

https://registry.terraform.io/providers/hashicorp/azurerm/3.51.0/docs/resources/postgresql_flexible_server

https://registry.terraform.io/providers/hashicorp/azurerm/3.51.0/docs/resources/postgresql_flexible_server_database

https://registry.terraform.io/providers/hashicorp/azurerm/3.51.0/docs/resources/postgresql_flexible_server_configuration

https://registry.terraform.io/providers/hashicorp/azurerm/3.51.0/docs/resources/postgresql_flexible_server_active_directory_administrator

https://registry.terraform.io/providers/hashicorp/azurerm/3.51.0/docs/resources/monitor_diagnostic_setting

&nbsp;

# Terraform Import
There are a few things you need to do to import resources into .tfstate. In the example below there are resources which can be imported within the module. You may need to modify these commands to the OS on which they will be running (Refer to the [documentation](https://developer.hashicorp.com/terraform/cli/commands/import#example-import-into-resource-configured-with-for_each) for additional details).
### PostgreSQL Flexible Server
* terraform import '`<path-to-module>`.azurerm_postgresql_flexible_server.postgresql_flexible_server["`<postgreslq-flexible-server-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.DBforPostgreSQL/flexibleservers/`<postgreslq-flexible-server-name>`'
### PostgreSQL Flexible Server Database
* terraform import '`<path-to-module>`.azurerm_postgresql_flexible_server_database.postgresql_flexible_server_database["`<postgreslq-flexible-server-name>`_`<postgresql-flexible-server-database-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.DBforPostgreSQL/flexibleservers/`<postgresql-flexible-server-name>`/databases/`<postgresql-flexible-server-database-name>`'
### PostgreSQL Flexible Server Configuration
* terraform import '`<path-to-module>`.azurerm_postgresql_flexible_server_configuration.postgresql_flexible_server_configuration["`<postgreslq-flexible-server-name>`_`<postgresql-flexible-server-configuration-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.DBforPostgreSQL/flexibleservers/`<postgresql-flexible-server-name>`/configurations/`<postgresql-flexible-server-configuration-name>`'
### PostgreSQL Flexible AAD Administrator
* terraform import '`<path-to-module>`.azurerm_postgresql_flexible_server_active_directory_administrator.postgresql_flexible_server_active_directory_administrator["`<postgreslq-flexible-server-name>`_`<postgresql-flexible-server-active-directory-administrator-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.DBforPostgreSQL/flexibleservers/`<postgresql-flexible-server-name>`/administrators/`<postgresql-flexible-server-active-directory-administrator-name>`'
### Diagnostic Setting
* terraform import '`<path-to-module>`.azurerm_monitor_diagnostic_setting.diagnostic_setting["`<postgresql-server-name>`_`<diag-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.DBforPostgreSQL/flexibleservers/`<postgresql-flexible-server-name>`/databases/`<postgresql-flexible-database-name>`|`<diag-name>`'

 > **_NOTE:_** `<path-to-module>` is terraform logical path from root. e.g. _module.postgresql\_flexible\_server_

&nbsp;

# Outputs
## Structure

| Output Name | Value        | Comment                                              |
| ----------- | ------------ | ---------------------------------------------------- |
| outputs     | name         |                                                      |
|             | id           |                                                      |
|             | principal_id | principal_id (object_id) of system assigned identity |
|             | fqdn         |                                                      |
|             | databases    | PostgreSQL Flexible Database outputs                 |
|             | &nbsp;name   |                                                      |
|             | &nbsp;id     |                                                      |

## Example usage of outputs
In the example below, outputted _id_ of the deployed PostgreSQL Flexible Server module is used as a value for the _scope_ variable in Role Assignment resource.
```
module "pgsql" {
    source = "git@github.com:Seyfor-CSC/mit.postgresql-flexible-server.git?ref=v1.0.0"
    config = [
        {
            name                = "seyterraformnepgsql01"
            location            = "northeurope"
            resource_group_name = "SEY-TERRAFORM-NE-RG01"
        }
    ]
}

data "azurerm_client_config" "azurerm_client_config" {
}

resource "azurerm_role_assignment" "role_assignment" {
    scope                = module.pgsql.outputs.seyterraformnepgsql01.id # This is how to use output values
    role_definition_name = "Contributor"
    principal_id         = data.azurerm_client_config.azurerm_client_config.object_id

    depends_on = [
        module.pgsql
    ]
}
```

&nbsp;

# Module Features
No special features in module.

&nbsp;

# Known Issues
We currently log no issues in this module.