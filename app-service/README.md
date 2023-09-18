# Introduction
App Service module can deploy these resources:
* azurerm_service_plan (required)
* azurerm_linux_web_app (optional)
* azurerm_windows_web_app (optional)
* azurerm_monitor_diagnostic_setting (optional)
* azurerm_private_endpoint (optional)

Example variables structure is located in [variables.md](variables.md).

Example use case is located in [test-case/locals.tf](test-case/locals.tf).

You can also see [changelog](changelog.md).

Terraform documentation:

https://registry.terraform.io/providers/hashicorp/azurerm/3.73.0/docs/resources/service_plan

https://registry.terraform.io/providers/hashicorp/azurerm/3.73.0/docs/resources/linux_web_app

https://registry.terraform.io/providers/hashicorp/azurerm/3.73.0/docs/resources/windows_web_app

https://registry.terraform.io/providers/hashicorp/azurerm/3.73.0/docs/resources/monitor_diagnostic_setting

https://registry.terraform.io/providers/hashicorp/azurerm/3.73.0/docs/resources/private_endpoint

&nbsp;

# Terraform Import
There are a few things you need to do to import resources into .tfstate. In the example below there are resources which can be imported within the module. You may need to modify these commands to the OS on which they will be running (Refer to the [documentation](https://developer.hashicorp.com/terraform/cli/commands/import#example-import-into-resource-configured-with-for_each) for additional details).
### App Service Plan
* terraform import '`<path-to-module>`.azurerm_service_plan.service_plan["`<app-service-plan-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Web/serverfarms/`<app-service-plan-name>`'
### Linux Web App
* terraform import '`<path-to-module>`.azurerm_linux_web_app.linux_web_app["`<app-service-plan-name>`_`<web-app-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Web/sites/`<web-app-name>`'
### Windows Web App
* terraform import '`<path-to-module>`.azurerm_windows_web_app.windows_web_app["`<app-service-plan-name>`_`<web-app-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Web/sites/`<web-app-name>`'
### Diagnostic Setting
* terraform import '`<path-to-module>`.azurerm_monitor_diagnostic_setting.diagnostic_setting["`<web-app-name>`_`<diag-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/providers/Microsoft.Web/sites/`<web-app-name>`|`<diag-name>`'
 ### Private Endpoint
* terraform import '`<path-to-module>`.module.private_endpoint.azurerm_private_endpoint.private_endpoint["`<private-endpoint-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Network/privateEndpoints/`<private-endpoint-name>`'

 > **_NOTE:_** `<path-to-module>` is terraform logical path from root. e.g. _module.app\_service_

&nbsp;

# Outputs
## Structure

| Output Name | Value               | Comment                                              |
| ----------- | ------------------- | ---------------------------------------------------- |
| outputs     | name                | App Service Plan name                                |
|             | id                  | App Service Plan id                                  |
|             | linux_web_app       | Linux Web App outputs                                |
|             | &nbsp; name         |                                                      |
|             | &nbsp; id           |                                                      |
|             | &nbsp; principal_id | principal_id (object_id) of system assigned identity |
|             | windows_web_app     | Windows Web App outputs                              |
|             | &nbsp; name         |                                                      |
|             | &nbsp; id           |                                                      |
|             | &nbsp; principal_id | principal_id (object_id) of system assigned identity |

## Example usage of outputs
In the example below, outputted _id_ of the deployed App Service module is used as a value for the _scope_ variable in Role Assignment resource.
```
module "app" {
    source = "git@github.com:seyfor-csc/mit.app-service.git?ref=v1.0.0"
    config = [
        {
            name                = "SEY-TERRAFORM-NE-ASP01"
            location            = "northeurope"
            resource_group_name = "SEY-TERRAFORM-NE-RG01"
            os_type             = "Windows"
            sku_name            = "P1v2"
            web_app = [
                {
                    name        = "SEY-TERRAFORM-NE-APP01"
                    location    = "northeurope"
                    site_config = {}
                }
            ]
        }
    ]
}

data "azurerm_client_config" "azurerm_client_config" {
}

resource "azurerm_role_assignment" "role_assignment" {
    scope                = module.app.outputs.sey-terraform-ne-asp01.windows_web_app.sey-terraform-ne-app01.id # This is how to use output values
    role_definition_name = "Contributor"
    principal_id         = data.azurerm_client_config.azurerm_client_config.object_id

    depends_on = [
        module.app
    ]
}
```

&nbsp;

# Module Features
## Linux or Windows Web App?
This module can deploy Linux or Windows Web Apps. You can specify which one you want to deploy by setting the _os\_type_ variable for the App Service Plan resource to either _Linux_ or _Windows_. See [test-case/locals.tf](test-case/locals.tf) for a deployment example.

&nbsp;

# Known Issues
## Supported Variables
Not all available variables are currently supported in this module. See [variables.md](variables.md) for an overview of supported variables.