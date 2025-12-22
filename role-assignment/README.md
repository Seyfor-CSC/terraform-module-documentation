# Introduction
Role Assignment module can deploy these resources:
* azurerm_role_assignment (required)

Example variables structure is located in [variables.md](variables.md).

Example use case is located in [test-case/locals.tf](test-case/locals.tf).

You can also see [changelog](CHANGELOG.md).

Terraform documentation:

https://registry.terraform.io/providers/hashicorp/azurerm/4.56.0/docs/resources/role_assignment

&nbsp;

> **WARNING:** AzureRM provider had been updated to a new major version. Many breaking changes were implemented. See the [providers guide](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/4.0-upgrade-guide) for more information.

# Terraform Import
There are a few things you need to do to import resources into .tfstate. In the example below there are resources which can be imported within the module. You may need to modify these commands to the OS on which they will be running (Refer to the [documentation](https://developer.hashicorp.com/terraform/cli/commands/import#example-import-into-resource-configured-with-for_each) for additional details).
### Role-Assignment
* terraform import '`<path-to-module>`.azurerm_role_assignment.role_assignment["`<role-assignment-custom-name>`"]' '/subscriptions/`<subscription-id>`/providers/Microsoft.Authorization/roleAssignments/`<role-assignment-id>`'
 > **_NOTE:_** `<path-to-module>` is terraform logical path from root. e.g. _module.role\_assignment_

 > **_NOTE:_** The resource id differs based on which scope the role is assigned to. The example above is for a subscription scope assignment.
 
 > **_NOTE:_** `<role-assignment-id>` format is 00000000-0000-0000-0000-000000000000

&nbsp;

# Outputs
## Structure

| Output Name | Value        | Comment                                       |
| ----------- | ------------ | --------------------------------------------- |
| outputs     | name         |                                               |
|             | id           |                                               |
|             | principal_id | principal_id (object_id) of assigned identity |


&nbsp;

# Module Features
We created a custom required variable named `custom_name` which is used as a unique value for looping through all instances of the resource. This variable is also used to access the module outputs. Go to [test-case/locals.tf](test-case/locals.tf) to see how to use it correctly.

&nbsp;

# Known Issues
We currently log no issues in this module.
