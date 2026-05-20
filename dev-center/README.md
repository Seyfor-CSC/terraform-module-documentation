# Introduction
Dev Center module can deploy these resources:
* azurerm_dev_center (required)
* azurerm_dev_center_project (optional)
* azurerm_monitor_diagnostic_setting (optional)

Example variables structure is located in [variables.md](variables.md).

Example use case is located in [test-case/locals.tf](test-case/locals.tf).

You can also see [changelog](CHANGELOG.md).

Terraform documentation:

https://registry.terraform.io/providers/hashicorp/azurerm/4.64.0/docs/resources/dev_center

https://registry.terraform.io/providers/hashicorp/azurerm/4.64.0/docs/resources/dev_center_project

https://registry.terraform.io/providers/hashicorp/azurerm/4.64.0/docs/resources/monitor_diagnostic_setting

&nbsp;

# Terraform Import
There are a few things you need to do to import resources into .tfstate. In the example below there are resources which can be imported within the module. You may need to modify these commands to the OS on which they will be running (Refer to the [documentation](https://developer.hashicorp.com/terraform/cli/commands/import#example-import-into-resource-configured-with-for_each) for additional details).

### Dev Center
* terraform import '`<path-to-module>`.azurerm_dev_center.dev_center["`<dev-center-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.DevCenter/devCenters/`<dev-center-name>`'

### Dev Center Project
* terraform import '`<path-to-module>`.azurerm_dev_center_project.project["`<dev-center-name>`_`<project-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.DevCenter/projects/`<project-name>`'

### Diagnostic Setting
* terraform import '`<path-to-module>`.azurerm_monitor_diagnostic_setting.diagnostic_setting["`<dev-center-name>`_`<diag-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.DevCenter/devCenters/`<dev-center-name>`|`<diag-name>`'

> **_NOTE:_** `<path-to-module>` is terraform logical path from root. e.g. _module.dev\_center_

&nbsp;

# Outputs
## Structure

| Output Name | Value               | Comment                                              |
| ----------- | ------------------- | ---------------------------------------------------- |
| outputs     | name                |                                                      |
|             | id                  |                                                      |
|             | principal_id        | principal_id (object_id) of system assigned identity |
|             | project             | Dev Center Project outputs                           |
|             | &nbsp; name         |                                                      |
|             | &nbsp; id           |                                                      |
|             | &nbsp; principal_id | principal_id (object_id) of system assigned identity |

## Example usage of outputs
In the example below, outputted _id_ of the deployed Dev Center module is used as a value for the _scope_ variable in Role Assignment resource.

```terraform
module "dev_center" {
  source = "git@github.com:seyfor-csc/mit.dev-center.git?ref=v2.0.0"
  config = [
    {
      name                = "SEY-TERRAFORM-NE-DC01"
      location            = "northeurope"
      resource_group_name = "SEY-DEVCENTER-NE-RG01"
    }
  ]
}

data "azurerm_client_config" "azurerm_client_config" {
}

resource "azurerm_role_assignment" "role_assignment" {
  scope                = module.dev_center.outputs.sey-terraform-ne-dc01.id # This is how to use output values
  role_definition_name = "Contributor"
  principal_id         = data.azurerm_client_config.azurerm_client_config.object_id
}
```

&nbsp;

# Module Features
## Monitoring tags in `ignore_changes` lifecycle block
We reserve the right to include tags dedicated to our product Advanced Monitoring in the `ignore_changes` lifecycle block. This is to prevent the module from deleting those tags. The tags we ignore are: `tags["Platform"]`, `tags["MonitoringTier"]`.

&nbsp;

# Known Issues
We currently log no issues in this module.
