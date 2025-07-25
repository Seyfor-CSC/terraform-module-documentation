# Introduction
Container App Environment module can deploy these resources:
* azurerm_container_app_environment (required)
* azurerm_container_app_environment_storage (optional)
* azurerm_monitor_diagnostic_setting (optional)

Example variables structure is located in [variables.md](variables.md).

Example use case is located in [test-case/locals.tf](test-case/locals.tf).

You can also see [changelog](CHANGELOG.md).

Terraform documentation:

https://registry.terraform.io/providers/hashicorp/azurerm/4.33.0/docs/resources/container_app_environment

https://registry.terraform.io/providers/hashicorp/azurerm/4.33.0/docs/resources/container_app_environment_storage

https://registry.terraform.io/providers/hashicorp/azurerm/4.33.0/docs/resources/monitor_diagnostic_setting


> **WARNING:** AzureRM provider had been updated to a new major version. Many breaking changes were implemented. See the [providers guide](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/4.0-upgrade-guide) for more information.

&nbsp;

# Terraform Import
There are a few things you need to do to import resources into .tfstate. In the example below there are resources which can be imported within the module. You may need to modify these commands to the OS on which they will be running (Refer to the [documentation](https://developer.hashicorp.com/terraform/cli/commands/import#example-import-into-resource-configured-with-for_each) for additional details).
### Container App Environment
* terraform import '`<path-to-module>`.azurerm_container_app_environment.container_app_environment["`<container-app-environment-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.App/managedEnvironments/`<container-app-environment-name>`'
### Container App Environment Storage
* terraform import '`<path-to-module>`.azurerm_container_app_environment_storage.container_app_environment_storage["`<container-app-environment-name>`_`<container-app-environment-storage-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.App/managedEnvironments/`<container-app-environment-name>`/storages/`<container-app-environment-storage-name>`'
### Diagnostic Setting
* terraform import '`<path-to-module>`.azurerm_monitor_diagnostic_setting.diagnostic_setting["`<container-app-environment-name>`_`<diag-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.App/managedEnvironments/`<container-app-environment-name>`|`<diag-name>`'

 > **_NOTE:_** `<path-to-module>` is terraform logical path from root. e.g. _module.container\_app\_environment_

&nbsp;

# Outputs
## Structure

| Output Name | Value             | Comment                                           |
| ----------- | ----------------- | ------------------------------------------------- |
| outputs     | name              |                                                   |
|             | id                |                                                   |
|             | default_domain    | Default, publicly resolvable name of deployed CAE |
|             | static_ip_address | Static IP address of deployed CAE                 |
|             | storage           | Container App Environment Storage outputs         |
|             | &nbsp;id          |                                                   |

## Example usage of outputs
In the example below, outputted _id_ of the deployed Container App Environment module is used as a value for the _scope_ variable in Role Assignment resource.
```
module "cae" {
    source = "git@github.com:Seyfor-CSC/mit.container-app-environment.git?ref=v1.0.0"
    config = [
        {
            name                = "SEYTERRAFORMNECAE01"
            location            = "northeurope"
            resource_group_name = "SEY-TERRAFORM-NE-RG01"
        }
    ]
}

data "azurerm_client_config" "azurerm_client_config" {
}

resource "azurerm_role_assignment" "role_assignment" {
    scope                = module.cae.outputs.seyterraformnecae01.id # This is how to use output values
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
## workload_profile variables requirement
`maximum_count` and `minimum_count` variables in the `workload_profile` object variable are optional as they can't be set to any value when `workload_profile_type = "Consumption"`.