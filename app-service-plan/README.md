# Introduction
App Service Plan module can deploy these resources:
* azurerm_service_plan (required)
* azurerm_monitor_diagnostic_setting (optional)

Example variables structure is located in [variables.md](variables.md).

Example use case is located in [test-case/locals.tf](test-case/locals.tf).

You can also see [changelog](CHANGELOG.md).

Terraform documentation:

https://registry.terraform.io/providers/hashicorp/azurerm/4.14.0/docs/resources/service_plan

https://registry.terraform.io/providers/hashicorp/azurerm/4.14.0/docs/resources/monitor_diagnostic_setting

> **WARNING:** AzureRM provider had been updated to a new major version. Many breaking changes were implemented. See the [providers guide](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/4.0-upgrade-guide) for more information.

&nbsp;

# Terraform Import
There are a few things you need to do to import resources into .tfstate. In the example below there are resources which can be imported within the module. You may need to modify these commands to the OS on which they will be running (Refer to the [documentation](https://developer.hashicorp.com/terraform/cli/commands/import#example-import-into-resource-configured-with-for_each) for additional details).
### App Service Plan
* terraform import '`<path-to-module>`.azurerm_service_plan.service_plan["`<app-service-plan-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Web/serverFarms/`<app-service-plan-name>`'
### Diagnostic Setting
* terraform import '`<path-to-module>`.azurerm_monitor_diagnostic_setting.diagnostic_setting["`<app-service-plan-name>`_`<diag-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Web/serverFarms/`<app-service-plan-name>`|`<diag-name>`'

 > **_NOTE:_** `<path-to-module>` is terraform logical path from root. e.g. _module.app\_service\_plan_

&nbsp;

# Outputs
## Structure

| Output Name | Value               | Comment                                              |
| ----------- | ------------------- | ---------------------------------------------------- |
| outputs     | name                | App Service Plan name                                |
|             | id                  | App Service Plan id                                  |

## Example usage of outputs
In the example below, outputted _id_ of the deployed App Service Plan module is used as a value for the _scope_ variable in Role Assignment resource.
```
module "asp" {
    source = "git@github.com:seyfor-csc/mit.app-service-plan.git?ref=v1.0.0"
    config = [
        {
            name                = "SEY-TERRAFORM-NE-ASP01"
            location            = "northeurope"
            resource_group_name = "SEY-TERRAFORM-NE-RG01"
            os_type             = "Windows"
            sku_name            = "P1v2"
        }
    ]
}

data "azurerm_client_config" "azurerm_client_config" {
}

resource "azurerm_role_assignment" "role_assignment" {
    scope                = module.asp.outputs.sey-terraform-ne-asp01.id # This is how to use output values
    role_definition_name = "Contributor"
    principal_id         = data.azurerm_client_config.azurerm_client_config.object_id
}
```

&nbsp;

# Module Features
No special features in module.

&nbsp;

# Known Issues
We currently log no issues in this module.