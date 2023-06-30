# Introduction
Logic App Standard module can deploy these resources:
* azurerm_logic_app_standard (required)
* azurerm_monitor_diagnostic_setting (optional)

Example variables structure is located in [variables.md](variables.md).

Example use case is located in [test-case/locals.tf](test-case/locals.tf).

You can also see [changelog](changelog.md).

Terraform documentation:

https://registry.terraform.io/providers/hashicorp/azurerm/3.51.0/docs/resources/logic_app_standard

https://registry.terraform.io/providers/hashicorp/azurerm/3.51.0/docs/resources/monitor_diagnostic_setting

&nbsp;

# Terraform Import
There are a few things you need to do to import resources into .tfstate. In the example below there are resources which can be imported within the module. You may need to modify these commands to the OS on which they will be running (Refer to the [documentation](https://developer.hashicorp.com/terraform/cli/commands/import#example-import-into-resource-configured-with-for_each) for additional details).
### Logic App Standard
* terraform import '`<path-to-module>`.azurerm_logic_app_standard.logic_app_standard["`<logic-app-standard-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Web/sites/`<logic-app-standard-name>`'
### Diagnostic Setting
* terraform import '`<path-to-module>`.azurerm_monitor_diagnostic_setting.diagnostic_setting["`<public-ip-name>`_`<diag-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Web/sites/`<public-ip-name>`|`<diag-name>`'

 > **_NOTE:_** `<path-to-module>` is terraform logical path from root. e.g. _module.logic\_app\_standard_

&nbsp;

# Outputs
## Structure

| Output Name | Value                         | Comment                                              |
| ----------- | ----------------------------- | ---------------------------------------------------- |
| outputs     | name                          |                                                      |
|             | id                            |                                                      |
|             | custom_domain_verification_id |                                                      |
|             | default_hostname              |                                                      |
|             | principal_id                  | principal_id (object_id) of system assigned identity |


## Example usage of outputs
In the example below, outputted _id_ of the deployed Logic App Standard module is used as a value for the _scope_ variable in Role Assignment resource.
```
module "logic" {
    source = "git@github.com:seyfor-csc/mit.logic-app-standard.git?ref=v1.0.0"
    config = [
        {
            name                       = "SEY-TERRAFORM-NE-LOGIC01"
            location                   = "northeurope"
            resource_group_name        = "SEY-TERRAFORM-NE-RG01"
            app_service_plan_id        = azurerm_service_plan.asp.id
            storage_account_name       = "seyterraformlogicsa01"
            storage_account_access_key = azurerm_storage_account.sa.primary_access_key
        }
    ]
}

data "azurerm_client_config" "azurerm_client_config" {
}

resource "azurerm_role_assignment" "role_assignment" {
    scope                = module.logic.outputs.sey-terraform-ne-logic01.id # This is how to use output values
    role_definition_name = "Contributor"
    principal_id         = data.azurerm_client_config.azurerm_client_config.object_id

    depends_on = [
        module.logic
    ]
}
```

&nbsp;

# Module Features
No special features in module.

&nbsp;

# Known Issues
We currently log no issues in this module.