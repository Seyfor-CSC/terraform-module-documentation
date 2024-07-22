# Introduction
Virtual Network module can deploy these resources:
* azurerm_virtual_network (required)
* azurerm_subnet (required)
* azurerm_subnet_network_security_group_association (optional)
* azurerm_subnet_route_table_association (optional)
* azurerm_subnet_nat_gateway_association (optional)
* azurerm_monitor_diagnostic_setting (optional)

Example variables structure is located in [variables.md](variables.md).

Example use case is located in [test-case/locals.tf](test-case/locals.tf).

You can also see [changelog](CHANGELOG.md).

Terraform documentation:

https://registry.terraform.io/providers/hashicorp/azurerm/3.108.0/docs/resources/virtual_network

https://registry.terraform.io/providers/hashicorp/azurerm/3.108.0/docs/resources/subnet

https://registry.terraform.io/providers/hashicorp/azurerm/3.108.0/docs/resources/subnet_network_security_group_association

https://registry.terraform.io/providers/hashicorp/azurerm/3.108.0/docs/resources/subnet_route_table_association

https://registry.terraform.io/providers/hashicorp/azurerm/3.108.0/docs/resources/subnet_nat_gateway_association

https://registry.terraform.io/providers/hashicorp/azurerm/3.108.0/docs/resources/monitor_diagnostic_setting

&nbsp;

# Terraform Import
There are a few things you need to do to import resources into .tfstate. In the example below there are resources which can be imported within the module. You may need to modify these commands to the OS on which they will be running (Refer to the [documentation](https://developer.hashicorp.com/terraform/cli/commands/import#example-import-into-resource-configured-with-for_each) for additional details).
### Virtual Network
* terraform import '`<path-to-module>`.azurerm_virtual_network.virtual_network["`<vnet-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Network/virtualNetworks/`<vnet-name>`'
### Subnet
* terraform import '`<path-to-module>`.azurerm_subnet.subnet["`<vnet-name>`_`<subnet-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Network/virtualNetworks/`<vnet-name>`/subnets/`<subnet-name>`'
### Subnet Network Security Group Association
* terraform import '`<path-to-module>`.azurerm_subnet_network_security_group_association.subnet_network_security_group_association["`<vnet-name>`_`<subnet-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Network/virtualNetworks/`<vnet-name>`/subnets/`<subnet-name>`'
### Subnet Route Table Association
* terraform import '`<path-to-module>`.azurerm_subnet_route_table_association.subnet_route_table_association["`<vnet-name>`_`<subnet-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Network/virtualNetworks/`<vnet-name>`/subnets/`<subnet-name>`'
### Subnet NAT Gateway Association
* terraform import '`<path-to-module>`.azurerm_subnet_nat_gateway_association.subnet_nat_gateway_association["`<vnet-name>`_`<subnet-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Network/virtualNetworks/`<vnet-name>`/subnets/`<subnet-name>`'
### Diagnostic Setting
* terraform import '`<path-to-module>`.azurerm_monitor_diagnostic_setting.diagnostic_setting["`<vnet-name>`_`<diag-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Network/virtualNetworks/`<vnet-name>`|`<diag-name>`'

 > **_NOTE:_** `<path-to-module>` is terraform logical path from root. e.g. _module.virtual\_network_

&nbsp;

# Outputs
## Structure
### Virtual Network outputs

| Output Name | Value                  | Comment        |
| ----------- | ---------------------- | -------------- |
| outputs     | name                   |                |
|             | id                     |                |
|             | address_space          |                |
|             | subnets                | Subnet outputs |
|             | &nbsp;name             |                |
|             | &nbsp;id               |                |
|             | &nbsp;address_prefixes |                |
### Subnet only outputs

| Output Name | Value            | Comment |
| ----------- | ---------------- | ------- |
| outputs     | name             |         |
|             | id               |         |
|             | address_prefixes |         |


## Example usage of outputs
In the example below, outputted _id_ of the deployed Virtual Network module is used as a value for the _scope_ variable in Role Assignment resource.
```
data "azurerm_client_config" "azurerm_client_config" {
}

module "vnet" {
    source = "git@github.com:Seyfor-CSC/mit.virtual-network.git?ref=v1.0.0"
    config = [
        {
            name                = "SEY-TERRAFORM-NE-VNET01"
            location            = "northeurope"
            resource_group_name = "SEY-TERRAFORM-NE-RG01"
            address_space       = ["10.0.0.0/16"]

            subnets = [
                {
                    name           = "sey-terraform-ne-subnet-10.0.1.0-24"
                    address_prefix = "10.0.1.0/24"
                }
            ] 
        }
    ]
    subscription_id = data.azurerm_client_config.current.subscription_id
}

resource "azurerm_role_assignment" "role_assignment" {
    scope                = module.vnet.outputs.sey-terraform-ne-vnet01.subnets.sey-terraform-ne-subnet-10-0-1-0-24.id # This is how to use output values. Dots in subnet name are replaced with hyphens.
    role_definition_name = "Contributor"
    principal_id         = data.azurerm_client_config.azurerm_client_config.object_id
}
```

&nbsp;

# Module Features
## Subscription Id
When using the module, subscription_id variable needs to be configured in the module call (in the same place as source or the config variable). Set the value of this variable to the subscription id you will deploy this module into. Go to [test-case/main.tf](test-case/main.tf) to see how it should look like.
## Custom variables
You need to configure the `nsg_name`, `route_table_name`, or `nat_gateway_name` variables depending on which subnet associations you want to deploy. Values of these variables should be the names of the associated resources. Go to [test-case/locals.tf](test-case/locals.tf) to see how to deploy these resources.
Sometimes, the capital letters in resource IDs, like those for resource groups, can cause issues. To avoid this, use variables like `nsg_rg`, `route_table_rg`, or `nat_gateway_rg` along with `nsg_name`, `route_table_name`, or `nat_gateway_name`. This way, you create the resource ID by mixing these variables. If you don't set the `*_rg` variables, the module defaults to using the subnet's resource group name. For examples on setting this up, check [test-case/locals.tf](test-case/locals.tf).
## Subnet outputs: replacement of dots with hyphens
It is common to have dots in the subnet name. However, dots are not allowed in the output names. Therefore, dots in subnet names are replaced with hyphens in the output names. For example, if you have subnet named `subnet-10.0.1.0-24` in your configuration, the output name will be `subnet-10-0-1-0-24`. Reference the Example usage of outputs (section above) to see how to use the subnet output.
## Subnet only deployment without Virtual Network
If you want to deploy a subnet without the virtual network, you can do so by setting the `subnets` variable instead of the `config` variable. You can't use one module call to deploy a `subnets` variable and a `config` variable at the same time. Each module call can only deploy one of these variables. Go to [test-case](test-case) to see how to deploy each scenario.

&nbsp;

# Known Issues
## Diagnostic Setting enabled log can't be deleted
### GitHub issue
https://github.com/hashicorp/terraform-provider-azurerm/issues/23267
### Possible workarounds: 
1. Disable the log manually in Azure Portal and then reflect the change in your Terraform configuration.
2. Delete the whole diagnostic setting and deploy it again with your desired configuration.
