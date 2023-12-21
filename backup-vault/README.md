# Introduction
Backup Vault module can deploy these resources:
* azurerm_data_protection_backup_vault (required)
* azurerm_data_protection_backup_policy_disk (optional)
* azurerm_monitor_diagnostic_setting (optional)

Example variables structure is located in [variables.md](variables.md).

Example use case is located in [test-case/locals.tf](test-case/locals.tf).

You can also see [changelog](changelog.md).

Terraform documentation:

https://registry.terraform.io/providers/hashicorp/azurerm/3.84.0/docs/resources/data_protection_backup_vault

https://registry.terraform.io/providers/hashicorp/azurerm/3.84.0/docs/resources/data_protection_backup_policy_disk

https://registry.terraform.io/providers/hashicorp/azurerm/3.84.0/docs/resources/monitor_diagnostic_setting

&nbsp;

# Terraform Import
There are a few things you need to do to import resources into .tfstate. In the example below there are resources which can be imported within the module. You may need to modify these commands to the OS on which they will be running (Refer to the [documentation](https://developer.hashicorp.com/terraform/cli/commands/import#example-import-into-resource-configured-with-for_each) for additional details).
### Backup Vault
* terraform import '`<path-to-module>`.azurerm_data_protection_backup_vault.data_protection_backup_vault["`<backup-vault-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.DataProtection/backupVaults/`<backup-vault-name>`'
### Backup Policy Disk
* terraform import '`<path-to-module>`.azurerm_data_protection_backup_policy_disk.data_protection_backup_policy_disk["`<backup-vault-name_backup-policy-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.DataProtection/backupVaults/`<backup-vault-name>`/backupPolicies/`<backup-policy-name>`'
### Diagnostic Setting
* terraform import '`<path-to-module>`.azurerm_monitor_diagnostic_setting.diagnostic_setting["`<backup-vault-name>`_`<diag-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.DataProtection/backupVaults/`<backup-vault-name>`|`<diag-name>`'

 > **_NOTE:_** `<path-to-module>` is terraform logical path from root. e.g. _module.backup\_vault_

&nbsp;

# Outputs
## Structure

| Output Name | Value        | Comment                                              |
| ----------- | ------------ | ---------------------------------------------------- |
| outputs     | name         |                                                      |
|             | id           |                                                      |
|             | principal_id | principal_id (object_id) of system assigned identity |
|             | disk_policy  | Backup Policy Disk outputs                           |
|             | &nbsp;id     |                                                      |


## Example usage of outputs
In the example below, outputted _id_ of the deployed Backup Vault module is used as a value for the _scope_ variable in Role Assignment resource.
```
module "bv" {
    source = "git@github.com:seyfor-csc/mit.backup-vault.git?ref=v1.0.0"
    config = [
        {
            name                = "SEY-TERRAFORM-NE-BV01"
            location            = "northeurope"
            resource_group_name = "SEY-TERRAFORM-NE-RG01"
            datastore_type      = "VaultStore"
            redundancy          = "LocallyRedundant"
        }
    ]
}

data "azurerm_client_config" "azurerm_client_config" {
}

resource "azurerm_role_assignment" "role_assignment" {
    scope                = module.bv.outputs.sey-terraform-ne-bv01.id # This is how to use output values
    role_definition_name = "Contributor"
    principal_id         = data.azurerm_client_config.azurerm_client_config.object_id

    depends_on = [
        module.bv
    ]
}
```

&nbsp;

# Module Features
No special features in module.

&nbsp;

# Known Issues
We currently log no issues in this module.
