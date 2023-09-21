# Introduction
Monitor Action Group module can deploy these resources:
* azurerm_monitor_action_group.monitor_action_group

Example variables structure is located in [variables.md](variables.md).

Example use case is located in [test-case/locals.tf](test-case/locals.tf).

You can also see [changelog](changelog.md).

Terraform documentation:

https://registry.terraform.io/providers/hashicorp/azurerm/3.73.0/docs/resources/monitor_action_group

&nbsp;

# Terraform Import
There are a few things you need to do to import resources into .tfstate. In the example below there are resources which can be imported within the module. You may need to modify these commands to the OS on which they will be running (Refer to the [documentation](https://developer.hashicorp.com/terraform/cli/commands/import#example-import-into-resource-configured-with-for_each) for additional details).
### Monitor Action Group
* terraform import '`<path-to-module>`.azurerm_monitor_action_group.monitor_action_group["`<monitor-action-group-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Insights/actionGroups/`<monitor-action-group-name>`'

 > **_NOTE:_** `<path-to-module>` is terraform logical path from root. e.g. _module.monitor\_action\_group_

&nbsp;

# Outputs
## Structure

| Output Name | Value        | Comment                                              |
| ----------- | ------------ | ---------------------------------------------------- |
| outputs     | name         |                                                      |
|             | id           |                                                      |

&nbsp;

# Module Features
No special features in module.

&nbsp;

# Known Issues
We currently log no issues in this module.