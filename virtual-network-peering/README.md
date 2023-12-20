# Introduction
VNet Peering module can deploy these resources:
* azurerm_virtual_network_peering (required)

Example variables structure is located in [variables.md](variables.md).

Example use case is located in [test-case/locals.tf](test-case/locals.tf).

You can also see [changelog](changelog.md).

Terraform documentation:

https://registry.terraform.io/providers/hashicorp/azurerm/3.84.0/docs/resources/virtual_network_peering

&nbsp;

# Terraform Import
There are a few things you need to do to import resources into .tfstate. In the example below there are resources which can be imported within the module. You may need to modify these commands to the OS on which they will be running (Refer to the [documentation](https://developer.hashicorp.com/terraform/cli/commands/import#example-import-into-resource-configured-with-for_each) for additional details).
### VNet Peering
* terraform import '`<path-to-module>`.azurerm_virtual_network_peering.virtual_network_peering["`<vnet-name>`_`<peering-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Network/virtualNetworks/`<vnet-name>`/virtualNetworkPeerings/`<peering-name>`'

 > **_NOTE:_** `<path-to-module>` is terraform logical path from root. e.g. _module.vnet\_peering_

&nbsp;

# Outputs
## Structure

| Output Name | Value | Comment |
| ----------- | ----- | ------- |
| outputs     | name  |         |
|             | id    |         |

&nbsp;

# Module Features
## Custom variables
Virtual Network Peering module contains 3 custom variables - `hub_hub`, `hub_spoke` and `spoke_hub`. These variables automatically use and combine Terraform variables `allow_virtual_network_access`, `allow_forwarded_traffic`, `allow_gateway_transit` and `use_remote_gateways`. Set value of one of these custom variables to _true_ to create a combination of Terraform variables as shown in the table bellow. If you just want to use Terraform variables, don't set any of these custom variables. Go to [test-case/locals.tf](test-case/locals.tf) to see how to use this.

This table shows which Terraform variables are used for each custom variable:

| Custom Variable | Terraform Variable                                                           |
| --------------- | ---------------------------------------------------------------------------- |
| hub_hub         | allow_virtual_network_access, allow_forwarded_traffic, allow_gateway_transit |
| hub_spoke       | allow_virtual_network_access, allow_gateway_transit                          |
| spoke_hub       | allow_virtual_network_access, allow_forwarded_traffic, allow_gateway_transit |


&nbsp;

# Known Issues
We currently log no issues in this module.