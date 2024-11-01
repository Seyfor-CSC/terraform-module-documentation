# Introduction
Machine Learning module can deploy these resources:
* azurerm_machine_learning_workspace (required)
* azurerm_monitor_diagnostic_setting (optional)
* azurerm_private_endpoint (optional)

Example variables structure is located in [variables.md](variables.md).

Example use case is located in [test-case/locals.tf](test-case/locals.tf).

You can also see [changelog](CHANGELOG.md).

Terraform documentation:

https://registry.terraform.io/providers/hashicorp/azurerm/4.1.0/docs/resources/machine_learning_workspace

&nbsp;

> **WARNING:** AzureRM provider had been updated to a new major version. Many breaking changes were implemented. See the [providers guide](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/4.0-upgrade-guide) for more information.

# Terraform Import
There are a few things you need to do to import resources into .tfstate. In the example below there are resources which can be imported within the module. You may need to modify these commands to the OS on which they will be running (Refer to the [documentation](https://developer.hashicorp.com/terraform/cli/commands/import#example-import-into-resource-configured-with-for_each) for additional details).
### Machine Learning
* terraform import '`<path-to-module>`.azurerm_machine_learning_workspace.machine_learning_workspace["`<machine-learning-workspace-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.MachineLearningServices/workspaces/`<machine-learning-workspace-name>`'
### Diagnostic Setting
* terraform import '`<path-to-module>`.azurerm_monitor_diagnostic_setting.diagnostic_setting["`<machine-learning-workspace>`_`<diag-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.MachineLearningServices/workspaces/`<machine-learning-workspace-name>`|`<diag-name>`'
### Private Endpoint
* terraform import '`<path-to-module>`.module.private_endpoint.azurerm_private_endpoint.private_endpoint["`<private-endpoint-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Network/privateEndpoints/`<private-endpoint-name>`'

 > **_NOTE:_** `<path-to-module>` is terraform logical path from root. e.g. _module.machine\_learning_

&nbsp;

# Outputs
## Structure

| Output Name | Value         | Comment |
| ----------- | ------------- | ------- |
| outputs     | name          |         |
|             | id            |         |
|             | discovery_url |         |
|             | workspace_id  |         |
|             | principal_id  |         |

## Example usage of outputs
In the example below, outputted _id_ of the deployed Machine Learning module is used as a value for the _scope_ variable in Role Assignment resource.
```
module "mlw" {
    source = "git@github.com:Seyfor-CSC/mit.machine-learning.git?ref=v1.0.0"
    config = [
        {
            name                    = "SEY-TERRAFORM-NE-MLW01"
            resource_group_name     = "SEY-TERRAFORM-NE-RG01"
            location                = "northeurope"
            application_insights_id = azurerm_application_insights.example.id
            key_vault_id            = azurerm_key_vault.example.id
            storage_account_id      = azurerm_storage_account.example.id
            identity = {
                type = "SystemAssigned"
            }
        }
    ]
}

data "azurerm_client_config" "azurerm_client_config" {
}

resource "azurerm_role_assignment" "role_assignment" {
    scope                = module.mlw.outputs.sey-terraform-ne-mlw01.id # This is how to use output values
    role_definition_name = "Contributor"
    principal_id         = data.azurerm_client_config.azurerm_client_config.object_id
}
```

&nbsp;

# Module Features
No special features in module.

&nbsp;

# Known Issues
We currently log no issues in this module.
