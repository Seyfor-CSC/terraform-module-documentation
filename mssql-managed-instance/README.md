# Introduction
MSSQL Managed Instance module can deploy these resources:
* azurerm_mssql_managed_instance (required)
* azurerm_monitor_diagnostic_setting (optional)

Example variables structure is located in [variables.md](variables.md).

Example use case is located in [test-case/locals.tf](test-case/locals.tf).

You can also see [changelog](changelog.md).

Terraform documentation:

https://registry.terraform.io/providers/hashicorp/azurerm/3.84.0/docs/resources/mssql_managed_instance

https://registry.terraform.io/providers/hashicorp/azurerm/3.84.0/docs/resources/monitor_diagnostic_setting

&nbsp;

# Terraform Import
There are a few things you need to do to import resources into .tfstate. In the example below there are resources which can be imported within the module. You may need to modify these commands to the OS on which they will be running (Refer to the [documentation](https://developer.hashicorp.com/terraform/cli/commands/import#example-import-into-resource-configured-with-for_each) for additional details).
### MSSQL Managed Instance
* terraform import '`<path-to-module>`.azurerm_mssql_managed_instance.mssql_managed_instance["`<mssql-managed-instance-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Sql/managedInstances/`<mssql-managed-instance-name>`'
### Diagnostic Setting
* terraform import '`<path-to-module>`.azurerm_monitor_diagnostic_setting.diagnostic_setting["`<mssql-managed-instance-name>`_`<diag-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Sql/managedInstances/`<mssql-managed-instance-name>`|`<diag-name>`'

 > **_NOTE:_** `<path-to-module>` is terraform logical path from root. e.g. _module.mssql\_managed\_instance_

&nbsp;

# Outputs
## Structure

| Output Name | Value        | Comment                                              |
| ----------- | ------------ | ---------------------------------------------------- |
| outputs     | name         |                                                      |
|             | id           |                                                      |
|             | principal_id | principal_id (object_id) of system assigned identity |


## Example usage of outputs
In the example below, outputted _id_ of the deployed MSSQL Managed Instance module is used as a value for the _scope_ variable in Role Assignment resource.
```
module "mi" {
    source = "git@github.com:Seyfor-CSC/mit.mssql-managed-instance.git?ref=v1.0.0"
    config = [
        {
            name                         = "SEY-TERRAFORM-NE-MI01"
            location                     = "northeurope"
            resource_group_name          = "SEY-TERRAFORM-NE-RG01"
            administrator_login          = "useradmin"
            administrator_login_password = "Password1234"
            license_type                 = "LicenseIncluded"
            sku_name                     = "GP_Gen5"
            storage_size_in_gb           = 32
            subnet_id                    = azurerm_subnet.subnet.id
            vcores                       = 4
        }
    ]
}

data "azurerm_client_config" "azurerm_client_config" {
}

resource "azurerm_role_assignment" "role_assignment" {
    scope                = module.mi.outputs.sey-terraform-ne-mi01.id # This is how to use output values
    role_definition_name = "Contributor"
    principal_id         = data.azurerm_client_config.azurerm_client_config.object_id

    depends_on = [
        module.mi
    ]
}
```

&nbsp;

# Module Features
No special features in module.
## Lifecycle
This module has a lifecycle block set up like this:
```
lifecycle {
    ignore_changes = [
      administrator_login,
      administrator_login_password
    ]
  }
```

&nbsp;

# Known Issues
## Deployment duration
Deployment of Managed Instance takes several hours, usually between 3-5h.