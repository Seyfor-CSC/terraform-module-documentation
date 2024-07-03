# Introduction
Cognitive Account module can deploy these resources:
* azurerm_cognitive_account (required)
* azurerm_cognitive_deployment (optional)
* azurerm_monitor_diagnostic_setting (optional)
* azurerm_private_endpoint (optional)

Example variables structure is located in [variables.md](variables.md).

Example use case is located in [test-case/locals.tf](test-case/locals.tf).

You can also see [changelog](CHANGELOG.md).

Terraform documentation:

https://registry.terraform.io/providers/hashicorp/azurerm/3.108.0/docs/resources/cognitive_account

https://registry.terraform.io/providers/hashicorp/azurerm/3.108.0/docs/resources/cognitive_deployment

https://registry.terraform.io/providers/hashicorp/azurerm/3.108.0/docs/resources/monitor_diagnostic_setting

https://registry.terraform.io/providers/hashicorp/azurerm/3.108.0/docs/resources/private_endpoint

&nbsp;

# Terraform Import
There are a few things you need to do to import resources into .tfstate. In the example below there are resources which can be imported within the module. You may need to modify these commands to the OS on which they will be running (Refer to the [documentation](https://developer.hashicorp.com/terraform/cli/commands/import#example-import-into-resource-configured-with-for_each) for additional details).
### Cognitive Account
* terraform import '`<path-to-module>`.azurerm_cognitive_account.cognitive_account["`<cognitive-account-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.CognitiveServices/accounts/`<cognitive-account-name>`'
### Cognitive Deployment
* terraform import '`<path-to-module>`.azurerm_cognitive_deployment.cognitive_deployment["`<cognitive-account-name>`_`cognitive-deployment-name`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.CognitiveServices/accounts/`<cognitive-account-name>`/deployments/`<cognitive-deployment-name>`'
### Diagnostic Setting
* terraform import '`<path-to-module>`.azurerm_monitor_diagnostic_setting.diagnostic_setting["`<cognitive-account-name>`_`<diag-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.CognitiveServices/accounts/`<cognitive-account-name>`|`<diag-name>`'
 ### Private Endpoint
* terraform import '`<path-to-module>`.module.private_endpoint.azurerm_private_endpoint.private_endpoint["`<private-endpoint-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Network/privateEndpoints/`<private-endpoint-name>`'

 > **_NOTE:_** `<path-to-module>` is terraform logical path from root. e.g. _module.cognitive\_account_

&nbsp;

# Outputs
## Structure

| Output Name | Value        | Comment                                              |
| ----------- | ------------ | ---------------------------------------------------- |
| outputs     | name         |                                                      |
|             | id           |                                                      |
|             | principal_id | principal_id (object_id) of system assigned identity |
|             | deployment   | Cognitive Deployment resource outputs                |
|             | &nbsp;id     |                                                      |


## Example usage of outputs
In the example below, outputted _id_ of the deployed Congnitive Account module is used as a value for the _scope_ variable in Role Assignment resource.
```
module "cog" {
    source = "git@github.com:seyfor-csc/mit.cognitive-account.git?ref=v1.0.0"
    config = [
        {
            name                = "SEY-TERRAFORM-NE-COG01"
            location            = "northeurope"
            resource_group_name = "SEY-TERRAFORM-NE-RG01"
            kind                = "FormRecognizer"
            sku_name            = "F0"
        }
    ]
}

data "azurerm_client_config" "azurerm_client_config" {
}

resource "azurerm_role_assignment" "role_assignment" {
    scope                = module.cog.outputs.sey-terraform-ne-cog01.id # This is how to use output values
    role_definition_name = "Contributor"
    principal_id         = data.azurerm_client_config.azurerm_client_config.object_id
}
```

&nbsp;

# Module Features
No special features in module.

&nbsp;

# Known Issues
## Diagnostic Setting enabled log can't be deleted
### GitHub issue
https://github.com/hashicorp/terraform-provider-azurerm/issues/23267
### Possible workarounds: 
1. Disable the log manually in Azure Portal and then reflect the change in your Terraform configuration.
2. Delete the whole diagnostic setting and deploy it again with your desired configuration.
