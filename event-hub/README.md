# Introduction
Event Hub module can deploy these resources:
* azurerm_eventhub_namespace (required)
* azurerm_eventhub (optional)
* azurerm_eventhub_consumer_group (optional)
* azurerm_eventhub_authorization_rule (optional)
* azurerm_monitor_diagnostic_setting (optional)
* azurerm_private_endpoint (optional)

Example variables structure is located in [variables.md](variables.md).

Example use case is located in [test-case/locals.tf](test-case/locals.tf).

You can also see [changelog](CHANGELOG.md).

Terraform documentation:

https://registry.terraform.io/providers/hashicorp/azurerm/4.33.0/docs/resources/eventhub_namespace

https://registry.terraform.io/providers/hashicorp/azurerm/4.33.0/docs/resources/eventhub

https://registry.terraform.io/providers/hashicorp/azurerm/4.33.0/docs/resources/eventhub_consumer_group

https://registry.terraform.io/providers/hashicorp/azurerm/4.33.0/docs/resources/eventhub_authorization_rule

https://registry.terraform.io/providers/hashicorp/azurerm/4.33.0/docs/resources/monitor_diagnostic_setting

https://registry.terraform.io/providers/hashicorp/azurerm/4.33.0/docs/resources/private_endpoint

&nbsp;

> **WARNING:** AzureRM provider had been updated to a new major version. Many breaking changes were implemented. See the [providers guide](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/4.0-upgrade-guide) for more information.

# Terraform Import
There are a few things you need to do to import resources into .tfstate. In the example below there are resources which can be imported within the module. You may need to modify these commands to the OS on which they will be running (Refer to the [documentation](https://developer.hashicorp.com/terraform/cli/commands/import#example-import-into-resource-configured-with-for_each) for additional details).
### Event Hub Namespace
* terraform import '`<path-to-module>`.azurerm_eventhub_namespace.eventhub_namespace["`<eventhub-namespace-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.EventHub/namespaces/`<eventhub-namespace-name>`'
### Event Hub
* terraform import '`<path-to-module>`.azurerm_eventhub.eventhub["`<eventhub-namespace-name>`_`<eventhub-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.EventHub/namespaces/`<eventhub-namespace-name>`/eventhubs/`<eventhub-name>`'
### Event Hub Consumer Group
* terraform import '`<path-to-module>`.azurerm_eventhub_consumer_group.eventhub_consumer_group["`<eventhub-namespace-name>`\_`<eventhub-name>`\_`<consumger_group_name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.EventHub/namespaces/`<eventhub-namespace-name>`/eventhubs/`<eventhub-name>`/consumerGroups/`<consumger_group_name>`'
### Event Hub Authorization Rule
* terraform import '`<path-to-module>`.azurerm_eventhub_authorization_rule.eventhub_authorization_rule["`<eventhub-namespace-name>`\_`<eventhub-name>`\_`<eventhub-authorization-rule-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.EventHub/namespaces/`<eventhub-namespace-name>`/eventhubs/`<eventhub-name>`/authorizationRules/`<eventhub-authorization-rule-name>`'
### Diagnostic Setting
* terraform import '`<path-to-module>`.azurerm_monitor_diagnostic_setting.diagnostic_setting["`<eventhub-namespace-name>`_`<diag-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.EventHub/namespaces/`<eventhub-namespace-name>`|`<diag-name>`'
### Private Endpoint
* terraform import '`<path-to-module>`.module.private_endpoint.azurerm_private_endpoint.private_endpoint["`<private-endpoint-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Network/privateEndpoints/`<private-endpoint-name>`'

 > **_NOTE:_** `<path-to-module>` is terraform logical path from root. e.g. _module.event\_hub_

&nbsp;

# Outputs
## Structure

| Output Name | Value                 | Comment                                              |
| ----------- | --------------------- | ---------------------------------------------------- |
| outputs     | name                  |                                                      |
|             | id                    |                                                      |
|             | principal_id          | principal_id (object_id) of system assigned identity |
|             | authorization_rule_id | Event Hubs Namespace authorization rule id           |
|             | eventhubs             | Event Hubs outputs                                   |
|             | &nbsp;name            |                                                      |
|             | &nbsp;id              |                                                      |
|             | consumer_groups       | Consumer Group outputs                               |
|             | &nbsp;name            |                                                      |
|             | &nbsp;id              |                                                      |

## Example usage of outputs
In the example below, outputted _id_ of the deployed Event Hub module is used as a value for the _scope_ variable in Role Assignment resource.
```
module "evhns" {
    source = "git@github.com:seyfor-csc/mit.event-hub.git?ref=v1.0.0"
    config = [
        {
            name                = "SEY-TERRAFORM-NE-EVHNS01"
            location            = "northeurope"
            resource_group_name = "SEY-TERRAFORM-NE-RG01"
            sku                 = "Standard"
        }
    ]
}

data "azurerm_client_config" "azurerm_client_config" {
}

resource "azurerm_role_assignment" "role_assignment" {
    scope                = module.evhns.outputs.sey-terraform-ne-evhns01.id # This is how to use output values
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