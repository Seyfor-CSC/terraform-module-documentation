# Introduction
Log Analytics Workspace module can deploy these resources:
* azurerm_log_analytics_workspace (required)
* azurerm_monitor_diagnostic_setting (optional)

Example variables structure is located in [variables.md](variables.md).

Example use case is located in [test-case/locals.tf](test-case/locals.tf).

You can also see [changelog](CHANGELOG.md).

Terraform documentation:

https://registry.terraform.io/providers/hashicorp/azurerm/4.33.0/docs/resources/log_analytics_workspace

https://registry.terraform.io/providers/hashicorp/azurerm/4.33.0/docs/resources/monitor_diagnostic_setting

&nbsp;

> **WARNING:** AzureRM provider had been updated to a new major version. Many breaking changes were implemented. See the [providers guide](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/4.0-upgrade-guide) for more information.

# Terraform Import
There are a few things you need to do to import resources into .tfstate. In the example below there are resources which can be imported within the module. You may need to modify these commands to the OS on which they will be running (Refer to the [documentation](https://developer.hashicorp.com/terraform/cli/commands/import#example-import-into-resource-configured-with-for_each) for additional details).
### Log Analytics Workspace
* terraform import '`<path-to-module>`.azurerm_log_analytics_workspace.log_analytics_workspace["`<log-analytics-workspace-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.OperationalInsights/workspaces/`<log-analytics-workspace-name>`'
### Diagnostic Setting
* terraform import '`<path-to-module>`.azurerm_monitor_diagnostic_setting.diagnostic_setting["`<log-analytics-workspace-name>`_`<diag-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.OperationalInsights/workspaces/`<log-analytics-workspace-name>`|`<diag-name>`'

 > **_NOTE:_** `<path-to-module>` is terraform logical path from root. e.g. _module.log\_analytics\_workspace_

&nbsp;

# Outputs
## Structure

| Output Name | Value | Comment |
| ----------- | ----- | ------- |
| outputs     | name  |         |
|             | id    |         |

## Example usage of outputs
In the example below, outputted _id_ of the deployed Log Analytics Workspace module is used as a value for the _scope_ variable in Role Assignment resource.
```
module "la" {
    source = "git@github.com:Seyfor-CSC/mit.log-analytics-workspace.git?ref=v1.0.0"
    config = [
        {
            name                = "SEY-TERRAFORM-NE-LA01"
            location            = "northeurope"
            resource_group_name = "SEY-TERRAFORM-NE-RG01"
        }
    ]
}

data "azurerm_client_config" "azurerm_client_config" {
}

resource "azurerm_role_assignment" "role_assignment" {
    scope                = module.la.outputs.sey-terraform-ne-la01.id # This is how to use output values
    role_definition_name = "Contributor"
    principal_id         = data.azurerm_client_config.azurerm_client_config.object_id
}
```

&nbsp;

# Module Features
## Custom variables
In the `monitoring` variable object is a variable called `self_logging`, which is used to determine which Log Analytics Workspace should be used for diagnostic settings logging. If set to `true`, the diagnostic settings will be sent to itself. If set to `false`, the diagnostic settings will be sent to the Log Analytics Workspace provided in the `log_analytics_workspace_id` variable. Default value is `false`.
## Monitoring tags in `ignore_changes` lifecycle block
We reserve the right to include tags dedicated to our product Advanced Monitoring in the `ignore_changes` lifecycle block. This is to prevent the module from deleting those tags. The tags we ignore are: `tags["Platform"]`, `tags["MonitoringTier"]`.

&nbsp;

# Known Issues
We currently log no issues in this module.