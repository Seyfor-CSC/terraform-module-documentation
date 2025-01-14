# Introduction
Storage Account module can deploy these resources:
* azurerm_storage_account (required)
* azurerm_storage_container (optional)
* azurerm_storage_share (optional)
* azurerm_storage_queue (optional)
* azurerm_storage_table (optional)
* azurerm_storage_management_policy (optional)
* azurerm_backup_container_storage_account (optional)
* azurerm_backup_protected_file_share (optional)
* azurerm_monitor_diagnostic_setting (optional)
* azurerm_private_endpoint (optional)

Example variables structure is located in [variables.md](variables.md).

Example use case is located in [test-case/locals.tf](test-case/locals.tf).

You can also see [changelog](CHANGELOG.md).

Terraform documentation:

https://registry.terraform.io/providers/hashicorp/azurerm/4.14.0/docs/resources/storage_account

https://registry.terraform.io/providers/hashicorp/azurerm/4.14.0/docs/resources/storage_container

https://registry.terraform.io/providers/hashicorp/azurerm/4.14.0/docs/resources/storage_share

https://registry.terraform.io/providers/hashicorp/azurerm/4.14.0/docs/resources/storage_queue

https://registry.terraform.io/providers/hashicorp/azurerm/4.14.0/docs/resources/storage_table

https://registry.terraform.io/providers/hashicorp/azurerm/4.14.0/docs/resources/storage_management_policy

https://registry.terraform.io/providers/hashicorp/azurerm/4.14.0/docs/resources/backup_container_storage_account

https://registry.terraform.io/providers/hashicorp/azurerm/4.14.0/docs/resources/backup_protected_file_share

https://registry.terraform.io/providers/hashicorp/azurerm/4.14.0/docs/resources/monitor_diagnostic_setting

https://registry.terraform.io/providers/hashicorp/azurerm/4.14.0/docs/resources/private_endpoint

> **WARNING:** AzureRM provider had been updated to a new major version. Many breaking changes were implemented. See the [providers guide](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/4.0-upgrade-guide) for more information.

&nbsp;

# Terraform Import
There are a few things you need to do to import resources into .tfstate. In the example below there are resources which can be imported within the module. You may need to modify these commands to the OS on which they will be running (Refer to the [documentation](https://developer.hashicorp.com/terraform/cli/commands/import#example-import-into-resource-configured-with-for_each) for additional details).
### Storage Account
* terraform import '`<path-to-module>`.azurerm_storage_account.storage_account["`<storage-account-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Storage/storageAccounts/`<storage-account-name>`'
### Container
* terraform import '`<path-to-module>`.azurerm_storage_container.storage_container["`<storage-account-name>`_`<storage-container-name>`"]' 'https://`<storage-account-name>`.blob.core.windows.net/`<storage-container-name>`'
### File Share
* terraform import '`<path-to-module>`.azurerm_storage_share.storage_share["`<storage-account-name>`_`<storage-share-name>`"]' 'https://`<storage-account-name>`.file.core.windows.net/`<storage-share-name>`'
### Queue
* terraform import '`<path-to-module>`.azurerm_storage_queue.storage_queue["`<storage-account-name>`_`<storage-queue-name>`"]' 'https://`<storage-account-name>`.queue.core.windows.net/`<storage-queue-name>`'
### Table
* terraform import '`<path-to-module>`.azurerm_storage_table.storage_table["`<storage-account-name>`_`<storage-table-name>`"]' 'https://`<storage-account-name>`.table.core.windows.net/Tables(`'<storage-table-name>'`)'
### Management Policy
* terraform import '`<path-to-module>`.azurerm_storage_management_policy.storage_management_policy["`<storage-account-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Storage/storageAccounts/`<storage-account-name>`/managementPolicies/`<storage-management-policy-name>`'
### Backup Container Storage Account
* terraform import '`<path-to-module>`.azurerm_backup_container_storage_account.backup_container_storage_account["`<storage-account-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.RecoveryServices/vaults/`<recovery-vault-name>`/backupFabrics/Azure/protectionContainers/StorageContainer;storage;`<resource-group-name>`;`<storage-account-name>`'
### Backup Protected File Share
* terraform import '`<path-to-module>`.azurerm_backup_protected_file_share.backup_protected_file_share["`<storage-account-name>`_`<storage-share-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.RecoveryServices/vaults/`<recovery-vault-name>`/backupFabrics/Azure/protectionContainers/StorageContainer;storage;`<resource-group-name>`;`<storage-account-name>`;protectedItems/azurefileshare;`<GUID>`'
### Diagnostic Setting
#### Storage
* terraform import '`<path-to-module>`.azurerm_monitor_diagnostic_setting.storage["`<storage-account-name>`_`<diag-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Storage/storageAccounts/`<storage-account-name>`|`<diag-name>`'
#### Blob
* terraform import '`<path-to-module>`.azurerm_monitor_diagnostic_setting.storage_blob["`<storage-account-name>`_`<diag-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Storage/storageAccounts/`<storage-account-name>`/blobServices/default|`<diag-name>`'
#### File
* terraform import '`<path-to-module>`.azurerm_monitor_diagnostic_setting.storage_file["`<storage-account-name>`_`<diag-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Storage/storageAccounts/`<storage-account-name>`/fileServices/default|`<diag-name>`'
#### Queue
* terraform import '`<path-to-module>`.azurerm_monitor_diagnostic_setting.storage_queue["`<storage-account-name>`_`<diag-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Storage/storageAccounts/`<storage-account-name>`/queueServices/default|`<diag-name>`'
#### Table
* terraform import '`<path-to-module>`.azurerm_monitor_diagnostic_setting.storage_table["`<storage-account-name>`_`<diag-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Storage/storageAccounts/`<storage-account-name>`/tableServices/default|`<diag-name>`'
### Private Endpoint
* terraform import '`<path-to-module>`.module.private_endpoint.azurerm_private_endpoint.private_endpoint["`<private-endpoint-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Network/privateEndpoints/`<private-endpoint-name>`'

 > **_NOTE:_** `<path-to-module>` is terraform logical path from root. e.g. _module.storage\_account_

&nbsp;

# Outputs
## Structure

| Output Name | Value                 | Comment                                              |
| ----------- | --------------------- | ---------------------------------------------------- |
| outputs     | name                  |                                                      |
|             | id                    |                                                      |
|             | principal_id          | principal_id (object_id) of system assigned identity |
|             | primary_blob_endpoint |                                                      |
|             | container             | Container outputs                                    |
|             | &nbsp;name            |                                                      |
|             | &nbsp;id              |                                                      |
|             | file_share            | File Share outputs                                   |
|             | &nbsp;name            |                                                      |
|             | &nbsp;id              |                                                      |
|             | queue                 | Queue outputs                                        |
|             | &nbsp;name            |                                                      |
|             | &nbsp;id              |                                                      |
|             | table                 | Table outputs                                        |
|             | &nbsp;name            |                                                      |
|             | &nbsp;id              |                                                      |

## Example usage of outputs
In the example below, outputted _id_ of the deployed Storage Account module is used as a value for the _scope_ variable in Role Assignment resource.
```
module "sa" {
    source = "git@github.com:seyfor-csc/mit.storage-account.git?ref=v1.0.0"
    config = [
        {
            name                     = "seyterraformnesa01"
            location                 = "northeurope"
            resource_group_name      = "SEY-TERRAFORM-NE-RG01"
            account_tier             = "Standard"
            account_replication_type = "LRS"
        }
    ]
}

data "azurerm_client_config" "azurerm_client_config" {
}

resource "azurerm_role_assignment" "role_assignment" {
    scope                = module.sa.outputs.seyterraformnesa01.id # This is how to use output values
    role_definition_name = "Contributor"
    principal_id         = data.azurerm_client_config.azurerm_client_config.object_id
}
```

&nbsp;

# Module Features
No special features in module.

&nbsp;

# Known Issues
## Reported on GitHub
[blob_properties not setting default value of soft delete](https://github.com/hashicorp/terraform-provider-azurerm/issues/21856)
## Supported Variables
Not all available variables for Storage Management Policy are currently supported in this module. See [variables.md](variables.md) for an overview of supported variables.
## Diagnostic Setting metrics updating in place
If any of the metrics is disabled, the diagnostic setting will be updating in place with every run.
### GitHub issue
https://github.com/hashicorp/terraform-provider-azurerm/issues/10388
## Container and File Share migration to new API
AzureRM provider introduced changes to the API for storage account containers and file shares. Previous Data Plane API is replaced with the Resource Manager API. This deprecates the use of `storage_account_name` in the `azurerm_storage_container` and `azurerm_storage_share` resources. The new API requires the use of `storage_account_id` instead. This module has been updated to use the new API. The `storage_account_name` variable is still available for backward compatibility, however, its value isn't inherited from the resource anymore and needs to be provided explicitly.
If you want to migrate from `storage_account_name` to `storage_account_id`, you have to remove the resource from terraform state and reimport it with the new variable. New import has to use the `Resource Manager ID` instead of the previously used `ID`.
### GitHub Pull Request
https://github.com/hashicorp/terraform-provider-azurerm/pull/27733
## Deprecated variables migrating to resources
AzureRM provider is slowly deprecating some variables in favor of resources. Since not all variables have been deprecated yet, this module will update once the deprecation is complete. In the meantime, you will be seeing a warning message that you can ignore.