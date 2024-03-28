# Introduction
User Assigned Identity module can deploy these resources:
* azurerm_user_assigned_identity (required)

Example variables structure is located in [variables.md](variables.md).

Example use case is located in [test-case/locals.tf](test-case/locals.tf).

You can also see [changelog](changelog.md).

Terraform documentation:

https://registry.terraform.io/providers/hashicorp/azurerm/3.96.0/docs/resources/user_assigned_identity

&nbsp;

# Terraform Import
There are a few things you need to do to import resources into .tfstate. In the example below there are resources which can be imported within the module. You may need to modify these commands to the OS on which they will be running (Refer to the [documentation](https://developer.hashicorp.com/terraform/cli/commands/import#example-import-into-resource-configured-with-for_each) for additional details).
### User Assigned Identity
* terraform import '`<path-to-module>`.azurerm_user_assigned_identity.user_assigned_identity["`<user-assigned-identity-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.ManagedIdentity/userAssignedIdentities/`<user-assigned-identity-name>`'

 > **_NOTE:_** `<path-to-module>` is terraform logical path from root. e.g. _module.user\_assigned\_identity_

&nbsp;

# Outputs
## Structure

| Output Name | Value        | Comment                                                         |
| ----------- | ------------ | --------------------------------------------------------------- |
| outputs     | name         |                                                                 |
|             | id           |                                                                 |
|             | principal_id | Id of the Service Principal object associated with the identity |
|             | client_id    | Id of the app associated with the identity                      |
|             | tenant_id    | Id of the tenant which the identity belongs to                  |


## Example usage of outputs
In the example below, outputted _id_ of the deployed User Assigned Identity module is used as a value for the _scope_ variable in Role Assignment resource.
```
module "uai" {
    source = "git@github.com:Seyfor-CSC/mit.user-assigned-identity.git?ref=v1.0.0"
    config = [
        {
            name                = "SEY-TERRAFORM-NE-UAI01"
            location            = "northeurope"
            resource_group_name = "SEY-TERRAFORM-NE-RG01"
        }
    ]
}

data "azurerm_client_config" "azurerm_client_config" {
}

resource "azurerm_role_assignment" "role_assignment" {
    scope                = module.uai.outputs.sey-terraform-ne-uai01.id # This is how to use output values
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
