# Introduction
Role Management Policy module can deploy these resources:
* azurerm_role_management_policy (required)

Example variables structure is located in [variables.md](variables.md).

Example use case is located in [test-case/locals.tf](test-case/locals.tf).

You can also see [changelog](CHANGELOG.md).

Terraform documentation:

https://registry.terraform.io/providers/hashicorp/azurerm/4.23.0/docs/resources/role_management_policy

&nbsp;

# Terraform Import
There are a few things you need to do to import resources into .tfstate. In the example below there are resources which can be imported within the module. You may need to modify these commands to the OS on which they will be running (Refer to the [documentation](https://developer.hashicorp.com/terraform/cli/commands/import#example-import-into-resource-configured-with-for_each) for additional details).
### Role Management Policy
* terraform import '`<path-to-module>`.azurerm_role_management_policy.role_management_policy["`<role-management-policy-custom-name>`"]' '/subscriptions/`<subscription-id>`/providers/Microsoft.Authorization/roleDefinitions/`<role-definition-Id>|<scope>`'

 > **_NOTE:_** `<path-to-module>` is terraform logical path from root. e.g. _module.role\_management\_policy_

&nbsp;

# Outputs
## Structure

| Output Name | Value | Comment |
| ----------- | ----- | ------- |
| outputs     | name  |         |
|             | id    |         |

&nbsp;

# Module Features
## custom_name variable
We created a custom required variable named `custom_name` which is used as a unique value for looping through all instances of the resource. This variable is also used to access the module outputs. Go to [test-case/locals.tf](test-case/locals.tf) to see how to use it correctly.

&nbsp;

# Known Issues
We currently log no issues in this module.
