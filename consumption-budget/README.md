# Introduction
Consumption Budget module can deploy these resources:
* azurerm_consumption_budget_management_group (optional)
* azurerm_consumption_budget_resource_group (optional)
* azurerm_consumption_budget_subscription (optional)
> **_NOTE:_** At least one of these needs to be specified in module configuration

Example variables structure is located in [variables.md](variables.md).

Example use case is located in [test-case/locals.tf](test-case/locals.tf).

You can also see [changelog](CHANGELOG.md).

Terraform documentation:

https://registry.terraform.io/providers/hashicorp/azurerm/4.14.0/docs/resources/consumption_budget_management_group

https://registry.terraform.io/providers/hashicorp/azurerm/4.14.0/docs/resources/consumption_budget_resource_group

https://registry.terraform.io/providers/hashicorp/azurerm/4.14.0/docs/resources/consumption_budget_subscription

> **WARNING:** AzureRM provider had been updated to a new major version. Many breaking changes were implemented. See the [providers guide](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/4.0-upgrade-guide) for more information.

&nbsp;

# Terraform Import
There are a few things you need to do to import resources into .tfstate. In the example below there are resources which can be imported within the module. You may need to modify these commands to the OS on which they will be running (Refer to the [documentation](https://developer.hashicorp.com/terraform/cli/commands/import#example-import-into-resource-configured-with-for_each) for additional details).
### Consumption Budget Management Group
* terraform import '`<path-to-module>`.azurerm_consumption_budget_management_group.consumption_budget_management_group["`<consumption-budget-management-group-name>`"]' '/providers/Microsoft.Management/managementGroups/`<management-group-name>`/providers/Microsoft.Consumption/budgets/`<consumption-budget-management-group-name>`'
### Consumption Budget Resource Group
* terraform import '`<path-to-module>`.azurerm_consumption_budget_resource_group.consumption_budget_resource_group["`<consumption-budget-resource-group-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<consumption-budget-resource-group-name>`/providers/Microsoft.Consumption/budgets/`<consumption-budget-resource-group-name>`'
### Consumption Budget Subscription
* terraform import '`<path-to-module>`.azurerm_consumption_budget_subscription.consumption_budget_subscription["`<consumption-budget-subscription-name>`"]' '/subscriptions/`<subscription-id>`/providers/Microsoft.Consumption/budgets/`<consumption-budget-subscription-name>`'

 > **_NOTE:_** `<path-to-module>` is terraform logical path from root. e.g. _module.consumption\_budget_

&nbsp;

# Outputs
## Structure

| Output Name | Value | Comment |
| ----------- | ----- | ------- |
| outputs     | name  |         |
|             | id    |         |

&nbsp;

# Module Features
## management_group_id, resource_group_id, or subscription_id
This module can be deployed at either the management group, resource group or subscription scope. The module will automatically determine which scope it is being deployed at based on the variables you configure. Resource Group scope needs one extra custom variable, `resource_group_name`, to be specified for the deployment to work. See [test-case/locals.tf](test-case/locals.tf) for an example of how to deploy at different levels.

&nbsp;

# Known Issues
We currently log no issues in this module.
