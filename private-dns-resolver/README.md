# Introduction
Private DNS Resolver module can deploy these resources:
* azurerm_private_dns_resolver (required)
* azurerm_private_dns_resolver_inbound_endpoint (optional)
* azurerm_private_dns_resolver_outbound_endpoint (optional)
* azurerm_private_dns_resolver_dns_forwarding_ruleset (optional)
* azurerm_private_dns_resolver_forwarding_rule (optional)
* azurerm_private_dns_resolver_virtual_network_link (optional)

Example variables structure is located in [variables.md](variables.md).

Example use case is located in [test-case/locals.tf](test-case/locals.tf).

You can also see [changelog](changelog.md).

Terraform documentation:

https://registry.terraform.io/providers/hashicorp/azurerm/3.73.0/docs/resources/private_dns_resolver

https://registry.terraform.io/providers/hashicorp/azurerm/3.73.0/docs/resources/private_dns_resolver_inbound_endpoint

https://registry.terraform.io/providers/hashicorp/azurerm/3.73.0/docs/resources/private_dns_resolver_outbound_endpoint

https://registry.terraform.io/providers/hashicorp/azurerm/3.73.0/docs/resources/private_dns_resolver_dns_forwarding_ruleset

https://registry.terraform.io/providers/hashicorp/azurerm/3.73.0/docs/resources/private_dns_resolver_forwarding_rule

https://registry.terraform.io/providers/hashicorp/azurerm/3.73.0/docs/resources/private_dns_resolver_virtual_network_link

&nbsp;

# Terraform Import
There are a few things you need to do to import resources into .tfstate. In the example below there are resources which can be imported within the module. You may need to modify these commands to the OS on which they will be running (Refer to the [documentation](https://developer.hashicorp.com/terraform/cli/commands/import#example-import-into-resource-configured-with-for_each) for additional details).
### Private DNS Resolver
* terraform import '`<path-to-module>`.azurerm_private_dns_resolver.private_dns_resolver["`<private_dns_resolver-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Network/dnsResolvers/`<private_dns_resolver-name>`'
### Private DNS Resolver Inbound Endpoint
* terraform import '`<path-to-module>`.azurerm_private_dns_resolver_inbound_endpoint.private_dns_resolver_inbound_endpoint["`<private_dns_resolver-name>`_`<inbound-endpoint-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Network/dnsResolvers/`<private_dns_resolver-name>`/inboundEndpoints/`<inbound-endpoint-name>`'
### Private DNS Resolver Outbound Endpoint
* terraform import '`<path-to-module>`.azurerm_private_dns_resolver_outbound_endpoint.private_dns_resolver_outbound_endpoint["`<private_dns_resolver-name>`_`<outbound-endpoint-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Network/dnsResolvers/`<private_dns_resolver-name>`/outboundEndpoints/`<outbound-endpoint-name>`'
### Private DNS Resolver DNS Forwarding Ruleset
* terraform import '`<path-to-module>`.azurerm_private_dns_resolver_dns_forwarding_ruleset.private_dns_resolver_dns_forwarding_ruleset["`<private_dns_resolver-name>`_`<forwarding-ruleset-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Network/dnsForwardingRulesets/`<forwarding-ruleset-name>`'
### Private DNS Resolver Forwarding Rule
* terraform import '`<path-to-module>`..azurerm_private_dns_resolver_forwarding_rule.private_dns_resolver_forwarding_rule["`<private_dns_resolver-name>`_`<forwarding-ruleset-name>`_`<forwarding-rule-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Network/dnsForwardingRulesets/`<forwarding-ruleset-name>`/forwardingRules/`<forwarding-rule-name>`'
### Private DNS Resolver Virtual Network Link
* terraform import '`<path-to-module>`.azurerm_private_dns_resolver_virtual_network_link.private_dns_resolver_virtual_network_link["`<private_dns_resolver-name>`_`<forwarding-ruleset-name>`_`<virtual-network-link-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Network/dnsForwardingRulesets/`<forwarding-ruleset-name>`/virtualNetworkLinks/`<virtual-network-link-name>`'

 > **_NOTE:_** `<path-to-module>` is terraform logical path from root. e.g. _module.private\_dns\_resolver_

&nbsp;

# Outputs
## Structure

| Output Name | Value                  | Comment                    |
| ----------- | ---------------------- | -------------------------- |
| outputs     | name                   |                            |
|             | id                     |                            |
|             | inbound_endpoints      | Inbound Endpoints outputs  |
|             | &nbsp;name             |                            |
|             | &nbsp;id               |                            |
|             | outbound_endpoints     | Outbound Endpoints outputs |
|             | &nbsp;name             |                            |
|             | &nbsp;id               |                            |
|             | forwarding_ruleset     | Forwarding Ruleset outputs |
|             | &nbsp;name             |                            |
|             | &nbsp;id               |                            |
|             | &nbsp;forwarding_rules | Forwarding Rules outputs   |
|             | &nbsp;&nbsp;name       |                            |
|             | &nbsp;&nbsp;id         |                            |
|             | &nbsp;vnet_links       | VNet Links outputs         |
|             | &nbsp;&nbsp;name       |                            |
|             | &nbsp;&nbsp;id         |                            |

## Example usage of outputs
In the example below, outputted _id_ of the deployed Private DNS Resolver module is used as a value for the _scope_ variable in Role Assignment resource.
```
module "dnsres" {
    source = "git@github.com:Seyfor-CSC/mit.private-dns-resolver.git?ref=v1.0.0"
    config = [
        {
            name                = "SEY-TERRAFORM-NE-DNSRES01"
            location            = "northeurope"
            resource_group_name = "SEY-TERRAFORM-NE-RG01"
            virtual_network_id  = azurerm_virtual_network.example
        }
    ]
}

data "azurerm_client_config" "azurerm_client_config" {
}

resource "azurerm_role_assignment" "role_assignment" {
    scope                = module.dnsres.outputs.sey-terraform-ne-dnsres01.id # This is how to use output values
    role_definition_name = "Contributor"
    principal_id         = data.azurerm_client_config.azurerm_client_config.object_id

    depends_on = [
        module.dnsres
    ]
}
```

&nbsp;

# Module Features
## Forwarding Ruleset Outbound Endpoint IDs
`private_dns_resolver_outbound_endpoint_ids` variable in the `private_dns_resolver_dns_forwarding_rulesets` list of objects is supposed to be a list of Outbound Endpoint ids. However, in this module, you need to supply it with names of those Outbound Endpoints which you want to associate with the Forwarding Ruleset. It can only be names of Outbound Endpoints which are being created in the same module call as the Forwarding Ruleset. The module will then resolve those names to ids.

&nbsp;

# Known Issues
We currently log no issues in this module.