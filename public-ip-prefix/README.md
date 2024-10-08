# Introduction
Public IP Prefix module can deploy these resources:
* azurerm_public_ip_prefix (required)
* azurerm_monitor_diagnostic_setting (optional)

Example variables structure is located in [variables.md](variables.md).

Example use case is located in [test-case/locals.tf](test-case/locals.tf).

You can also see [changelog](CHANGELOG.md).

Terraform documentation:

https://registry.terraform.io/providers/hashicorp/azurerm/4.1.0/docs/resources/public_ip_prefix

https://registry.terraform.io/providers/hashicorp/azurerm/4.1.0/docs/resources/monitor_diagnostic_setting

&nbsp;

> **WARNING:** AzureRM provider had been updated to a new major version. Many breaking changes were implemented. See the [providers guide](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/4.0-upgrade-guide) for more information.

# Terraform Import
There are a few things you need to do to import resources into .tfstate. In the example below there are resources which can be imported within the module. You may need to modify these commands to the OS on which they will be running (Refer to the [documentation](https://developer.hashicorp.com/terraform/cli/commands/import#example-import-into-resource-configured-with-for_each) for additional details).
### Public IP Prefix
* terraform import '`<path-to-module>`.azurerm_public_ip_prefix.public_ip_prefix["`<public-ip-prefix-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Network/publicIPPrefixes/`<public-ip-prefix-name>`'
### Diagnostic Setting
* terraform import '`<path-to-module>`.azurerm_monitor_diagnostic_setting.diagnostic_setting["`<public-ip-prefix-name>`_`<diag-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Network/publicIPPrefixes/`<public-ip-prefix-name>`|`<diag-name>`'

 > **_NOTE:_** `<path-to-module>` is terraform logical path from root. e.g. _module.public\_ip\_prefix_

&nbsp;

# Outputs
## Structure

| Output Name | Value     | Comment                                         |
| ----------- | --------- | ----------------------------------------------- |
| outputs     | name      |                                                 |
|             | id        |                                                 |
|             | ip_prefix | IP address prefix value that has been allocated |


## Example usage of outputs
In the example below, outputted _id_ of the deployed Public IP Prefix module is used as a value for the _scope_ variable in Role Assignment resource.
```
module "pipp" {
    source = "git@github.com:Seyfor-CSC/mit.public-ip-prefix.git?ref=v1.0.0"
    config = [
        {
            name                = "SEY-TERRAFORM-NE-PIPP01"
            location            = "northeurope"
            resource_group_name = "SEY-TERRAFORM-NE-RG01"
        }
    ]
}

data "azurerm_client_config" "azurerm_client_config" {
}

resource "azurerm_role_assignment" "role_assignment" {
    scope                = module.pipp.outputs.sey-terraform-ne-pipp01.id # This is how to use output values
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