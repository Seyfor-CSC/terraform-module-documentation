# Introduction
MSSQL Failover Group module can deploy these resources:
* azurerm_mssql_failover_group (required)

Example variables structure is located in [variables.md](variables.md).

Example use case is located in [test-case/locals.tf](test-case/locals.tf).

You can also see [changelog](CHANGELOG.md).

Terraform documentation:

https://registry.terraform.io/providers/hashicorp/azurerm/4.33.0/docs/resources/mssql_failover_group

&nbsp;

# Terraform Import
There are a few things you need to do to import resources into .tfstate. In the example below there are resources which can be imported within the module. You may need to modify these commands to the OS on which they will be running (Refer to the [documentation](https://developer.hashicorp.com/terraform/cli/commands/import#example-import-into-resource-configured-with-for_each) for additional details).
### MSSQL Failover Group
* terraform import '`<path-to-module>`.azurerm_mssql_failover_group.mssql_failover_group["`<mssql-failover-group-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Sql/servers/`<primary-mssql-server-name>`/failoverGroups/`<mssql-failover-group-name>`'

 > **_NOTE:_** `<path-to-module>` is terraform logical path from root. e.g. _module.mssql\_failover\_group_

&nbsp;

# Outputs
## Structure

| Output Name | Value | Comment |
| ----------- | ----- | ------- |
| outputs     | id    |         |


## Example usage of outputs
In the example below, outputted _id_ of the deployed MSSQL Failover Group module is used as a value for the _scope_ variable in Role Assignment resource.
```
module "mssql" {
    source = "git@github.com:seyfor-csc/mit.mssql-failover-group.git?ref=v1.0.0"
    config = [
        {
            name      = "sey-terraform-ne-fg01"
            server_id = azurerm_mssql_server.mssql_server_primary.id
            partner_server = {
                id = azurerm_mssql_server.mssql_server_secondary.id
            }
        }
    ]
}

data "azurerm_client_config" "azurerm_client_config" {
}

resource "azurerm_role_assignment" "role_assignment" {
    scope                = module.mssql.outputs.sey-terraform-ne-fg01.id # This is how to use output values
    role_definition_name = "Contributor"
    principal_id         = data.azurerm_client_config.azurerm_client_config.object_id
}
```

&nbsp;

# Module Features
## Monitoring tags in `ignore_changes` lifecycle block
We reserve the right to include tags dedicated to our product Advanced Monitoring in the `ignore_changes` lifecycle block. This is to prevent the module from deleting those tags. The tags we ignore are: `tags["Platform"]`, `tags["MonitoringTier"]`.

&nbsp;

# Known Issues
We currently log no issues in this module.
