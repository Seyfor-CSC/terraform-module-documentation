# Introduction
> **_NOTE:_** Only use for imports of migrated virtual machines

Virtual Machine module can deploy these resources:
* azapi_resource (required)
* azurerm_network_interface (required)
* azurerm_managed_disk (required)
* azurerm_monitor_data_collection_rule_association (optional)
* azurerm_virtual_machine_extension (optional)
* azurerm_data_protection_backup_instance_disk (optional)
* azurerm_backup_protected_vm (optional)

Example variables structure is located in [variables.md](variables.md).

Example use case is located in [test-case/locals.tf](test-case/locals.tf).

You can also see [changelog](CHANGELOG.md).

Terraform documentation:

https://registry.terraform.io/providers/Azure/azapi/1.12.1/docs/resources/azapi_resource

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
### Data Collection Rule Association
* terraform import '`<path-to-module>`.azurerm_monitor_data_collection_rule_association.monitor_data_collection_rule_association["`<virtual-machine-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Compute/virtualMachines/`<virtual-machine-name>`/providers/Microsoft.Insights/dataCollectionRuleAssociations/`<data-collection-rule-association-name>`'
### Virtual Machine Extension
* terraform import '`<path-to-module>`.azurerm_virtual_machine_extension.virtual_machine_extension["`<virtual-machine-name>`_`<virtual-machine-extension-name`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Compute/virtualMachines/`<virtual-machine-name>`/extensions/`<extensionName>`'
### Backup Policy Disk
* terraform import '`<path-to-module>`.azurerm_data_protection_backup_policy_disk.data_protection_backup_policy_disk["`<virtual-machine-name>`_`<managed-disk-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.DataProtection/backupVaults/`<backup-vault-name>`/backupPolicies/`<backup-policy-name>`'
### Backup Protected VM
* terraform import '`<path-to-module>`.azurerm_backup_protected_vm.backup_protected_vm["`<virtual-machine-name>`_<recovery-services-vault-name>"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.RecoveryServices/vaults/`<recovery-services-vault-name>`/backupFabrics/Azure/protectionContainers/iaasvmcontainer;iaasvmcontainerv2;`<resource-group-name>`;`<virtual-machine-name>`/protectedItems/vm;iaasvmcontainerv2;`<resource-group-name>`;`<virtual-machine-name>`'

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
            # Configuration of the migrated virtual machine
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
## Import of Virtual Machine
This module is complex and really specific to the scenario it is intended for. Use [test-case](test-case) as a guide for how to use it. First you should deploy [test-case/1-migration-simulation](test-case/1-migration-simulation) which will simulate the migrated resources. Then you can deploy [test-case/2-import](test-case/2-import) which will import the resources into the .tfstate file.

&nbsp;

# Known Issues
## Only use for imports of migrated virtual machines
This module is not suitable to be used for deployments of new virtual machines. It is designed to be used for imports of virtual machines that are created from restored OS disks. 
## Changing property 'osProfile' is not allowed.
If the virtual machine has an osProfile configured, it is not possible to import it. We are currently looking for a solution to change this.
