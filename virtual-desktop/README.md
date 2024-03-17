# Introduction
Virtual desktop module can deploy these resources:
* azurerm_virtual_desktop_host_pool (optional)
* azurerm_virtual_desktop_application_group (optional)
* azurerm_virtual_desktop_host_pool_registration_info (optional)
* azurerm_virtual_desktop_scaling_plan (optional)
* azurerm_virtual_desktop_workspace (optional)
* azurerm_virtual_desktop_workspace_application_group_association (optional)
* azurerm_monitor_diagnostic_setting (optional)
* azurerm_private_endpoint (optional)
> **_NOTE:_** At least one of _azurerm_virtual_desktop_host_pool_, _azurerm_virtual_desktop_scaling_plan_, or _azurerm_virtual_desktop_workspace_ needs to be specified in module configuration

Example variables structure is located in [variables.md](variables.md).

Example use case is located in [test-case/locals.tf](test-case/locals.tf).

You can also see [changelog](changelog.md).

Terraform documentation:

https://registry.terraform.io/providers/hashicorp/azurerm/3.84.0/docs/resources/virtual_desktop_host_pool

https://registry.terraform.io/providers/hashicorp/azurerm/3.84.0/docs/resources/virtual_desktop_application_group

https://registry.terraform.io/providers/hashicorp/azurerm/3.84.0/docs/resources/virtual_desktop_host_pool_registration_info

https://registry.terraform.io/providers/hashicorp/azurerm/3.84.0/docs/resources/virtual_desktop_scaling_plan

https://registry.terraform.io/providers/hashicorp/azurerm/3.84.0/docs/resources/virtual_desktop_workspace

https://registry.terraform.io/providers/hashicorp/azurerm/3.84.0/docs/resources/virtual_desktop_workspace_application_group_association

https://registry.terraform.io/providers/hashicorp/azurerm/3.84.0/docs/resources/monitor_diagnostic_setting

https://registry.terraform.io/providers/hashicorp/azurerm/3.84.0/docs/resources/private_endpoint

&nbsp;

# Terraform Import
There are a few things you need to do to import resources into .tfstate. In the example below there are resources which can be imported within the module. You may need to modify these commands to the OS on which they will be running (Refer to the [documentation](https://developer.hashicorp.com/terraform/cli/commands/import#example-import-into-resource-configured-with-for_each) for additional details).
### Host Pool
* terraform import '`<path-to-module>`.azurerm_virtual_desktop_host_pool.virtual_desktop_host_pool["`<host-pool-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.DesktopVirtualization/hostPools/`<host-pool-name>`'
### Application Group
* terraform import '`<path-to-module>`.azurerm_virtual_desktop_application_group.virtual_desktop_application_group["`<host-pool-name>`_`<application-group-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.DesktopVirtualization/applicationGroups/`<application-group-name>`'
### Host Pool Registration Info
* terraform import '`<path-to-module>`.azurerm_virtual_desktop_host_pool_registration_info.virtual_desktop_host_pool_registration_info["`<host-pool-name>`_`<registration-expiration-date>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.DesktopVirtualization/hostPools/`<host-pool-name>`/registrationInfo/default'
### Scaling Plan
* terraform import '`<path-to-module>`.azurerm_virtual_desktop_scaling_plan.virtual_desktop_scaling_plan["`<scaling-plan-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.DesktopVirtualization/scalingPlans/`<scaling-plan-name>`'
### Workspace
* terraform import '`<path-to-module>`.azurerm_virtual_desktop_workspace.virtual_desktop_workspace["`<workspace-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.DesktopVirtualization/workspaces/`<workspace-name>`'
### Workspace Application Group Association
* terraform import '`<path-to-module>`.azurerm_virtual_desktop_workspace_application_group_association.virtual_desktop_workspace_application_group_association["`<workspace-name>`_`<application-group-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.DesktopVirtualization/workspaces/`<workspace-name>`|/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.DesktopVirtualization/applicationGroups/`<application-group-name>`'
### Diagnostic Setting
#### Host Pool
* terraform import '`<path-to-module>`.azurerm_monitor_diagnostic_setting.host_pool["`<host-pool-name>`_`<diag-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.DesktopVirtualization/hostPools/`<host-pool-name>`|`<diag-name>`'
#### Application Group
* terraform import '`<path-to-module>`.azurerm_monitor_diagnostic_setting.application_group["`<host-pool-name>`\_`<application-group-name>`\_`<diag-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.DesktopVirtualization/applicationGroups/`<application-group-name>`|`<diag-name>`'
#### Scaling Plan
* terraform import '`<path-to-module>`.azurerm_monitor_diagnostic_setting.scaling_plan["`<scaling-plan-name>`_`<diag-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.DesktopVirtualization/scalingPlans/`<scaling-plan-name>`|`<diag-name>`'
#### Workspace
* terraform import '`<path-to-module>`.azurerm_monitor_diagnostic_setting.workspace["`<workspace-name>`_`<diag-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.DesktopVirtualization/workspaces/`<workspace-name>`|`<diag-name>`'
 ### Private Endpoint
* terraform import '`<path-to-module>`.module.private_endpoint.azurerm_private_endpoint.private_endpoint["`<private-endpoint-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Network/privateEndpoints/`<private-endpoint-name>`'

 > **_NOTE:_** `<path-to-module>` is terraform logical path from root. e.g. _module.virtual\_desktop_

&nbsp;

# Outputs
## Structure

| Output Name | Value                    | Comment                   |
| ----------- | ------------------------ | ------------------------- |
| outputs     | host_pools               | Host Pool outputs         |
|             | &nbsp;name               |                           |
|             | &nbsp;id                 |                           |
|             | &nbsp;reqistration_token | Registration Info token   |
|             | &nbsp;application_groups | Application Group outputs |
|             | &nbsp;&nbsp;name         |                           |
|             | &nbsp;&nbsp;id           |                           |
|             | scaling_plans            | Scaling Plan outputs      |
|             | &nbsp;name               |                           |
|             | &nbsp;id                 |                           |
|             | workspaces               | Workspace outputs         |
|             | &nbsp;name               |                           |
|             | &nbsp;id                 |                           |

## Example usage of outputs
In the example below, outputted _id_ of the deployed Virtual desktop module is used as a value for the _scope_ variable in Role Assignment resource.
```
module "vd" {
    source = "git@github.com:seyfor-csc/mit.virtual-desktop.git?ref=v1.0.0"
    config = {
        host_pools = [
            {
                name                = "SEY-TERRAFORM-NE-POOL01"
                location            = "northeurope"
                resource_group_name = "SEY-TERRAFORM-NE-RG01"
                type                = "Pooled"
                load_balancer_type  = "DepthFirst"
            }
        ]
    }
}

data "azurerm_client_config" "azurerm_client_config" {
}

resource "azurerm_role_assignment" "role_assignment" {
    scope                = module.vd.outputs.host_pools.sey-terraform-ne-pool01.id # This is how to use output values
    role_definition_name = "Contributor"
    principal_id         = data.azurerm_client_config.azurerm_client_config.object_id

    depends_on = [
        module.vd
    ]
}
```

&nbsp;

# Module Features
## Custom variables
* `workspace_name` replaces the `workspace_id` variable in the `associations` list of objects.
* `hostpool_name` replaces the `hostpool_id` variable in the `host_pool` list of objects.
## Diagnostic Setting enabled log can't be deleted
### GitHub issue
https://github.com/hashicorp/terraform-provider-azurerm/issues/23267
### Possible workarounds: 
1. Disable the log manually in Azure Portal and then reflect the change in your Terraform configuration.
2. Delete the whole diagnostic setting and deploy it again with your desired configuration.

&nbsp;

# Known Issues
We currently log no issues in this module.
