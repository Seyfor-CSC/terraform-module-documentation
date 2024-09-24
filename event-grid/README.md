# Introduction
Event Grid module can deploy these resources:
* azurerm_eventgrid_system_topic (optional)
* azurerm_monitor_diagnostic_setting (optional)

Example variables structure is located in [variables.md](variables.md).

Example use case is located in [test-case/locals.tf](test-case/locals.tf).

You can also see [changelog](CHANGELOG.md).

Terraform documentation:

https://registry.terraform.io/providers/hashicorp/azurerm/3.108.0/docs/resources/eventgrid_system_topic

https://registry.terraform.io/providers/hashicorp/azurerm/3.108.0/docs/resources/monitor_diagnostic_setting

&nbsp;

# Terraform Import
There are a few things you need to do to import resources into .tfstate. In the example below there are resources which can be imported within the module. You may need to modify these commands to the OS on which they will be running (Refer to the [documentation](https://developer.hashicorp.com/terraform/cli/commands/import#example-import-into-resource-configured-with-for_each) for additional details).
### Event Grid System Topic
terraform import '`<path-to-module>`.azurerm_eventgrid_system_topic.eventgrid_system_topic["`<eventgrid-system-topic-name>`"] /subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.EventGrid/systemTopics/`<eventgrid-system-topic-name>`'

### Diagnostic Setting
* terraform import '`<path-to-module>`.azurerm_monitor_diagnostic_setting.diagnostic_setting["`<eventgrid-system-topic-name>`_`<diag-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.EventGrid/systemTopics/`<eventgrid-system-topic-name>`|`<diag-name>`'

 > **_NOTE:_** `<path-to-module>` is terraform logical path from root. e.g. _module.event_grid_

&nbsp;

# Outputs
## Structure

| Output Name | Value              | Comment                                              |
| ----------- | ------------------ | ---------------------------------------------------- |
| outputs     | system_topic       | Event Grid System Topic outputs                      |
|             | &nbsp;name         |                                                      |
|             | &nbsp;id           |                                                      |
|             | &nbsp;principal_id | principal_id (object_id) of system assigned identity |

## Example usage of outputs
In the example below, outputted _id_ of the deployed Event Grid module is used as a value for the _scope_ variable in Role Assignment resource.
```
module "eg" {
    source = "git@github.com:seyfor-csc/mit.event-grid.git?ref=v1.0.0"
    config = {
    system_topic = [
      {
        name                   = "seyterraformne01"
        resource_group_name    = "SEY-TERRAFORM-NE-RG01"
        location               = "northeurope"
        source_arm_resource_id = azurerm_storage_account.sa.id
        topic_type             = "Microsoft.Storage.StorageAccounts"
      }
    ]
  }
}

data "azurerm_client_config" "azurerm_client_config" {
}

resource "azurerm_role_assignment" "role_assignment" {
    scope                = module.eg.outputs.system_topic.seyterraformne001.id # This is how to use output values
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
