# Introduction
Bastion Host module can deploy these resources:
* azurerm_bastion_host (required)
* azurerm_monitor_diagnostic_setting (optional)

Example variables structure is located in [variables.md](variables.md).

Example use case is located in [test-case/locals.tf](test-case/locals.tf).

You can also see [changelog](changelog.md).

Terraform documentation: 

https://registry.terraform.io/providers/hashicorp/azurerm/3.84.0/docs/resources/bastion_host

https://registry.terraform.io/providers/hashicorp/azurerm/3.84.0/docs/resources/monitor_diagnostic_setting

&nbsp;

# Terraform Import
There are a few things you need to do to import resources into .tfstate. In the example below there are resources which can be imported within the module. You may need to modify these commands to the OS on which they will be running (Refer to the [documentation](https://developer.hashicorp.com/terraform/cli/commands/import#example-import-into-resource-configured-with-for_each) for additional details).
### Bastion host
* terraform import '`<path-to-module>`.azurerm_bastion_host.bastion_host["`<bastion-host-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Network/bastionHosts/`<bastion-host-name>`'
### Diagnostic Setting
* terraform import '`<path-to-module>`.azurerm_monitor_diagnostic_setting.diagnostic_setting["`<bastion-host-name>>`_`<diag-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Network/bastionHosts/`<bastion-host-name>`|`<diag-name>`'

 > **_NOTE:_** `<path-to-module>` is terraform logical path from root. e.g. _module.bastion\_host_

&nbsp;

# Outputs
## Structure

| Output Name | Value        | Comment                                              |
| ----------- | ------------ | ---------------------------------------------------- |
| outputs     | name         |                                                      |
|             | id           |                                                      |


## Example usage of outputs
In the example below, outputted _id_ of the deployed Bastion Host module is used as a value for the _scope_ variable in Role Assignment resource.
```
module "bh" {
    source = "git@github.com:seyfor-csc/mit.bastion-host.git?ref=v1.0.0"
    config = [
        {
            name                = "SEY-TERRAFORM-NE-BH01"
            location            = "northeurope"
            resource_group_name = "SEY-TERRAFORM-NE-RG01"
            ip_configuration = {
                name                 = "ipconfig"
                subnet_id            = azurerm_subnet.subnet.id
                public_ip_address_id = azurerm_public_ip.pip.id
            }
        }
    ]
}

data "azurerm_client_config" "azurerm_client_config" {
}

resource "azurerm_role_assignment" "role_assignment" {
    scope                = module.bh.outputs.sey-terraform-ne-bh01.id # This is how to use output values
    role_definition_name = "Contributor"
    principal_id         = data.azurerm_client_config.azurerm_client_config.object_id

    depends_on = [
        module.bh
    ]
}
```

&nbsp;

# Module Features
## Diagnostic Setting enabled log can't be deleted
### GitHub issue
https://github.com/hashicorp/terraform-provider-azurerm/issues/23267
### Possible workarounds: 
1. Disable the log manually in Azure Portal and then reflect the change in your Terraform configuration.
2. Delete the whole diagnostic setting and deploy it again with your desired configuration.

&nbsp;

# Known Issues
We currently log no issues in this module.