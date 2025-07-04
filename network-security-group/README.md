# Introduction
Network Security Group module can deploy these resources:
* azurerm_network_security_group (required)
* azurerm_network_security_rule (optional)
* azurerm_monitor_diagnostic_setting (optional)

Example variables structure is located in [variables.md](variables.md).

Example use case is located in [test-case/locals.tf](test-case/locals.tf).

You can also see [changelog](CHANGELOG.md).

Terraform documentation:

https://registry.terraform.io/providers/hashicorp/azurerm/4.33.0/docs/resources/network_security_group

https://registry.terraform.io/providers/hashicorp/azurerm/4.33.0/docs/resources/network_security_rule

https://registry.terraform.io/providers/hashicorp/azurerm/4.33.0/docs/resources/monitor_diagnostic_setting

&nbsp;

> **WARNING:** AzureRM provider had been updated to a new major version. Many breaking changes were implemented. See the [providers guide](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/4.0-upgrade-guide) for more information.

# Terraform Import
There are a few things you need to do to import resources into .tfstate. In the example below there are resources which can be imported within the module. You may need to modify these commands to the OS on which they will be running (Refer to the [documentation](https://developer.hashicorp.com/terraform/cli/commands/import#example-import-into-resource-configured-with-for_each) for additional details).
### Network Security Group
* terraform import '`<path-to-module>`.azurerm_network_security_group.network_security_group["`<nsg-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Network/networkSecurityGroups/`<nsg-name>`'
### Rules
* terraform import '`<path-to-module>`.azurerm_network_security_rule.network_security_rule["`<nsg-name>`_`<nsg-rule-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Network/networkSecurityGroups/`<nsg-name>`/securityRules/`<nsg-rule-name>`'
### Diagnostic Setting
* terraform import '`<path-to-module>`.azurerm_monitor_diagnostic_setting.diagnostic_setting["`<nsg-name>`_`<diag-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Network/networkSecurityGroups/`<nsg-name>`|`<diag-name>`'

 > **_NOTE:_** `<path-to-module>` is terraform logical path from root. e.g. _module.network\_security\_group_

&nbsp;

# Outputs
## Structure

| Output Name | Value            | Comment                       |
| ----------- | ---------------- | ----------------------------- |
| outputs     | name             |                               |
|             | id               |                               |
|             | nsg_rule         | Network Security Rule outputs |
|             | &nbsp;&nbsp;name |                               |
|             | &nbsp;&nbsp;id   |                               |


## Example usage of outputs
In the example below, outputted _id_ of the deployed Network Security Group module is used as a value for the _scope_ variable in Role Assignment resource.
```
module "nsg" {
    source = "git@github.com:Seyfor-CSC/mit.network-security-group.git?ref=v1.0.0"
    config = [
        {
            name                = "SEY-TERRAFORM-NE-NSG01"
            location            = "northeurope"
            resource_group_name = "SEY-TERRAFORM-NE-RG01"
        }
    ]
}

data "azurerm_client_config" "azurerm_client_config" {
}

resource "azurerm_role_assignment" "role_assignment" {
    scope                = module.nsg.outputs.sey-terraform-ne-nsg01.id # This is how to use output values
    role_definition_name = "Contributor"
    principal_id         = data.azurerm_client_config.azurerm_client_config.object_id
}
```

&nbsp;

# Module Features
## Monitoring tags in `ignore_changes` lifecycle block
We reserve the right to include tags dedicated to our product Advanced Monitoring in the `ignore_changes` lifecycle block. This is to prevent the module from deleting those tags. The tags we ignore are: `tags["Platform"]`, `tags["MonitoringTier"]`.

&nbsp;

# Known Issues
We currently log no issues in this module.