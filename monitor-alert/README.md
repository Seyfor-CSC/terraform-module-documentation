# Introduction
Monitor Alert module can deploy these resources:
* azurerm_monitor_scheduled_query_rules_alert_v2 (optional)
* azurerm_monitor_activity_log_alert (optional)
* azurerm_monitor_metric_alert (optional)

Example variables structure is located in [variables.md](variables.md).

Example use case is located in [test-case/locals.tf](test-case/locals.tf).

You can also see [changelog](CHANGELOG.md).

Terraform documentation:

https://registry.terraform.io/providers/hashicorp/azurerm/4.33.0/docs/resources/monitor_scheduled_query_rules_alert_v2

https://registry.terraform.io/providers/hashicorp/azurerm/4.33.0/docs/resources/monitor_activity_log_alert

https://registry.terraform.io/providers/hashicorp/azurerm/4.33.0/docs/resources/monitor_metric_alert

&nbsp;

> **WARNING:** AzureRM provider had been updated to a new major version. Many breaking changes were implemented. See the [providers guide](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/4.0-upgrade-guide) for more information.

# Terraform Import
There are a few things you need to do to import resources into .tfstate. In the example below there are resources which can be imported within the module. You may need to modify these commands to the OS on which they will be running (Refer to the [documentation](https://developer.hashicorp.com/terraform/cli/commands/import#example-import-into-resource-configured-with-for_each) for additional details).
### Monitor Scheduled Query Rules Alert V2
* terraform import '`<path-to-module>`.azurerm_monitor_scheduled_query_rules_alert_v2.monitor_scheduled_query_rules_alert_v2["`<scheduled-query-rules-alert-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Insights/scheduledQueryRules/`<scheduled-query-rules-alert-name>`'
### Monitor Activity Log Alert
* terraform import '`<path-to-module>`.azurerm_monitor_activity_log_alert.monitor_activity_log_alert["`<activity-log-alert-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Insights/activityLogAlerts/`<activity-log-alert-name>`'
### Monitor Metric Alert
* terraform import '`<path-to-module>`.azurerm_monitor_metric_alert.monitor_metric_alert["`<metric-alert-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Insights/metricAlerts/`<metric-alert-name>`'

 > **_NOTE:_** `<path-to-module>` is terraform logical path from root. e.g. _module.monitor\_alert_

&nbsp;

# Outputs
There are no outputs.

&nbsp;


# Module Features
## Monitoring tags in `ignore_changes` lifecycle block
We reserve the right to include tags dedicated to our product Advanced Monitoring in the `ignore_changes` lifecycle block. This is to prevent the module from deleting those tags. The tags we ignore are: `tags["Platform"]`, `tags["MonitoringTier"]`.

&nbsp;

# Known Issues
We currently log no issues in this module.