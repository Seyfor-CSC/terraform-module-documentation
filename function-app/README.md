# Introduction
Function App module can deploy these resources:
* azurerm_linux_function_app (optional)
* azurerm_windows_function_app (optional)
* azurerm_monitor_diagnostic_setting (optional)
* azurerm_private_endpoint (optional)

Example variables structure is located in [variables.md](variables.md).

Example use case is located in [test-case/locals.tf](test-case/locals.tf).

You can also see [changelog](changelog.md).

Terraform documentation:

https://registry.terraform.io/providers/hashicorp/azurerm/3.73.0/docs/resources/linux_function_app

https://registry.terraform.io/providers/hashicorp/azurerm/3.73.0/docs/resources/windows_function_app

https://registry.terraform.io/providers/hashicorp/azurerm/3.73.0/docs/resources/monitor_diagnostic_setting

https://registry.terraform.io/providers/hashicorp/azurerm/3.73.0/docs/resources/private_endpoint

&nbsp;

# Terraform Import
There are a few things you need to do to import resources into .tfstate. In the example below there are resources which can be imported within the module. You may need to modify these commands to the OS on which they will be running (Refer to the [documentation](https://developer.hashicorp.com/terraform/cli/commands/import#example-import-into-resource-configured-with-for_each) for additional details).
### Linux Function App
* terraform import '`<path-to-module>`.azurerm_linux_function_app.linux_function_app["`<function-app-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Web/sites/`<function-app-name>`'
### Windows Function App
* terraform import '`<path-to-module>`.azurerm_windows_function_app.windows_function_app["`<function-app-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Web/sites/`<function-app-name>`'
### Diagnostic Setting
* terraform import '`<path-to-module>`.azurerm_monitor_diagnostic_setting.diagnostic_setting["`<function-app-name>`_`<diag-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/providers/Microsoft.Web/sites/`<function-app-name>`|`<diag-name>`'
 ### Private Endpoint
* terraform import '`<path-to-module>`.module.private_endpoint.azurerm_private_endpoint.private_endpoint["`<private-endpoint-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Network/privateEndpoints/`<private-endpoint-name>`'

 > **_NOTE:_** `<path-to-module>` is terraform logical path from root. e.g. _module.function\_app_

&nbsp;

# Outputs
## Structure

| Output Name | Value        | Comment                                              |
| ----------- | ------------ | ---------------------------------------------------- |
| outputs     | name         |                                                      |
|             | id           |                                                      |
|             | principal_id | principal_id (object_id) of system assigned identity |

## Example usage of outputs
In the example below, outputted _id_ of the deployed Function App module is used as a value for the _scope_ variable in Role Assignment resource.
```
module "fa" {
    source = "git@github.com:seyfor-csc/mit.function-app.git?ref=v1.0.0"
    config = [
        {
            os_type                    = "Windows"
            name                       = "SEY-TERRAFORM-NE-FA01"
            resource_group_name        = "SEY-TERRAFORM-NE-RG01"
            location                   = "northeurope"
            service_plan_id            = azurerm_service_plan.service_plan.id
            storage_account_name       = azurerm_storage_account.storage_account.name
            storage_account_access_key = azurerm_storage_account.storage_account.primary_access_key
            site_config                = {}
        }
    ]
}

data "azurerm_client_config" "azurerm_client_config" {
}

resource "azurerm_role_assignment" "role_assignment" {
    scope                = module.fa.outputs.sey-terraform-ne-fa01.id # This is how to use output values
    role_definition_name = "Contributor"
    principal_id         = data.azurerm_client_config.azurerm_client_config.object_id

    depends_on = [
        module.fa
    ]
}
```

&nbsp;

# Module Features
## Linux or Windows Function App?
This module can deploy Linux or Windows Function Apps. You can specify which one you want to deploy by setting the _os\_type_ variable for the Function App resource to either _Linux_ or _Windows_. See [test-case/locals.tf](test-case/locals.tf) for a deployment example.

&nbsp;

# Known Issues
## Supported Variables
Not all available variables are currently supported in this module. See [variables.md](variables.md) for an overview of supported variables.