# Introduction
Data Factory module can deploy these resources:
* azurerm_data_factory (required)
* azurerm_monitor_diagnostic_setting (optional)
* azurerm_private_endpoint (optional)

Example variables structure is located in [variables.md](variables.md).

Example use case is located in [test-case/locals.tf](test-case/locals.tf).

You can also see [changelog](CHANGELOG.md).

Terraform documentation:

https://registry.terraform.io/providers/hashicorp/azurerm/3.108.0/docs/resources/data_factory

https://registry.terraform.io/providers/hashicorp/azurerm/3.108.0/docs/resources/monitor_diagnostic_setting

https://registry.terraform.io/providers/hashicorp/azurerm/3.108.0/docs/resources/private_endpoint

&nbsp;

# Terraform Import
There are a few things you need to do to import resources into .tfstate. In the example below there are resources which can be imported within the module. You may need to modify these commands to the OS on which they will be running (Refer to the [documentation](https://developer.hashicorp.com/terraform/cli/commands/import#example-import-into-resource-configured-with-for_each) for additional details).
### Data Factory
* terraform import '`<path-to-module>`.azurerm_data_factory.data_factory["`<data-factory-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.DataFactory/factories/`<data-factory-name>`'
### Diagnostic Setting
* terraform import '`<path-to-module>`.azurerm_monitor_diagnostic_setting.diagnostic_setting["`<data-factory-name>`_`<diag-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.DataFactory/factories/`<data-factory-name>`|`<diag-name>`'
 ### Private Endpoint
* terraform import '`<path-to-module>`.module.private_endpoint.azurerm_private_endpoint.private_endpoint["`<private-endpoint-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Network/privateEndpoints/`<private-endpoint-name>`'

 > **_NOTE:_** `<path-to-module>` is terraform logical path from root. e.g. _module.data\_factory_

&nbsp;

# Outputs
## Structure

| Output Name | Value        | Comment                                              |
| ----------- | ------------ | ---------------------------------------------------- |
| outputs     | name         |                                                      |
|             | id           |                                                      |
|             | principal_id | principal_id (object_id) of system assigned identity |


## Example usage of outputs
In the example below, outputted _id_ of the deployed Data Factory module is used as a value for the _scope_ variable in Role Assignment resource.
```
module "df" {
    source = "git@github.com:Seyfor-CSC/mit.data-factory.git?ref=v1.0.0"
    config = [
        {
            name                = "SEY-TERRAFORM-NE-DF01"
            location            = "northeurope"
            resource_group_name = "SEY-TERRAFORM-NE-RG01"
        }
    ]
}

data "azurerm_client_config" "azurerm_client_config" {
}

resource "azurerm_role_assignment" "role_assignment" {
    scope                = module.df.outputs.sey-terraform-ne-df01.id # This is how to use output values
    role_definition_name = "Contributor"
    principal_id         = data.azurerm_client_config.azurerm_client_config.object_id
}
```

&nbsp;

# Module Features
## Lifecycle
This module has a lifecycle block set up like this:
```
lifecycle {
    ignore_changes = [
        global_parameter,
        vsts_configuration,
        github_configuration
    ]
}
```

&nbsp;

# Known Issues
## Diagnostic Setting enabled log can't be deleted
### GitHub issue
https://github.com/hashicorp/terraform-provider-azurerm/issues/23267
### Possible workarounds: 
1. Disable the log manually in Azure Portal and then reflect the change in your Terraform configuration.
2. Delete the whole diagnostic setting and deploy it again with your desired configuration.
