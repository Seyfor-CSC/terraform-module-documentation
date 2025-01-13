# Introduction
Redis Cache module can deploy these resources:
* azurerm_redis_cache (required)
* azurerm_monitor_diagnostic_setting (optional)
* azurerm_private_endpoint (optional)

Example variables structure is located in [variables.md](variables.md).

Example use case is located in [test-case/locals.tf](test-case/locals.tf).

You can also see [changelog](CHANGELOG.md).

Terraform documentation:

https://registry.terraform.io/providers/hashicorp/azurerm/4.14.0/docs/resources/redis_cache

https://registry.terraform.io/providers/hashicorp/azurerm/4.14.0/docs/resources/monitor_diagnostic_setting

https://registry.terraform.io/providers/hashicorp/azurerm/4.14.0/docs/resources/private_endpoint

&nbsp;

> **WARNING:** AzureRM provider had been updated to a new major version. Many breaking changes were implemented. See the [providers guide](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/4.0-upgrade-guide) for more information.

# Terraform Import
There are a few things you need to do to import resources into .tfstate. In the example below there are resources which can be imported within the module. You may need to modify these commands to the OS on which they will be running (Refer to the [documentation](https://developer.hashicorp.com/terraform/cli/commands/import#example-import-into-resource-configured-with-for_each) for additional details).
### Redis Cache
* terraform import '`<path-to-module>`.azurerm_redis_cache.redis_cache["`<redis-cache-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Cache/redis/`<redis-cache-name>`'
### Diagnostic Setting
* terraform import '`<path-to-module>`.azurerm_monitor_diagnostic_setting.diagnostic_setting["`<redis-cache-name>`_`<diag-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Cache/redis/`<redis-cache-name>`|`<diag-name>`'
 ### Private Endpoint
* terraform import '`<path-to-module>`.module.private_endpoint.azurerm_private_endpoint.private_endpoint["`<private-endpoint-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Network/privateEndpoints/`<private-endpoint-name>`'

 > **_NOTE:_** `<path-to-module>` is terraform logical path from root. e.g. _module.redis\_cache_

&nbsp;

# Outputs
## Structure

| Output Name | Value                       | Comment                                              |
| ----------- | --------------------------- | ---------------------------------------------------- |
| outputs     | name                        |                                                      |
|             | id                          |                                                      |
|             | principal_id                | principal_id (object_id) of system assigned identity |
|             | ssl_port                    |                                                      |
|             | port                        |                                                      |
|             | primary_access_key          |                                                      |
|             | secondary_access_key        |                                                      |
|             | primary_connection_string   |                                                      |
|             | secondary_connection_string |                                                      |

## Example usage of outputs
In the example below, outputted _id_ of the deployed Redis Cache module is used as a value for the _scope_ variable in Role Assignment resource.
```
module "rc" {
    source = "git@github.com:seyfor-csc/mit.redis-cache.git?ref=v1.0.0"
    config = [
        {
            name                = "seyterraformnerc01"
            location            = "northeurope"
            resource_group_name = "SEY-TERRAFORM-NE-RG01"
            capacity            = 2
            family              = C
            sku_name            = Basic
        }
    ]
}

data "azurerm_client_config" "azurerm_client_config" {
}

resource "azurerm_role_assignment" "role_assignment" {
    scope                = module.rc.outputs.seyterraformnerc01.id # This is how to use output values
    role_definition_name = "Contributor"
    principal_id         = data.azurerm_client_config.azurerm_client_config.object_id
}
```

&nbsp;

# Module Features
No special features in module.

&nbsp;

# Known Issues
## Storage connection string returning different value
Because of this, terraform plan will generate changes to the `rdb_storage_connection_string` variable every run. This is a known issue with the Azure API. See the following link for more details:
https://github.com/Azure/azure-rest-api-specs/issues/3037
## Can't add rdb_storage_connection_string variable into ignore_changes
[Terraform documentation for redis cache](https://registry.terraform.io/providers/hashicorp/azurerm/4.14.0/docs/resources/redis_cache#rdb_storage_connection_string) suggests to put the `rdb_storage_connection_string` into an ignore_changes block. However, that also ends in an error. Because of this, no ignore_changes block is implemented. See the following link for more details:
https://github.com/Azure/azure-rest-api-specs/issues/3037#issuecomment-1398971779