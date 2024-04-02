# Introduction
Load Balancer module can deploy these resources:
* azurerm_lb (required)
* azurerm_lb_backend_address_pool (optional)
* azurerm_lb_backend_address_pool_address (optional)
* azurerm_network_interface_backend_address_pool_association (optional)
* azurerm_lb_outbound_rule (optional)
* azurerm_lb_probe (optional)
* azurerm_lb_rule (optional)
* azurerm_lb_nat_rule (optional)
* azurerm_lb_nat_pool (optional)
* azurerm_monitor_diagnostic_setting (optional)

Example variables structure is located in [variables.md](variables.md).

Example use case is located in [test-case/locals.tf](test-case/locals.tf).

You can also see [changelog](changelog.md).

Terraform documentation:

https://registry.terraform.io/providers/hashicorp/azurerm/3.96.0/docs/resources/lb

https://registry.terraform.io/providers/hashicorp/azurerm/3.96.0/docs/resources/lb_backend_address_pool

https://registry.terraform.io/providers/hashicorp/azurerm/3.96.0/docs/resources/lb_backend_address_pool_address

https://registry.terraform.io/providers/hashicorp/azurerm/3.96.0/docs/resources/network_interface_backend_address_pool_association

https://registry.terraform.io/providers/hashicorp/azurerm/3.96.0/docs/resources/lb_outbound_rule

https://registry.terraform.io/providers/hashicorp/azurerm/3.96.0/docs/resources/lb_probe

https://registry.terraform.io/providers/hashicorp/azurerm/3.96.0/docs/resources/lb_rule

https://registry.terraform.io/providers/hashicorp/azurerm/3.96.0/docs/resources/lb_nat_rule

https://registry.terraform.io/providers/hashicorp/azurerm/3.96.0/docs/resources/lb_nat_pool

https://registry.terraform.io/providers/hashicorp/azurerm/3.96.0/docs/resources/monitor_diagnostic_setting

&nbsp;

# Terraform Import
There are a few things you need to do to import resources into .tfstate. In the example below there are resources which can be imported within the module. You may need to modify these commands to the OS on which they will be running (Refer to the [documentation](https://developer.hashicorp.com/terraform/cli/commands/import#example-import-into-resource-configured-with-for_each) for additional details).
### Load Balancer
* terraform import '`<path-to-module>`.azurerm_lb.lb["`<lb-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Network/loadBalancers/`<lb-name>`'
### Load Balancer Backend Address Pool
* terraform import '`<path-to-module>`.azurerm_lb_backend_address_pool.lb_backend_address_pool["`<lb-name>`_`<lb-backend-address-pool-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Network/loadBalancers/`<lb-name>`/backendAddressPools/`<lb-backend-address-pool-name>`'
### Load Balancer Backend Address Pool Address
* terraform import '`<path-to-module>`.azurerm_lb_backend_address_pool_address.lb_backend_address_pool_address["`<lb-name>`_`<lb-backend-address-pool-address-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Network/loadBalancers/`<lb-name>`/backendAddressPools/`<lb-backend-address-pool-name>`/addresses/`<lb-backend-address-pool-address-name>`'
### Network Interface Backend Address Pool Association
* terraform import '`<path-to-module>`.azurerm_network_interface_backend_address_pool_association.network_interface_backend_address_pool_association["`<lb-name>`_`<network-interface-backend-address-pool-association-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Network/loadBalancers/`<lb-name>`/backendAddressPools/`<lb-backend-address-pool-name>`'
### Load Balancer Outbound Rule
* terraform import '`<path-to-module>`.azurerm_lb_outbound_rule.lb_outbound_rule["`<lb-name>`_`<lb-outbound-rule-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Network/loadBalancers/`<lb-name>`/outboundRules/`<lb-outbound-rule-name>`'
### Load Balancer Probe
* terraform import '`<path-to-module>`.azurerm_lb_probe.lb_probe["`<lb-name>`_`<lb-probe-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Network/loadBalancers/`<lb-name>`/probes/`<lb-probe-name>`'
### Load Balancer Rule
* terraform import '`<path-to-module>`.azurerm_lb_rule.lb_rule["`<lb-name>`_`<lb-rule-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Network/loadBalancers/`<lb-name>`/loadBalancingRules/`<lb-rule-name>`'
### Load Balancer NAT Rule
* terraform import '`<path-to-module>`.azurerm_lb_nat_rule.lb_nat_rule["`<lb-name>`_`<lb-nat-rule-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Network/loadBalancers/`<lb-name>`/inboundNatRules/`<lb-nat-rule-name>`'
### Load Balancer NAT Pool
* terraform import '`<path-to-module>`.azurerm_lb_nat_pool.lb_nat_pool["`<lb-name>`_`<lb-nat-pool-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Network/loadBalancers/`<lb-name>`/inboundNatPools/`<lb-nat-pool-name>`'
### Diagnostic Setting
* terraform import '`<path-to-module>`.azurerm_monitor_diagnostic_setting.diagnostic_setting["`<lb-name>`_`<diag-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Network/loadBalancers/`<lb-name>`|`<diag-name>`'

 > **_NOTE:_** `<path-to-module>` is terraform logical path from root. e.g. _module.load\_balancer_

&nbsp;

# Outputs
## Structure

| Output Name | Value         | Comment                      |
| ----------- | ------------- | ---------------------------- |
| outputs     | name          |                              |
|             | id            |                              |
|             | backend_pools | Backend Address Pool outputs |
|             | &nbsp;id      |                              |
|             | probes        | Probe outputs                |
|             | &nbsp;id      |                              |
|             | nat_rules     | NAT Rule outputs             |
|             | &nbsp;id      |                              |
|             | nat_pools     | NAT Pool outputs             |
|             | &nbsp;id      |                              |

## Example usage of outputs
In the example below, outputted _id_ of the deployed Load Balancer module is used as a value for the _scope_ variable in Role Assignment resource.
```
module "lb" {
    source = "git@github.com:Seyfor-CSC/mit.load-balancer.git?ref=v1.0.0"
    config = [
        {
            name                = "SEY-TERRAFORM-NE-LB01"
            location            = "northeurope"
            resource_group_name = "SEY-TERRAFORM-NE-RG01"
        }
    ]
}

data "azurerm_client_config" "azurerm_client_config" {
}

resource "azurerm_role_assignment" "role_assignment" {
    scope                = module.lb.outputs.sey-terraform-ne-lb01.id # This is how to use output values
    role_definition_name = "Contributor"
    principal_id         = data.azurerm_client_config.azurerm_client_config.object_id
}
```

&nbsp;

# Module Features
## Custom variables
* `backend_address_pool_names` replaces the `backend_address_pool_ids` variable in the `rules` list of objects.
* `backend_address_pool_name` replaces the `backend_address_pool_id` variable in the `nat_rules` list of objects.
* `probe_name` replaces the `probe_id` variable in the `rules` list of objects.
* `custom_name` used for looping through the `nic_association` list of objects.

&nbsp;

# Known Issues
## Diagnostic Setting enabled log can't be deleted
### GitHub issue
https://github.com/hashicorp/terraform-provider-azurerm/issues/23267
### Possible workarounds: 
1. Disable the log manually in Azure Portal and then reflect the change in your Terraform configuration.
2. Delete the whole diagnostic setting and deploy it again with your desired configuration.
