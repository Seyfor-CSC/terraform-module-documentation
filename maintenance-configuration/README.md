# Introduction
Maintenance Configuration module can deploy these resources:
* azurerm_maintenance_configuration (required)

Example variables structure is located in [variables.md](variables.md).

Example use case is located in [test-case/locals.tf](test-case/locals.tf).

You can also see [changelog](changelog.md).

Terraform documentation:

https://registry.terraform.io/providers/hashicorp/azurerm/4.33.0/docs/resources/maintenance_configuration

&nbsp;

# Terraform Import
There are a few things you need to do to import resources into .tfstate. In the example below there are resources which can be imported within the module. You may need to modify these commands to the OS on which they will be running (Refer to the [documentation](https://developer.hashicorp.com/terraform/cli/commands/import#example-import-into-resource-configured-with-for_each) for additional details).
### Maintenance Configuration
* terraform import '`<path-to-module>`.azurerm_maintenance_configuration.maintenance_configuration["`<maintenance-configuration-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Maintenance/maintenanceConfigurations/`<maintenance-configuration-name>`'

 > **_NOTE:_** `<path-to-module>` is terraform logical path from root. e.g. _module.maintenance\_configuration_

&nbsp;

# Outputs
## Structure

| Output Name | Value | Comment |
| ----------- | ----- | ------- |
| outputs     | id    |         |

## Example usage of outputs
In the example below, outputted _id_ of the deployed Maintenance Configuration module is used as a value for the _scope_ variable in Role Assignment resource.
```
module "mc" {
    source = "git@github.com:seyfor-csc/mit.maintenance-configuration.git?ref=v1.0.0"
    config = [
        {
            name                = "SEY-TERRAFORM-NE-MC01"
            location            = "northeurope"
            resource_group_name = "SEY-TERRAFORM-NE-RG01"
            scope               = "Extension"
        }
    ]
}

data "azurerm_client_config" "azurerm_client_config" {
}

resource "azurerm_role_assignment" "role_assignment" {
    scope                = module.mc.outputs.sey-terraform-ne-mc01.id # This is how to use output values
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