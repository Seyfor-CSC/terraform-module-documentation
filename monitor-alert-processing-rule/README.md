# Introduction
Monitor Alert Processing Rule module can deploy these resources:
* azurerm_monitor_alert_processing_rule_action_group (optional)
* azurerm_monitor_alert_processing_rule_suppression (optional)

Example variables structure is located in [variables.md](variables.md).

Example use case is located in [test-case/locals.tf](test-case/locals.tf).

You can also see [changelog](CHANGELOG.md).

Terraform documentation:

https://registry.terraform.io/providers/hashicorp/azurerm/4.45.0/docs/resources/monitor_alert_processing_rule_action_group

https://registry.terraform.io/providers/hashicorp/azurerm/4.45.0/docs/resources/monitor_alert_processing_rule_suppression

&nbsp;

> **WARNING:** AzureRM provider had been updated to a new major version. Many breaking changes were implemented. See the [providers guide](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/4.0-upgrade-guide) for more information.

# Terraform Import
There are a few things you need to do to import resources into .tfstate. In the example below there are resources which can be imported within the module. You may need to modify these commands to the OS on which they will be running (Refer to the [documentation](https://developer.hashicorp.com/terraform/cli/commands/import#example-import-into-resource-configured-with-for_each) for additional details).
### Monitor Alert Processing Rule Action Group
* terraform import '`<path-to-module>`.azurerm_monitor_alert_processing_rule_action_group.monitor_alert_processing_rule_action_group["`<monitor-alert-processing-rule-action-group-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.AlertsManagement/actionRules/`<monitor-alert-processing-rule-action-group-name>`'
### Monitor Alert Processing Rule Suppression
* terraform import '`<path-to-module>`.azurerm_monitor_alert_processing_rule_suppression.monitor_alert_processing_rule_suppression["`<monitor-alert-processing-rule-suppression-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.AlertsManagement/actionRules/`<monitor-alert-processing-rule-suppression-name>`'

 > **_NOTE:_** `<path-to-module>` is terraform logical path from root. e.g. _module.monitor\_alert\_processing\_rule_

&nbsp;

# Outputs
There are no outputs.

&nbsp;

# Module Features
## How to deploy Monitor Alert Processing Rule Action Group and Suppression
These two resources have identical variables, except for `add_action_group_ids`. If you configure this variable, `azurerm_monitor_alert_processing_rule_action_group` resource will be deployed. If you leave it empty, `azurerm_monitor_alert_processing_rule_suppression` resource will be deployed.
## Monitoring tags in `ignore_changes` lifecycle block
We reserve the right to include tags dedicated to our product Advanced Monitoring in the `ignore_changes` lifecycle block. This is to prevent the module from deleting those tags. The tags we ignore are: `tags["Platform"]`, `tags["MonitoringTier"]`.

&nbsp;

# Known Issues
We currently log no issues in this module.