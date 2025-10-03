# Introduction
PIM module can deploy these resources:
* azurerm_pim_active_role_assignment (optional)
* azurerm_pim_eligible_role_assignment (optional)

Example variables structure is located in [variables.md](variables.md).

Example use case is located in [test-case/locals.tf](test-case/locals.tf).

You can also see [changelog](CHANGELOG.md).

Terraform documentation:

https://registry.terraform.io/providers/hashicorp/azurerm/4.45.0/docs/resources/pim_active_role_assignment

https://registry.terraform.io/providers/hashicorp/azurerm/4.45.0/docs/resources/pim_eligible_role_assignment

&nbsp;

# Terraform Import
There are a few things you need to do to import resources into .tfstate. In the example below there are resources which can be imported within the module. You may need to modify these commands to the OS on which they will be running (Refer to the [documentation](https://developer.hashicorp.com/terraform/cli/commands/import#example-import-into-resource-configured-with-for_each) for additional details).
### PIM Active Role Assignment
* terraform import '`<path-to-module>`.azurerm_pim_active_role_assignment.pim_active_role_assignment["`<custom-name>`"]' '/subscriptions/`<subscription-id>`|/subscriptions/`<subscription-id>`/providers/Microsoft.Authorization/roleDefinitions/`<role-definition-id>`|`<principal-id>`'
### PIM Eligible Role Assignment
* terraform import '`<path-to-module>`.azurerm_pim_eligible_role_assignment.pim_eligible_role_assignment["`<custom-name`"]' '/subscriptions/`<subscription-id>`|/subscriptions/`<subscription-id>`/providers/Microsoft.Authorization/roleDefinitions/`<role-definition-id>`|`<principal-id>`'

 > **_NOTE_** Resource index is either `custom_name`, or a combination of `<scope>_<role_definition_id>_<principal_id>`. See [Module Features](#module-features) for more details. 

 > **_NOTE_** This ID is specific to Terraform and is of the format `{scope}|{roleDefinitionId}|{principalId}`

 > **_NOTE:_** `<path-to-module>` is terraform logical path from root. e.g. _module.pim_

&nbsp;

# Outputs
Outputs are only available when `custom_name` variable is used.
## Structure

| Output Name | Value          | Comment |
| ----------- | -------------- | ------- |
| outputs     | id             |         |
|             | principal_type |         |

&nbsp;

# Module Features
## Optional custom_name
You can choose to use the `custom_name` variable for resource indexing, otherwise a combination of `<scope>_<role_definition_id>_<principal_id>` is used by default. We recommend using `custom_name` for scenarios where you need to use the module outputs.
## Active or Eligible assignment?
This module can deploy Active or Eligible PIM role assignments. You can specify which one you want to deploy by setting the `type` variable to either `Active` or `Eligible`. See [test-case/locals.tf](test-case/locals.tf) for a deployment example.

&nbsp;

# Known Issues
We currently log no issues in this module.
