# Introduction
> **_DISCLAIMER:_** This module is still in development

> **_NOTE:_** Only use for imports of migrated virtual machines

Virtual Machine module can deploy these resources:
* azapi_resource (required)
* azurerm_network_interface (optional)
* azurerm_managed_disk (optional)
* azurerm_monitor_data_collection_rule_association (optional)
* azurerm_virtual_machine_extension (optional)
* azurerm_data_protection_backup_instance_disk (optional)
* azurerm_backup_protected_vm (optional)
> **_NOTE:_** At least one of the virtual machines needs to be specified in module configuration

Example variables structure is located in [variables.md](variables.md).

Example use case is located in [test-case/locals.tf](test-case/locals.tf).

You can also see [changelog](CHANGELOG.md).

Terraform documentation:

https://registry.terraform.io/providers/Azure/azapi/1.13.1/docs/resources/azapi_resource

https://registry.terraform.io/providers/hashicorp/azurerm/3.108.0/docs/resources/network_interface

https://registry.terraform.io/providers/hashicorp/azurerm/3.108.0/docs/resources/managed_disk

https://registry.terraform.io/providers/hashicorp/azurerm/3.108.0/docs/resources/monitor_data_collection_rule_association

https://registry.terraform.io/providers/hashicorp/azurerm/3.108.0/docs/resources/virtual_machine_extension

https://registry.terraform.io/providers/hashicorp/azurerm/3.108.0/docs/resources/data_protection_backup_instance_disk

https://registry.terraform.io/providers/hashicorp/azurerm/3.108.0/docs/resources/backup_protected_vm

Microsoft documentation:

https://learn.microsoft.com/en-us/azure/templates/microsoft.compute/virtualmachines?pivots=deployment-language-terraform

&nbsp;

# Terraform Import
There are a few things you need to do to import resources into .tfstate. In the example below there are resources which can be imported within the module. You may need to modify these commands to the OS on which they will be running (Refer to the [documentation](https://developer.hashicorp.com/terraform/cli/commands/import#example-import-into-resource-configured-with-for_each) for additional details).
### Virtual Machine
* terraform import '`<path-to-module>`.azapi_resource.virtual_machine["`<virtual-machine-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Compute/virtualMachines/`<windows-virtual-machine-name>`'
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
### Backup Policy Disk
* terraform import '`<path-to-module>`.azurerm_data_protection_backup_policy_disk.data_protection_backup_policy_disk["`<backup-vault-name_backup-policy-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.DataProtection/backupVaults/`<backup-vault-name>`/backupPolicies/`<backup-policy-name>`'
### Backup Protected VM
* terraform import '`<path-to-module>`.azurerm_backup_protected_vm.backup_protected_vm["`<backup-policy-name>`_`<protected-vm-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.RecoveryServices/vaults/`<recovery-services-vault-name>`/backupFabrics/Azure/protectionContainers/iaasvmcontainer;iaasvmcontainerv2;`<resource-group-name>`;`<protected-vm-name>`/protectedItems/vm;iaasvmcontainerv2;`<resource-group-name>`;`<protected-vm-name>`'

 > **_NOTE:_** `<path-to-module>` is terraform logical path from root. e.g. _module.virtual\_machine_

&nbsp;

# Outputs
## Structure

| Output Name | Value              | Comment                                              |
| ----------- | ------------------ | ---------------------------------------------------- |
| outputs     | name               |                                                      |
|             | id                 |                                                      |
|             | principal_id       | principal_id (object_id) of system assigned identity |
|             | network_interfaces | Network Interface outputs                            |
|             | &nbsp;name         |                                                      |
|             | &nbsp;id           |                                                      |
|             | managed_disks      | Managed Disk outputs                                 |
|             | &nbsp;name         |                                                      |
|             | &nbsp;id           |                                                      |
|             | vm_extensions      | Virtual Machine Extension outputs                    |
|             | &nbsp;name         |                                                      |
|             | &nbsp;id           |                                                      |

## Example usage of outputs
In the example below, outputted _id_ of the deployed Virtual Machine module is used as a value for the _scope_ variable in Role Assignment resource.
```
module "vm" {
    source = "git@github.com:seyfor-csc/mit.virtual-machine-azapi.git?ref=v1.0.0"
    config = [
        {
            name                = "SEYTERRAFORMVM01"
            location            = "northeurope"
            resource_group_name = azurerm_resource_group.rg.name
            parent_id           = azurerm_resource_group.rg.id
            properties = {
                hardwareProfile = {
                vmSize = "Standard_F2"
                }
                osProfile = {
                adminUsername = "adminuser"
                adminPassword = "Password1234"
                computerName  = "SEYTERRAFORMVM01"
                windowsConfiguration = {
                    disable_password_authentication = false
                }
                }
                networkProfile = {
                networkInterfaces = [
                    {
                    id = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/SEY-TERRAFORM-NE-RG01/providers/Microsoft.Network/networkInterfaces/SEYTERRAFORMVM01-nic0"
                    }
                ]
                }
                storageProfile = {
                osDisk = {
                    name         = "SEYTERRAFORMVM01-osdisk"
                    osType       = "Windows"
                    deleteOption = "Detach"
                    diskSizeGB   = 128
                    caching      = "ReadWrite"
                    createOption = "FromImage"
                }
                imageReference = {
                    publisher = "MicrosoftWindowsServer"
                    offer     = "WindowsServer"
                    sku       = "2022-Datacenter"
                    version   = "latest"
                }
                }
            }
            network_interfaces = [
                {
                name = "SEYTERRAFORMVM01-nic0"
                ip_configuration = [
                    {
                    name                          = "ipconfig1"
                    subnet_id                     = azurerm_subnet.subnet.id
                    private_ip_address_allocation = "Static"
                    private_ip_address            = "10.0.1.26"
                    primary                       = true
                    }
                ]
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
## Subscription Id
When using the module, subscription_id variable needs to be configured in the module call (in the same place as source or the config variable) if you want to turn on backup of disks or backup of virtual machines. Set the value of this variable to the subscription id you will deploy this module into. Go to [test-case/main.tf](test-case/main.tf) to see how it should look like.

&nbsp;

# Known Issues
## Only use for imports of migrated virtual machines
This module is not suitable to be used for deployments of new virtual machines. It is designed to be used for imports of virtual machines that are created from restored OS disks. 
