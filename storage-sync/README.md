# Introduction
Storage Sync module can deploy these resources:
* azurerm_storage_sync (required)
* azurerm_storage_sync_group (optional)
* azurerm_private_endpoint (optional)

Example variables structure is located in [variables.md](variables.md).

Example use case is located in [test-case/locals.tf](test-case/locals.tf).

You can also see [changelog](changelog.md).

Terraform documentation:

https://registry.terraform.io/providers/hashicorp/azurerm/3.67.0/docs/resources/storage_sync

https://registry.terraform.io/providers/hashicorp/azurerm/3.67.0/docs/resources/storage_sync_group

https://registry.terraform.io/providers/hashicorp/azurerm/3.67.0/docs/resources/private_endpoint

&nbsp;

# Terraform Import
There are a few things you need to do to import resources into .tfstate. In the example below there are resources which can be imported within the module. You may need to modify these commands to the OS on which they will be running (Refer to the [documentation](https://developer.hashicorp.com/terraform/cli/commands/import#example-import-into-resource-configured-with-for_each) for additional details).
### Storage Sync
* terraform import '`<path-to-module>`.azurerm_storage_sync.storage_sync["`<storage-sync-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.StorageSync/storageSyncServices/`<storage-sync-name>`'
### Storage Sync Group
* terraform import '`<path-to-module>`.azurerm_storage_sync_group.storage_sync_group["`<storage-sync-name>`_`<storage-sync-group-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.StorageSync/storageSyncServices/`<storage-sync-name>`/syncGroups/`<storage-sync-group-name>`'
 ### Private Endpoint
* terraform import '`<path-to-module>`.module.private_endpoint.azurerm_private_endpoint.private_endpoint["`<private-endpoint-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Network/privateEndpoints/`<private-endpoint-name>`'

 > **_NOTE:_** `<path-to-module>` is terraform logical path from root. e.g. _module.storage\_sync_

&nbsp;

# Outputs
## Structure

| Output Name | Value       | Comment                    |
| ----------- | ----------- | -------------------------- |
| outputs     | name        |                            |
|             | id          |                            |
|             | sync_groups | Storage Sync Group outputs |
|             | &nbsp;name  |                            |
|             | &nbsp;id    |                            |


## Example usage of outputs
In the example below, outputted _id_ of the deployed Storage Sync module is used as a value for the _scope_ variable in Role Assignment resource.
```
module "sync" {
    source = "git@github.com:seyfor-csc/mit.storage-sync.git?ref=v1.0.0"
    config = [
        {
            name                = "SEY-TERRAFORM-NE-SYNC01"
            location            = "northeurope"
            resource_group_name = "SEY-TERRAFORM-NE-RG01"
        }
    ]
}

data "azurerm_client_config" "azurerm_client_config" {
}

resource "azurerm_role_assignment" "role_assignment" {
    scope                = module.sync.outputs.sey-terraform-ne-sync01.id # This is how to use output values
    role_definition_name = "Contributor"
    principal_id         = data.azurerm_client_config.azurerm_client_config.object_id

    depends_on = [
        module.sync
    ]
}
```

&nbsp;

# Module Features
No special features in module.

&nbsp;

# Known Issues
## Storage Sync Cloud Endpoint
This resource is currently impossible to create using code of any kind. It can be created by using Azure Portal.