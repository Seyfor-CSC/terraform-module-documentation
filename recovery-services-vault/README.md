# Introduction
Recovery Services Vault module can deploy these resources:
* azurerm_recovery_services_vault (required)
* azurerm_backup_policy_vm (optional)
* azurerm_backup_policy_file_share (optional)
* azurerm_monitor_diagnostic_setting (optional)
* azurerm_private_endpoint (optional)

Example variables structure is located in [variables.md](variables.md).

Example use case is located in [test-case/locals.tf](test-case/locals.tf).

You can also see [changelog](changelog.md).

Terraform documentation:

https://registry.terraform.io/providers/hashicorp/azurerm/3.84.0/docs/resources/recovery_services_vault

https://registry.terraform.io/providers/hashicorp/azurerm/3.84.0/docs/resources/backup_policy_vm

https://registry.terraform.io/providers/hashicorp/azurerm/3.84.0/docs/resources/backup_policy_file_share

https://registry.terraform.io/providers/hashicorp/azurerm/3.84.0/docs/resources/monitor_diagnostic_setting

https://registry.terraform.io/providers/hashicorp/azurerm/3.84.0/docs/resources/private_endpoint

&nbsp;

# Terraform Import
There are a few things you need to do to import resources into .tfstate. In the example below there are resources which can be imported within the module. You may need to modify these commands to the OS on which they will be running (Refer to the [documentation](https://developer.hashicorp.com/terraform/cli/commands/import#example-import-into-resource-configured-with-for_each) for additional details).
### Recovery Services Vault
* terraform import '`<path-to-module>`.azurerm_recovery_services_vault.recovery_services_vault["`<recovery-services-vault-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.RecoveryServices/vaults/`<recovery-services-vault-name>`'
### Backup Policy VM
* terraform import '`<path-to-module>`.azurerm_backup_policy_vm.backup_policy_vm["`<recovery-services-vault-name>`_`<backup-policy-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.RecoveryServices/vaults/`<recovery-services-vault-name>`/backupPolicies/`<backup-policy-name>`'
### Backup Policy File Share
* terraform import '`<path-to-module>`.azurerm_backup_policy_file_share.backup_policy_file_share["`<recovery-services-vault-name>`_`<backup-policy-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.RecoveryServices/vaults/`<recovery-services-vault-name>`/backupPolicies/`<backup-policy-name>`'
### Diagnostic Setting
* terraform import '`<path-to-module>`.azurerm_monitor_diagnostic_setting.diagnostic_setting["`<recovery-services-vault-name>`_`<diag-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.RecoveryServices/vaults/`<recovery-services-vault-name>`|`<diag-name>`'
### Private Endpoint
* terraform import '`<path-to-module>`.module.private_endpoint.azurerm_private_endpoint.private_endpoint["`<private-endpoint-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Network/privateEndpoints/`<private-endpoint-name>`'

 > **_NOTE:_** `<path-to-module>` is terraform logical path from root. e.g. _module.recovery\_services\_vault_

&nbsp;

# Outputs
## Structure

| Output Name | Value        | Comment                                              |
| ----------- | ------------ | ---------------------------------------------------- |
| outputs     | name         |                                                      |
|             | id           |                                                      |
|             | principal_id | principal_id (object_id) of system assigned identity |
|             | vm_policy    | Backup Policy VM outputs                             |
|             | &nbsp;id     |                                                      |
|             | share_policy | Backup Policy File Share outputs                     |
|             | &nbsp;id     |                                                      |


## Example usage of outputs
In the example below, outputted _id_ of the deployed Recovery Services Vault module is used as a value for the _scope_ variable in Role Assignment resource.
```
module "rsv" {
    source = "git@github.com:seyfor-csc/mit.recovery-services-vault.git?ref=v1.0.0"
    config = [
        {
            name                = "SEY-TERRAFORM-NE-RSV01"
            location            = "northeurope"
            resource_group_name = "SEY-TERRAFORM-NE-RG01"
            sku                 = "Standard"
        }
    ]
}

data "azurerm_client_config" "azurerm_client_config" {
}

resource "azurerm_role_assignment" "role_assignment" {
    scope                = module.rsv.outputs.sey-terraform-ne-rsv01.id # This is how to use output values
    role_definition_name = "Contributor"
    principal_id         = data.azurerm_client_config.azurerm_client_config.object_id

    depends_on = [
        module.rsv
    ]
}
```

&nbsp;

# Module Features
## Monitoring
When setting up diagnostic settings to Log Analytics Workspace, there are 3 special variables of type bool which should be taken into account. Set value to _true_ for those variables which enable your needed log categories.

This table shows which log categories are associated with which variable:

| Variable name | Log Category                               |
| ------------- | ------------------------------------------ |
| recovery      | AzureSiteRecoveryJobs                      |
|               | AzureSiteRecoveryEvents                    |
|               | AzureSiteRecoveryReplicatedItems           |
|               | AzureSiteRecoveryReplicationStats          |
|               | AzureSiteRecoveryRecoveryPoints            |
|               | AzureSiteRecoveryReplicationDataUploadRate |
|               | AzureSiteRecoveryProtectedDiskDataChurn    |
| backup        | CoreAzureBackup                            |
|               | AddonAzureBackupJobs                       |
|               | AddonAzureBackupPolicy                     |
|               | AddonAzureBackupStorage                    |
|               | AddonAzureBackupProtectedInstance          |
| backup_report | AzureBackupReport                          |

You can also create a custom combination of log categories by setting the `categories` object variable and switching values to `true` or `false` for the variables inside.

Navigate to [test-case/locals.tf](test-case/locals.tf) to see how we set this all up.

 > **NOTE:** Refer to [Microsoft documentation](https://learn.microsoft.com/en-us/azure/backup/backup-azure-diagnostic-events?tabs=recovery-services-vaults) for more details about log categories in Recovery Services Vaults.
## Diagnostic Setting enabled log can't be deleted
### GitHub issue
https://github.com/hashicorp/terraform-provider-azurerm/issues/23267
### Possible workarounds: 
1. Disable the log manually in Azure Portal and then reflect the change in your Terraform configuration.
2. Delete the whole diagnostic setting and deploy it again with your desired configuration.

&nbsp;

# Known Issues
## Monitoring variable conflict
Custom variable `monitoring_rsv` replacing official Terraform variable `monitoring` has been created to prevent conflict with our custom variable `monitoring` used for diagnostic settings.