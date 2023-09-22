# Introduction
Virtual Machine Scale Set module can deploy these resources:
* azurerm_windows_virtual_machine_scale_set (optional)
* azurerm_linux_virtual_machine_scale_set (optional)
* azurerm_monitor_autoscale_setting (optional)
* azurerm_monitor_diagnostic_setting (optional)
> **_NOTE:_** At least one of the virtual machine scale sets needs to be specified in module configuration

Example variables structure is located in [variables.md](variables.md).

Example use case is located in [test-case/locals.tf](test-case/locals.tf).

You can also see [changelog](changelog.md).

Terraform documentation:

https://registry.terraform.io/providers/hashicorp/azurerm/3.73.0/docs/resources/windows_virtual_machine_scale_set

https://registry.terraform.io/providers/hashicorp/azurerm/3.73.0/docs/resources/linux_virtual_machine_scale_set

https://registry.terraform.io/providers/hashicorp/azurerm/3.73.0/docs/resources/monitor_autoscale_setting

https://registry.terraform.io/providers/hashicorp/azurerm/3.73.0/docs/resources/monitor_diagnostic_setting

&nbsp;

# Terraform Import
There are a few things you need to do to import resources into .tfstate. In the example below there are resources which can be imported within the module. You may need to modify these commands to the OS on which they will be running (Refer to the [documentation](https://developer.hashicorp.com/terraform/cli/commands/import#example-import-into-resource-configured-with-for_each) for additional details).
### Windows Virtual Machine Scale Set
* terraform import '`<path-to-module>`.azurerm_windows_virtual_machine_scale_set.windows_virtual_machine_scale_set["`<windows-virtual-machine-scale-set-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Compute/virtualMachineScaleSets/`<windows-virtual-machine-scale-set-name>`'
### Linux Virtual Machine Scale Set
* terraform import '`<path-to-module>`.azurerm_linux_virtual_machine_scale_set.linux_virtual_machine_scale_set["`<linux-virtual-machine-scale-set-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Compute/virtualMachineScaleSets/`<linux-virtual-machine-scale-set-name>`'
### Windows Virtual Machine Scale Set Autoscale
* terraform import '`<path-to-module>`.azurerm_windows_virtual_machine_scale_set.windows_virtual_machine_scale_set_autoscale["`<windows-virtual-machine-scale-set-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Compute/virtualMachineScaleSets/`<windows-virtual-machine-scale-set-name>`'
### Linux Virtual Machine Scale Set Autoscale
* terraform import '`<path-to-module>`.azurerm_linux_virtual_machine_scale_set.linux_virtual_machine_scale_set_autoscale["`<linux-virtual-machine-scale-set-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Compute/virtualMachineScaleSets/`<linux-virtual-machine-scale-set-name>`'
### Monitor Autoscale Setting
* terraform import '`<path-to-module>`.azurerm_monitor_autoscale_setting.monitor_autoscale_setting["`<virtual-machine-scale-set-name>`_`<monitor-autoscale-setting-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Insights/autoScaleSettings/`<monitor-autoscale-setting-name>`'
### Diagnostic Setting
* terraform import '`<path-to-module>`.azurerm_monitor_diagnostic_setting.diagnostic_setting["`<monitor-autoscale-setting-name>`_`<diag-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Insights/autoScaleSettings/`<monitor-autoscale-setting-name>`|`<diag-name>`'

 > **_NOTE:_** `<path-to-module>` is terraform logical path from root. e.g. _module.virtual\_machine\_scale\_set_

&nbsp;

# Outputs
## Structure

| Output Name | Value        | Comment                                              |
| ----------- | ------------ | ---------------------------------------------------- |
| outputs     | name         |                                                      |
|             | id           |                                                      |
|             | principal_id | principal_id (object_id) of system assigned identity |

## Example usage of outputs
In the example below, outputted _id_ of the deployed Virtual Machine Scale Set module is used as a value for the _scope_ variable in Role Assignment resource.
```
module "vmss" {
    source = "git@github.com:seyfor-csc/mit.virtual-machine-scale-set.git?ref=v1.0.0"
    config = [
        {
            os_type                         = "Linux"
            name                            = "SEY-TERRAFORM-NE-VMSS01"
            resource_group_name             = "SEY-TERRAFORM-NE-RG01"
            location                        = "northeurope"
            sku                             = "Standard_F2"
            instances                       = 2
            admin_username                  = "adminuser"
            admin_password                  = "P@ssw0rd1234!"
            disable_password_authentication = false
            computer_name_prefix            = "sey"

            source_image_reference = {
                publisher = "Canonical"
                offer     = "UbuntuServer"
                sku       = "16.04-LTS"
                version   = "latest"
            }

            network_interface = [
                {
                    name    = "example"
                    primary = true

                    ip_configuration = [
                        {
                        name      = "internal"
                        primary   = true
                        subnet_id = azurerm_subnet.subnet.id
                        }
                    ]
                }
            ]

            os_disk = {
                storage_account_type = "Standard_LRS"
                caching              = "ReadWrite"
            }
       }
    ]
}

data "azurerm_client_config" "azurerm_client_config" {
}

resource "azurerm_role_assignment" "role_assignment" {
    scope                = module.vmss.outputs.sey-terraform-ne-vmss01.id # This is how to use output values
    role_definition_name = "Contributor"
    principal_id         = data.azurerm_client_config.azurerm_client_config.object_id

    depends_on = [
        module.vmss
    ]
}
```

&nbsp;

# Module Features
## Custom variables
* `os_type` variable must be configured to either _Window_ or _Linux_ value. This variable is used to determine which virtual machine scale set will be deployed.
* `autoscale` variable must be defined if you want autoscaling to be enabled. It is important this variable is set otherwise autoscale will not work. When you set the value to _true_, lifecycle with ignore_changes block for the variable `instances` is turned on. This is because the number of instances in that case is managed by autoscale and not by terraform.

&nbsp;

# Known Issues
We currently log no issues in this module.