# Introduction
Storage Account module can deploy these resources:
* azurerm_storage_account (required)
* azurerm_storage_container (optional)
* azurerm_storage_share (optional)
* azurerm_storage_queue (optional)
* azurerm_storage_table (optional)
* azurerm_storage_management_policy (optional)
* azurerm_monitor_diagnostic_setting (optional)
* azurerm_private_endpoint (optional)

Example variables structure is located in [variables.md](variables.md).

Example use case is located in [test-case/locals.tf](test-case/locals.tf).

You can also see [changelog](changelog.md).

Terraform documentation:

https://registry.terraform.io/providers/hashicorp/azurerm/3.51.0/docs/resources/storage_account

https://registry.terraform.io/providers/hashicorp/azurerm/3.51.0/docs/resources/storage_container

https://registry.terraform.io/providers/hashicorp/azurerm/3.51.0/docs/resources/storage_share

https://registry.terraform.io/providers/hashicorp/azurerm/3.51.0/docs/resources/storage_queue

https://registry.terraform.io/providers/hashicorp/azurerm/3.51.0/docs/resources/storage_table

https://registry.terraform.io/providers/hashicorp/azurerm/3.51.0/docs/resources/storage_management_policy

https://registry.terraform.io/providers/hashicorp/azurerm/3.51.0/docs/resources/monitor_diagnostic_setting

https://registry.terraform.io/providers/hashicorp/azurerm/3.51.0/docs/resources/private_endpoint

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
* terraform import '`<path-to-module>`.azurerm_storage_management_policy.storage_management_policy["`<storage-management-policy-name`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Storage/storageAccounts/`<storage-account-name>`/managementPolicies/`<storage-management-policy-name>`'
### Diagnostic Setting
#### Storage
* terraform import '`<path-to-module>`.azurerm_monitor_diagnostic_setting.diagnostic_setting["`<storage-account-name>`_`<diag-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Storage/storageAccounts/`<storage-account-name>`|`<diag-name>`'
#### Blob
* terraform import '`<path-to-module>`.azurerm_monitor_diagnostic_setting.diagnostic_setting["`<storage-account-name>`_`<diag-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Storage/storageAccounts/`<storage-account-name>`/blobServices/default|`<diag-name>`'
#### File
* terraform import '`<path-to-module>`.azurerm_monitor_diagnostic_setting.diagnostic_setting["`<storage-account-name>`_`<diag-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Storage/storageAccounts/`<storage-account-name>`/fileServices/default|`<diag-name>`'
#### Queue
* terraform import '`<path-to-module>`.azurerm_monitor_diagnostic_setting.diagnostic_setting["`<storage-account-name>`_`<diag-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Storage/storageAccounts/`<storage-account-name>`/queueServices/default|`<diag-name>`'
#### Table
* terraform import '`<path-to-module>`.azurerm_monitor_diagnostic_setting.diagnostic_setting["`<storage-account-name>`_`<diag-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Storage/storageAccounts/`<storage-account-name>`/tableServices/default|`<diag-name>`'

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

    depends_on = [
        module.sa
    ]
}
```

&nbsp;

# Module Features
## Public Network Access
If you set `public_network_access_enabled` variable value to _false_, network access from all networks to this storage account will stay enabled unless private endpoint inside this module is also configured.
## Subscription Id
When using the module, subscription_id variable needs to be configured in the same place as source or the config variable. Set the value of this variable to the subscription you will deploy your resources into. Go to [test-case/main.tf](test-case/main.tf) to see how it should look like.

&nbsp;

# Known Issues
## Table acl block
Acl for tables is currently not possible to be configured using terraform as it ends in an error. Therefore, we removed this feature from the module for now.
## local-exec provisioner error
Module run will result in an error if you run it locally. Resources will still be deployed, however, `public_network_access_enabled` variable value will be always set to _true_. This error is caused by a local-exec provisioner which uses a command that is not applicable locally. When you deploy the module by pipeline, this error will not appear and `public_network_access_enabled` variable will be set to the value you configure.
## Reported on GitHub
[share_properties smb object produces changes for premium storage account.](https://github.com/hashicorp/terraform-provider-azurerm/issues/21182)

[blob_properties not setting default value of soft delete](https://github.com/hashicorp/terraform-provider-azurerm/issues/21856)
