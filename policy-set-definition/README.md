# Introduction
Policy Set Definition module can deploy these resources:
* azurerm_policy_set_definition (required)

Example variables structure is located in [variables.md](variables.md).

Example use case is located in [test-case/locals.tf](test-case/locals.tf).

You can also see [changelog](CHANGELOG.md).

Terraform documentation:

https://registry.terraform.io/providers/hashicorp/azurerm/4.33.0/docs/resources/policy_set_definition

&nbsp;

> **WARNING:** AzureRM provider had been updated to a new major version. Many breaking changes were implemented. See the [providers guide](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/4.0-upgrade-guide) for more information.

# Terraform Import
There are a few things you need to do to import resources into .tfstate. In the example below there are resources which can be imported within the module. You may need to modify these commands to the OS on which they will be running (Refer to the [documentation](https://developer.hashicorp.com/terraform/cli/commands/import#example-import-into-resource-configured-with-for_each) for additional details).
### Management Group Level Policy Set Definition
* terraform import '`<path-to-module>`.azurerm_policy_set_definition.policy_set_definition["`<policy-set-definition-name>`"]' '/providers/Microsoft.Management/managementGroups/`<management-group-id>`/providers/Microsoft.Authorization/policySetDefinitions/`<policy-set-definition-name>`'
### Subscription Level Policy Set Definition
* terraform import '`<path-to-module>`.azurerm_policy_set_definition.policy_set_definition["`<policy-set-definition-name>`"]' '/subscriptions/`<subscription-id>`/providers/Microsoft.Authorization/policySetDefinitions/`<policy-set-definition-name>`'

>**_NOTE:_** `<path-to-module>` is terraform logical path from root. e.g. _module.policy\_set\_definition_

&nbsp;

# Outputs
## Structure

| Output Name | Value | Comment |
| ----------- | ----- | ------- |
| outputs     | name  |         |
|             | id    |         |


## Example usage of outputs
In the example below, outputted _id_ of the deployed Policy Set Definition module is used as a value for the _policy\_definition\_id_ variable in Policy Assignment resource.
```
module "policy_set_definition" {
    source = "git@github.com:seyfor-csc/mit.policy-set-definition.git?ref=v1.0.0"
    config = [
        {
            name         = "SEY-TERRAFORM-NE-POLICY01"
            policy_type  = "Custom"
            display_name = "SEY-TERRAFORM-NE-POLICY01"
            parameters   = "${path.module}/parameters/SEY-TERRAFORM-NE-POLICY01.json"

            policy_definition_reference {
                policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/e765b5de-1225-4ba3-bd56-1ac6695af988"
                parameter_values     = <<VALUE
                    {
                        "listOfAllowedLocations": {"value": "[parameters('allowedLocations')]"}
                    }
                VALUE
            }
        }
    ]
}

resource "azurerm_policy_assignment" "policy_assignment" {
    display_name         = "AllowedLocations"
    name                 = "AllowedLocations"
    location             = "northeurope"
    management_group_id  = "/providers/Microsoft.Management/managementGroups/666-666-666-666-666" # replace with your own
    policy_definition_id = module.policy_set_definition.outputs.sey-terraform-ne-policy01.id # This is how to use output values
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
## parameters variable
Parameters are passed into policy set definition through a json file. See [test-case/locals.tf](test-case/locals.tf) and [test-case/parameters](test-case/parameters) for an example of how to use this variable.

&nbsp;

# Known Issues
We currently log no issues in this module.