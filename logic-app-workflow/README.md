# Introduction
Logic App Workflow module can deploy these resources:
* azurerm_logic_app_workflow (required)
* azurerm_monitor_diagnostic_setting (optional)

Example variables structure is located in [variables.md](variables.md).

Example use case is located in [test-case/locals.tf](test-case/locals.tf).

You can also see [changelog](CHANGELOG.md).

Terraform documentation:

https://registry.terraform.io/providers/hashicorp/azurerm/4.14.0/docs/resources/logic_app_workflow

https://registry.terraform.io/providers/hashicorp/azurerm/4.14.0/docs/resources/monitor_diagnostic_setting

&nbsp;

> **WARNING:** AzureRM provider had been updated to a new major version. Many breaking changes were implemented. See the [providers guide](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/4.0-upgrade-guide) for more information.

# Terraform Import
There are a few things you need to do to import resources into .tfstate. In the example below there are resources which can be imported within the module. You may need to modify these commands to the OS on which they will be running (Refer to the [documentation](https://developer.hashicorp.com/terraform/cli/commands/import#example-import-into-resource-configured-with-for_each) for additional details).
### Logic App Workflow
* terraform import '`<path-to-module>`.azurerm_logic_app_workflow.logic_app_workflow["`<logic-app-workflow-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Logic/workflows/`<logic-app-workflow-name>`'
### Diagnostic Setting
* terraform import '`<path-to-module>`.azurerm_monitor_diagnostic_setting.diagnostic_setting["`<logic-app-workflow-name>`_`<diag-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Logic/workflows/`<logic-app-workflow-name>`|`<diag-name>`'

 > **_NOTE:_** `<path-to-module>` is terraform logical path from root. e.g. _module.logic\_app\_workflow_

&nbsp;

# Outputs
## Structure

| Output Name | Value           | Comment                                              |
| ----------- | --------------- | ---------------------------------------------------- |
| outputs     | id              |                                                      |
|             | name            |                                                      |
|             | access_endpoint |                                                      |
|             | principal_id    | principal_id (object_id) of system assigned identity |


## Example usage of outputs
In the example below, outputted _id_ of the deployed Logic App Workflow module is used as a value for the _scope_ variable in Role Assignment resource.
```
module "logic" {
    source = "git@github.com:seyfor-csc/mit.logic-app-workflow.git?ref=v1.0.0"
    config = [
        {
            name                       = "SEY-TERRAFORM-NE-LOGIC01"
            location                   = "northeurope"
            resource_group_name        = "SEY-TERRAFORM-NE-RG01"
        }
    ]
}

data "azurerm_client_config" "azurerm_client_config" {
}

resource "azurerm_role_assignment" "role_assignment" {
    scope                = module.logic.outputs.sey-terraform-ne-logic01.id # This is how to use output values
    role_definition_name = "Contributor"
    principal_id         = data.azurerm_client_config.azurerm_client_config.object_id
}
```

&nbsp;

# Module Features
## Lifecycle
This module has a lifecycle block setup like this:
```
lifecycle {
    ignore_changes = [
        workflow_parameters,
        parameters
    ]
}
```
This means you can't manage _workflow\_parameters_ and _parameters_ (the inside configuration of Logic App Workflow) variables by Terraform

&nbsp;

# Known Issues
We currently log no issues in this module.