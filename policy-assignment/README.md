# Introduction
Policy Assignment module can deploy these resources:
* azurerm_management_group_policy_assignment (optional)
* azurerm_subscription_policy_assignment (optional)
> **_NOTE:_** At least one of these needs to be specified in module configuration

Example variables structure is located in [variables.md](variables.md).

Example use case is located in [test-case/locals.tf](test-case/locals.tf).

You can also see [changelog](changelog.md).

Terraform documentation:

https://registry.terraform.io/providers/hashicorp/azurerm/3.96.0/docs/resources/management_group_policy_assignment

https://registry.terraform.io/providers/hashicorp/azurerm/3.96.0/docs/resources/subscription_policy_assignment

&nbsp;

# Terraform Import
There are a few things you need to do to import resources into .tfstate. In the example below there are resources which can be imported within the module. You may need to modify these commands to the OS on which they will be running (Refer to the [documentation](https://developer.hashicorp.com/terraform/cli/commands/import#example-import-into-resource-configured-with-for_each) for additional details).
### Management Group Policy Assignment
* terraform import '`<path-to-module>`.azurerm_management_group_policy_assignment.management_group_policy_assignment["`<management-group-policy-assignment-name>`"]' '/providers/Microsoft.Management/managementGroups/`<management-group-name>`/providers/Microsoft.Authorization/policyAssignments/`<management-group-policy-assignment-name>`'
### Subscription Policy Assignment
* terraform import '`<path-to-module>`.azurerm_subscription_policy_assignment.subscription_policy_assignment["`<subscription-policy-assignment-name>`"]' '/subscriptions/`<subscription-id>`/providers/Microsoft.Authorization/policyAssignments/`<subscription-policy-assignment-name>`'

 > **_NOTE:_** `<path-to-module>` is terraform logical path from root. e.g. _module.policy\_assignment_

&nbsp;

# Outputs
## Structure

| Output Name | Value        | Comment                                              |
| ----------- | ------------ | ---------------------------------------------------- |
| outputs     | name         |                                                      |
|             | id           |                                                      |
|             | principal_id | principal_id (object_id) of system assigned identity |


&nbsp;

# Module Features
## subscription_id and management_group_id
This module can be deployed at either the subscription or management group level. The module will automatically determine which level it is being deployed at and use the appropriate id. See [test-case/locals.tf](test-case/locals.tf) for an example of how to deploy at different levels.
## parameters variable
Parameters are passed into policy assignment through a json file. See [test-case/locals.tf](test-case/locals.tf) and [test-case/parameters](test-case/parameters) for an example of how to use this variable.

&nbsp;

# Known Issues
We currently log no issues in this module.