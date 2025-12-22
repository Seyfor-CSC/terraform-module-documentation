# Introduction
Policy Definition module can deploy these resources:
* azurerm_policy_definition (required)

Example variables structure is located in [variables.md](variables.md).

Example use case is located in [test-case/locals.tf](test-case/locals.tf).

You can also see [changelog](CHANGELOG.md).

Terraform documentation:

https://registry.terraform.io/providers/hashicorp/azurerm/4.56.0/docs/resources/policy_definition

&nbsp;

> **WARNING:** AzureRM provider had been updated to a new major version. Many breaking changes were implemented. See the [providers guide](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/4.0-upgrade-guide) for more information.

# Terraform Import
There are a few things you need to do to import resources into .tfstate. In the example below there are resources which can be imported within the module. You may need to modify these commands to the OS on which they will be running (Refer to the [documentation](https://developer.hashicorp.com/terraform/cli/commands/import#example-import-into-resource-configured-with-for_each) for additional details).
### Management Group Level Policy Definition
* terraform import '`<path-to-module>`.azurerm_policy_definition.policy_definition["`<policy-definition-name>`"]' '/providers/Microsoft.Management/managementGroups/`<management-group-id>`/providers/Microsoft.Authorization/policyDefinitions/`<policy-definition-name>`'
### Subscription Level Policy Definition
* terraform import '`<path-to-module>`.azurerm_policy_definition.policy_definition["`<policy-definition-name>`"]' '/subscriptions/`<subscription-id>`/providers/Microsoft.Authorization/policyDefinitions/`<policy-definition-name>`'

>**_NOTE:_** `<path-to-module>` is terraform logical path from root. e.g. _module.policy\_definition_

&nbsp;

# Outputs
## Structure

| Output Name | Value               | Comment |
| ----------- | ------------------- | ------- |
| outputs     | name                |         |
|             | id                  |         |
|             | role_definition_ids |         |


## Example usage of outputs
In the example below, outputted _id_ of the deployed Policy Definition module is used as a value for the _policy\_definition\_id_ variable in Policy Assignment resource.
```
module "policy_definition" {
    source = "git@github.com:seyfor-csc/mit.policy-definition.git?ref=v1.0.0"
    config = [
        {
            name         = "SEY-TERRAFORM-NE-POLICY01"
            policy_type  = "Custom"
            mode         = "Indexed"
            display_name = "SEY-TERRAFORM-NE-POLICY01"
            parameters   = "${path.module}/parameters/SEY-TERRAFORM-NE-POLICY01.json"
            policy_rule = <<POLICY_RULE
            {
                "if": {
                    "not": {
                    "field": "location",
                    "in": "[parameters('allowedLocations')]"
                    }
                },
                "then": {
                    "effect": "audit"
                }
            }
            POLICY_RULE
        }
    ]
}

resource "azurerm_policy_assignment" "policy_assignment" {
    display_name         = "AllowedLocations"
    name                 = "AllowedLocations"
    location             = "northeurope"
    management_group_id  = "/providers/Microsoft.Management/managementGroups/666-666-666-666-666" # replace with your own
    policy_definition_id = module.policy_definition.outputs.sey-terraform-ne-policy01.id # This is how to use output values
    parameters = <<PARAMETERS
        {
            "allowedLocations": {
                "value": [
                    "global",
                    "northeurope",
                    "centralindia",
                    "westeurope"
                ]
            }
        }
    PARAMETERS
}
```

&nbsp;

# Module Features
No special features in module.

&nbsp;

# Known Issues
We currently log no issues in this module.
