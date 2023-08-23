# Introduction
Purview Account module can deploy these resources:
* azurerm_purview_account (required)

Example variables structure is located in [variables.md](variables.md).

Example use case is located in [test-case/locals.tf](test-case/locals.tf).

You can also see [changelog](changelog.md).

Terraform documentation:

https://registry.terraform.io/providers/hashicorp/azurerm/3.67.0/docs/resources/purview_account

&nbsp;

# Terraform Import
There are a few things you need to do to import resources into .tfstate. In the example below there are resources which can be imported within the module. You may need to modify these commands to the OS on which they will be running (Refer to the [documentation](https://developer.hashicorp.com/terraform/cli/commands/import#example-import-into-resource-configured-with-for_each) for additional details).
### Purview account
* terraform import '`<path-to-module>`.azurerm_purview_account.purview_account["`<purview-account-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Purview/accounts/`<purview-account-name>`'

 > **_NOTE:_** `<path-to-module>` is terraform logical path from root. e.g. _module.purview\_account_

&nbsp;

# Outputs
## Structure

| Output Name | Value        | Comment                                              |
| ----------- | ------------ | ---------------------------------------------------- |
| outputs     | name         |                                                      |
|             | id           |                                                      |
|             | principal_id | principal_id (object_id) of system assigned identity |

## Example usage of outputs
In the example below, outputted _id_ of the deployed Purview account module is used as a value for the _scope_ variable in Role Assignment resource.
```
module "pa" {
    source = "git@github.com:seyfor-csc/mit.purview-account.git?ref=v1.0.0"
    config = [
        {
            name                = "SEY-TERRAFORM-NE-PA01"
            location            = "westeurope"
            resource_group_name = "SEY-TERRAFORM-NE-RG01"
            identity = {
                type = "SystemAssigned"
            }
        }
    ]
}

data "azurerm_client_config" "azurerm_client_config" {
}

resource "azurerm_role_assignment" "role_assignment" {
    scope                = module.pa.outputs.sey-terraform-ne-pa01.id # This is how to use output values
    role_definition_name = "Contributor"
    principal_id         = data.azurerm_client_config.azurerm_client_config.object_id

    depends_on = [
        module.pa
    ]
}
```

&nbsp;

# Module Features
No special features in module.

&nbsp;

# Known Issues
We currently log no issues in this module.