# Introduction
Resource Group module can deploy these resources:
* azurerm_resource_group (required)

Example variables structure is located in [variables.md](variables.md).

Example use case is located in [test-case/locals.tf](test-case/locals.tf).

You can also see [changelog](changelog.md).

Terraform documentation:

https://registry.terraform.io/providers/hashicorp/azurerm/3.67.0/docs/resources/resource_group

&nbsp;

# Terraform Import
There are a few things you need to do to import resources into .tfstate. In the example below there are resources which can be imported within the module. You may need to modify these commands to the OS on which they will be running (Refer to the [documentation](https://developer.hashicorp.com/terraform/cli/commands/import#example-import-into-resource-configured-with-for_each) for additional details).
### Resource Group
* terraform import '`<path-to-module>`.azurerm_resource_group.resource_group["`<resource-group-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`'

 > **_NOTE:_** `<path-to-module>` is terraform logical path from root. e.g. _module.resource\_group_

&nbsp;

# Outputs
## Structure

| Output Name | Value        | Comment                                              |
| ----------- | ------------ | ---------------------------------------------------- |
| outputs     | name         |                                                      |
|             | id           |                                                      |

## Example usage of outputs
In the example below, outputted _id_ of the deployed Resource Group module is used as a value for the _scope_ variable in Role Assignment resource.
```
module "rg" {
    source = "git@github.com:Seyfor-CSC/mit.resource-group.git?ref=v1.0.0"
    config = [
        {
            name     = "SEY-TERRAFORM-NE-RG01"
            location = "northeurope"
        }
    ]
}

data "azurerm_client_config" "azurerm_client_config" {
}

resource "azurerm_role_assignment" "role_assignment" {
    scope                = module.rg.outputs.sey-terraform-ne-rg01.id # This is how to use output values
    role_definition_name = "Contributor"
    principal_id         = data.azurerm_client_config.azurerm_client_config.object_id

    depends_on = [
        module.rg
    ]
}
```

&nbsp;

# Module Features
No special features in module.

&nbsp;

# Known Issues
We currently log no issues in this module.