# Introduction
Data Collection Rule module can deploy these resources:
* azurerm_monitor_data_collection_rule (required)

Example variables structure is located in [variables.md](variables.md).

Example use case is located in [test-case/locals.tf](test-case/locals.tf).

You can also see [changelog](changelog.md).

Terraform documentation:

https://registry.terraform.io/providers/hashicorp/azurerm/3.84.0/docs/resources/monitor_data_collection_rule

&nbsp;

# Terraform Import
There are a few things you need to do to import resources into .tfstate. In the example below there are resources which can be imported within the module. You may need to modify these commands to the OS on which they will be running (Refer to the [documentation](https://developer.hashicorp.com/terraform/cli/commands/import#example-import-into-resource-configured-with-for_each) for additional details).
### Data Collection Rule
* terraform import '`<path-to-module>`.azurerm_monitor_data_collection_rule.monitor_data_collection_rule["`<data-collection-rule-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Insights/dataCollectionRules/`<data-collection-rule-name>`'

 > **_NOTE:_** `<path-to-module>` is terraform logical path from root. e.g. _module.data\_collection\_rule_

&nbsp;

# Outputs
## Structure

| Output Name | Value        | Comment                                              |
| ----------- | ------------ | ---------------------------------------------------- |
| outputs     | name         |                                                      |
|             | id           |                                                      |
|             | principal_id | principal_id (object_id) of system assigned identity |


## Example usage of outputs
In the example below, outputted _id_ of the deployed Data Collection Rule module is used as a value for the _scope_ variable in Role Assignment resource.
```
module "dcr" {
    source = "git@github.com:Seyfor-CSC/mit.data-collection-rule.git?ref=v1.0.0"
    config = [
        {
            name                = "SEY-TERRAFORM-NE-DCR01"
            location            = "northeurope"
            resource_group_name = "SEY-TERRAFORM-NE-RG01"
            data_flow = [
                {
                    streams      = ["Microsoft-InsightsMetrics", "Microsoft-Syslog", "Microsoft-Perf"]
                    destinations = [azurerm_log_analytics_workspace.la.name]
                }
            ]
        }
    ]
}

data "azurerm_client_config" "azurerm_client_config" {
}

resource "azurerm_role_assignment" "role_assignment" {
    scope                = module.dcr.outputs.sey-terraform-ne-dcr01.id # This is how to use output values
    role_definition_name = "Contributor"
    principal_id         = data.azurerm_client_config.azurerm_client_config.object_id

    depends_on = [
        module.dcr
    ]
}
```

&nbsp;

# Module Features
No special features in module.

&nbsp;

# Known Issues
We currently log no issues in this module.