# Introduction
Role definition module can deploy these resources:
* azurerm_role_definition (required)

Example variables structure is located in [variables.md](variables.md).

Example use case is located in [test-case/locals.tf](test-case/locals.tf).

You can also see [changelog](CHANGELOG.md).

Terraform documentation:

https://registry.terraform.io/providers/hashicorp/azurerm/4.45.0/docs/resources/role_definition

&nbsp;

> **WARNING:** AzureRM provider had been updated to a new major version. Many breaking changes were implemented. See the [providers guide](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/4.0-upgrade-guide) for more information.

# Terraform Import
There are a few things you need to do to import resources into .tfstate. In the example below there are resources which can be imported within the module. You may need to modify these commands to the OS on which they will be running (Refer to the [documentation](https://developer.hashicorp.com/terraform/cli/commands/import#example-import-into-resource-configured-with-for_each) for additional details).
### Role Definition
* terraform import '`<path-to-module>`.azurerm_role_definition.role_definition["`<role-definition-name>`"]' '/subscriptions/`<subscription-id>`/providers/Microsoft.Authorization/roleDefinitions/`<role-definition-id>`|`<scope>`'
 > **_NOTE:_** `<path-to-module>` is terraform logical path from root. e.g. _module.role\_definition_

&nbsp;

# Outputs
## Structure

| Output Name | Value                | Comment                                                                                      |
| ----------- | -------------------- | -------------------------------------------------------------------------------------------- |
| outputs     | role_definition_name |                                                                                              |
|             | role_definition_id   | In the format of "/providers/Microsoft.Authorization/roleDefinitions/`<role-definition-id>`" |


## Example usage of outputs
In the example below, outputted _id_ of the deployed Role Definition module is used as a value for the _scope_ variable in Role Assignment resource.
```
data azurerm_subscription "primary" {}

module "rd" {
    source = "git@github.com:seyfor-csc/mit.role-definition.git?ref=v1.0.0"
    config = [
        {
            name        = "Contributor"
            scope       = data.azurerm_subscription.primary.id
            permissions = {
                actions = [
                    "Microsoft.Storage/storageAccounts/blobServices/containers/read"
                ]
                not_actions = [
                    "Microsoft.Authorization/*/Delete",
                    "Microsoft.Authorization/*/Write"
                ]
            }
        }
    ]
}

data "azurerm_client_config" "azurerm_client_config" {}


resource "azurerm_role_assignment" "role_assignment" {
    scope                = data.azurerm_subscription.primary.id
    role_definition_id   = module.rd.outputs.sey-terraform-ne-rd01.id # This is how to use output values
    principal_id         = data.azurerm_client_config.azurerm_client_config.object_id

    depends_on = [
        module.rd
    ]
}
```

&nbsp;

# Module Features
No special features in module.

&nbsp;

# Known Issues
We currently log no issues in this module.