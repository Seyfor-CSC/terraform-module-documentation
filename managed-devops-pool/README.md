# Introduction
Managed DevOps Pool module can deploy these resources:
* azurerm_managed_devops_pool (required)
* azurerm_monitor_diagnostic_setting (optional)

Example variables structure is located in [variables.md](variables.md).

Example use case is located in [test-case/locals.tf](test-case/locals.tf).

You can also see [changelog](CHANGELOG.md).

Terraform documentation:

https://registry.terraform.io/providers/hashicorp/azurerm/4.70.0/docs/resources/managed_devops_pool

https://registry.terraform.io/providers/hashicorp/azurerm/4.70.0/docs/resources/monitor_diagnostic_setting

&nbsp;

# Terraform Import
There are a few things you need to do to import resources into .tfstate. In the example below there are resources which can be imported within the module. You may need to modify these commands to the OS on which they will be running (Refer to the [documentation](https://developer.hashicorp.com/terraform/cli/commands/import#example-import-into-resource-configured-with-for_each) for additional details).

### Managed DevOps Pool
* terraform import '`<path-to-module>`.azurerm_managed_devops_pool.managed_devops_pool["`<pool-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.DevOpsInfrastructure/pools/`<pool-name>`'

### Diagnostic Setting
* terraform import '`<path-to-module>`.azurerm_monitor_diagnostic_setting.diagnostic_setting["`<pool-name>`_`<diag-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.DevOpsInfrastructure/pools/`<pool-name>`|`<diag-name>`'

> **_NOTE:_** `<path-to-module>` is terraform logical path from root. e.g. _module.managed\_devops\_pool_

&nbsp;

# Outputs
## Structure

| Output Name | Value | Comment |
| ----------- | ----- | ------- |
| outputs     | name  |         |
|             | id    |         |

## Example usage of outputs
In the example below, outputted _id_ of the deployed Managed DevOps Pool module is used as a value for the _scope_ variable in Role Assignment resource.
```
module "managed_devops_pool" {
    source = "git@github.com:seyfor-csc/mit.managed-devops-pool.git?ref=v1.0.0"
    config = [
        {
            name                  = "SEY-TERRAFORM-NE-MDP01"
            location              = "northeurope"
            resource_group_name   = "SEY-MDP-NE-RG01"
            dev_center_project_id = azurerm_dev_center_project.example.id
            maximum_concurrency   = 1
            azure_devops_organization = {
                organization = [
                    {
                        parallelism = 1
                        url         = "https://dev.azure.com/my-organization"
                    }
                ]
            }
            virtual_machine_scale_set_fabric = {
                sku_name = "Standard_D2ads_v5"
                image = [
                    {
                        well_known_image_name = "ubuntu-24.04/latest"
                    }
                ]
            }
            stateless_agent = {}
        }
    ]
}

data "azurerm_client_config" "azurerm_client_config" {
}

resource "azurerm_role_assignment" "role_assignment" {
    scope                = module.managed_devops_pool.outputs["sey-terraform-ne-mdp01"].id # This is how to use output values
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
