# Introduction
Virtual Machine module can deploy these resources:
* azurerm_windows_virtual_machine (optional)
* azurerm_linux_virtual_machine (optional)
* azurerm_network_interface (optional)
* azurerm_managed_disk (optional)
* azurerm_virtual_machine_data_disk_attachment (optional)
* azurerm_monitor_data_collection_rule_association (optional)
* azurerm_virtual_machine_extension (optional)
* azurerm_data_protection_backup_instance_disk (optional)
* azurerm_backup_protected_vm (optional)
> **_NOTE:_** At least one of the virtual machines needs to be specified in module configuration

Example variables structure is located in [variables.md](variables.md).

Example use case is located in [test-case/locals.tf](test-case/locals.tf).

You can also see [changelog](CHANGELOG.md).

Terraform documentation:

https://registry.terraform.io/providers/hashicorp/azurerm/4.56.0/docs/resources/windows_virtual_machine

https://registry.terraform.io/providers/hashicorp/azurerm/4.56.0/docs/resources/linux_virtual_machine

https://registry.terraform.io/providers/hashicorp/azurerm/4.56.0/docs/resources/network_interface

https://registry.terraform.io/providers/hashicorp/azurerm/4.56.0/docs/resources/managed_disk

https://registry.terraform.io/providers/hashicorp/azurerm/4.56.0/docs/resources/virtual_machine_data_disk_attachment

https://registry.terraform.io/providers/hashicorp/azurerm/4.56.0/docs/resources/monitor_data_collection_rule_association

https://registry.terraform.io/providers/hashicorp/azurerm/4.56.0/docs/resources/virtual_machine_extension

https://registry.terraform.io/providers/hashicorp/azurerm/4.56.0/docs/resources/data_protection_backup_instance_disk

https://registry.terraform.io/providers/hashicorp/azurerm/4.56.0/docs/resources/backup_protected_vm

&nbsp;

> **WARNING:** AzureRM provider had been updated to a new major version. Many breaking changes were implemented. See the [providers guide](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/4.0-upgrade-guide) for more information.

# Terraform Import
There are a few things you need to do to import resources into .tfstate. In the example below there are resources which can be imported within the module. You may need to modify these commands to the OS on which they will be running (Refer to the [documentation](https://developer.hashicorp.com/terraform/cli/commands/import#example-import-into-resource-configured-with-for_each) for additional details).
### Windows Virtual Machine
* terraform import '`<path-to-module>`.azurerm_windows_virtual_machine.windows_virtual_machine["`<windows-virtual-machine-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Compute/virtualMachines/`<windows-virtual-machine-name>`'
### Linux Virtual Machine
* terraform import '`<path-to-module>`.azurerm_linux_virtual_machine.linux_virtual_machine["`<linux-virtual-machine-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Compute/virtualMachines/`<linux-virtual-machine-name>`'
### Network Interface
* terraform import '`<path-to-module>`.azurerm_network_interface.network_interface["`<network-interface-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Network/networkInterfaces/`<network-interface-name>`'
### Managed Disk
* terraform import '`<path-to-module>`.azurerm_managed_disk.managed_disk["`<managed-disk-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Compute/disks/`<managed-disk-name>`'
### Virtual Machine Data Disk Attachment
* terraform import '`<path-to-module>`.azurerm_virtual_machine_data_disk_attachment.virtual_machine_data_disk_attachment["`<managed-disk-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Compute/virtualMachines/`<virtual-machine-name>`/dataDisks/`<managed-disk-name>`'
### Data Collection Rule Association
* terraform import '`<path-to-module>`.azurerm_monitor_data_collection_rule_association.monitor_data_collection_rule_association["`<virtual-machine-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Compute/virtualMachines/`<virtual-machine-name>`/providers/Microsoft.Insights/dataCollectionRuleAssociations/`<data-collection-rule-association-name>`'
### Virtual Machine Extension
* terraform import '`<path-to-module>`.azurerm_virtual_machine_extension.virtual_machine_extension["`<virtual-machine-name`_`<virtual-machine-extension-name`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Compute/virtualMachines/`<virtual-machine-name>`/extensions/`<extensionName>`'
### Backup Instance Disk
* terraform import '`<path-to-module>`.azurerm_data_protection_backup_instance_disk.data_protection_backup_instance_disk["`<virtual-machine-name>`_`<backup-instance-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.DataProtection/backupVaults/`<backup-vault-name>`/backupInstances/`<backup-instance-name>`'
### Backup Protected VM
* terraform import '`<path-to-module>`.azurerm_backup_protected_vm.backup_protected_vm["`<virtual-machine-name>`_`<recovery-services-vault-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.RecoveryServices/vaults/`<recovery-services-vault-name>`/backupFabrics/Azure/protectionContainers/iaasvmcontainer;iaasvmcontainerv2;`<resource-group-name>`;`<virtual-machine-name>`/protectedItems/vm;iaasvmcontainerv2;`<resource-group-name>`;`<virtual-machine-name>`'

 > **_NOTE:_** `<path-to-module>` is terraform logical path from root. e.g. _module.virtual\_machine_

&nbsp;

# Outputs
## Structure

| Output Name | Value | Comment |
| ----------- | ----- | ------- |
| outputs     | name                           |                                                                             |
|             | id                             |                                                                             |
|             | principal_id                   | principal_id (object_id) of system assigned identity                        |
|             | os_disk_id                     |                                                                             |
|             | size                           |                                                                             |
|             | zone                           |                                                                             |
|             | use_capacity_reservation       | Custom variable - used for filtering VMs in mit.capacity-reservation module |
|             | network_interfaces             | Network Interface outputs                                                   |
|             | &nbsp;name                     |                                                                             |
|             | &nbsp;id                       |                                                                             |
|             | managed_disks                  | Managed Disk outputs                                                        |
|             | &nbsp;name                     |                                                                             |
|             | &nbsp;id                       |                                                                             |
|             | vm_extensions                  | Virtual Machine Extension outputs                                           |
|             | &nbsp;name                     |                                                                             |
|             | &nbsp;id                       |                                                                             |


## Example usage of outputs
In the example below, outputted _id_ of the deployed Virtual Machine module is used as a value for the _scope_ variable in Role Assignment resource.
```
module "vm" {
    source = "git@github.com:seyfor-csc/mit.virtual-machine.git?ref=v1.0.0"
    config = [
        {
            os_type                         = "Windows"
            name                            = "SEY-TERRAFORM-NE-VM01"
            location                        = "northeurope"
            resource_group_name             = "SEY-TERRAFORM-NE-RG01"
            size                            = "Standard_F2"
            admin_username                  = "adminuser"
            admin_password                  = "Password1234"
            computer_name                   = "EX3TESTVM01"
            disable_password_authentication = false
            os_disk = {
                caching              = "ReadWrite"
                storage_account_type = "Standard_LRS"
            }
            source_image_reference = {
                publisher = "MicrosoftWindowsServer"
                offer     = "WindowsServer"
                sku       = "2022-Datacenter"
                version   = "latest"
            }
            network_interfaces = [
                {
                    name = "SEY-TERRAFORM-NE-VM01.nic"
                    ip_configuration = {
                        name                          = "internal"
                        subnet_id                     = azurerm_subnet.subnet.id
                        private_ip_address_allocation = "Dynamic"
                    }
                }
            ]
        }
    ]
}

data "azurerm_client_config" "azurerm_client_config" {
}

resource "azurerm_role_assignment" "role_assignment" {
    scope                = module.vm.outputs.sey-terraform-ne-vm01.id # This is how to use output values
    role_definition_name = "Contributor"
    principal_id         = data.azurerm_client_config.azurerm_client_config.object_id
}
```

&nbsp;

# Module Features
## Custom variables
* `use_capacity_reservation` is a boolean parameter (default: `false`) that controls whether a VM should be included in automated capacity reservation management. When set to `true`, the VM's details (`name`, `size`, `zone`) outputted by this module and can be passed to the `mit.capacity-reservation` module. The capacity reservation module then automatically creates appropriate capacity reservations based on the VM requirements and assigns VMs to those reservations. This parameter allows selective VM enrollment - only VMs with `use_capacity_reservation = true` will be included in the automated capacity reservation workflow, while others will operate normally without reservations. The `capacity_reservation_group_id` input variable should be set to link the VM to a capacity reservation group.
## Linux or Windows VM?
This module can deploy Linux or Windows Virtual Machines. You need to specify which one you want to deploy by setting the `os_type` custom variable to either _Linux_ or _Windows_. See [test-case/locals.tf](test-case/locals.tf) for a deployment example.
## Lifecycle
This module has a lifecycle block set up like this:
```
lifecycle {
    ignore_changes = [
        admin_password,
        admin_username,
        source_image_id,
    ]
}
```
## Subscription Id
When using the module, subscription_id variable needs to be configured in the module call (in the same place as source or the config variable) if you want to turn on backup of OS disks. Set the value of this variable to the subscription id you will deploy this module into. Go to [test-case/main.tf](test-case/main.tf) to see how it should look like.
## Monitoring tags in `ignore_changes` lifecycle block
We reserve the right to include tags dedicated to our product Advanced Monitoring in the `ignore_changes` lifecycle block. This is to prevent the module from deleting those tags. The tags we ignore are: `tags["Platform"]`, `tags["MonitoringTier"]`.

&nbsp;

# Known Issues
We currently log no issues in this module.

