# Introduction
Route Table module can deploy these resources:
* azurerm_route_table (required)
* azurerm_route (optional)

Example variables structure is located in [variables.md](variables.md).

Example use case is located in [test-case/locals.tf](test-case/locals.tf).

You can also see [changelog](CHANGELOG.md).

Terraform documentation:

https://registry.terraform.io/providers/hashicorp/azurerm/4.56.0/docs/resources/route_table

https://registry.terraform.io/providers/hashicorp/azurerm/4.56.0/docs/resources/route

&nbsp;

> **WARNING:** AzureRM provider had been updated to a new major version. Many breaking changes were implemented. See the [providers guide](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/4.0-upgrade-guide) for more information.

# Terraform Import
There are a few things you need to do to import resources into .tfstate. In the example below there are resources which can be imported within the module. You may need to modify these commands to the OS on which they will be running (Refer to the [documentation](https://developer.hashicorp.com/terraform/cli/commands/import#example-import-into-resource-configured-with-for_each) for additional details).
### Route Table
* terraform import '`<path-to-module>`.azurerm_route_table.route_table["`<route-table-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Network/routeTables/`<route-table-name>`'
### Route
* terraform import '`<path-to-module>`.azurerm_route.route["`<route-table-name>`_`<route-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Network/routeTables/`<route-table-name>`/routes/`<route-name>`'

 > **_NOTE:_** `<path-to-module>` is terraform logical path from root. e.g. _module.route\_table_

&nbsp;

# Outputs
## Structure

| Output Name | Value      | Comment       |
| ----------- | ---------- | ------------- |
| outputs     | name       |               |
|             | id         |               |
|             | routes     | Route outputs |
|             | &nbsp;name |               |
|             | &nbsp;id   |               |


## Example usage of outputs
In the example below, outputted _id_ of the deployed Route Table module is used as a value for the _scope_ variable in Role Assignment resource.
```
module "rt" {
    source = "git@github.com:Seyfor-CSC/mit.route-table.git?ref=v1.0.0"
    config = [
        {
            name                = "SEY-TERRAFORM-NE-RT01"
            location            = "northeurope"
            resource_group_name = "SEY-TERRAFORM-NE-RG01"
        }
    ]
}

data "azurerm_client_config" "azurerm_client_config" {
}

resource "azurerm_role_assignment" "role_assignment" {
    scope                = module.rt.outputs.sey-terraform-ne-rt01.id # This is how to use output values
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