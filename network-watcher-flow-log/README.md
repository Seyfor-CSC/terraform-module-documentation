# Introduction
Network Security Group module can deploy these resources:
* azurerm_network_watcher_flow_log (required)

Example variables structure is located in [variables.md](variables.md).

Example use case is located in [test-case/locals.tf](test-case/locals.tf).

You can also see [changelog](CHANGELOG.md).

Terraform documentation:

https://registry.terraform.io/providers/hashicorp/azurerm/4.14.0/docs/resources/network_watcher_flow_log

&nbsp;

> **WARNING:** AzureRM provider had been updated to a new major version. Many breaking changes were implemented. See the [providers guide](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/4.0-upgrade-guide) for more information.

# Terraform Import
There are a few things you need to do to import resources into .tfstate. In the example below there are resources which can be imported within the module. You may need to modify these commands to the OS on which they will be running (Refer to the [documentation](https://developer.hashicorp.com/terraform/cli/commands/import#example-import-into-resource-configured-with-for_each) for additional details).
### Flow Logs
* terraform import '`<path-to-module>`.azurerm_network_watcher_flow_log.network_watcher_flow_log["`<flow-log-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Network/networkWatchers/`<network-watcher-name>`/flowLogs/`<flow-log-name>`'

 > **_NOTE:_** `<path-to-module>` is terraform logical path from root. e.g. _module.network\_watcher\_flow\_log_

&nbsp;

# Outputs
There are no outputs.

&nbsp;

# Module Features
No special features in module.

&nbsp;

# Known Issues
We currently log no issues in this module.