# Introduction
Automation Module module can deploy these resources:
* azurerm_automation_module (required)

Example variables structure is located in [variables.md](variables.md).

Example use case is located in [test-case/locals.tf](test-case/locals.tf).

You can also see [changelog](changelog.md).

Terraform documentation:

https://registry.terraform.io/providers/hashicorp/azurerm/3.51.0/docs/resources/automation_module

&nbsp;

# Terraform Import
There are a few things you need to do to import resources into .tfstate. In the example below there are resources which can be imported within the module. You may need to modify these commands to the OS on which they will be running (Refer to the [documentation](https://developer.hashicorp.com/terraform/cli/commands/import#example-import-into-resource-configured-with-for_each) for additional details).
### Automation Module
* terraform import '`<path-to-module>`.azurerm_automation_module.automation_module["`<automation-module-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Automation/automationAccounts/`<automation-account-name>`/modules/`<automation-module-name>`'

 > **_NOTE:_** `<path-to-module>` is terraform logical path from root. e.g. _module.automation\_module_

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
## Dependencies
When there are dependencies across Automation Modules, this module has to be called twice - as a parent module + child module(s) (dependent on the parent module). Go to [test-case](./test-case) to see how to deploy multiple Automation Modules with dependencies between them.