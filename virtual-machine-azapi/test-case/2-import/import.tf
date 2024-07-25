import {
    to = azurerm_resource_group.rg
    id = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/SEY-TERRAFORM-NE-RG01"
}

import {
    to = module.vm.azurerm_managed_disk.managed_disk["SEYWINDOWSVM01-osdisk"]
    id = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/SEY-TERRAFORM-NE-RG01/providers/Microsoft.Compute/disks/SEYWINDOWSVM01-osdisk"
}
import {
    to = module.vm.azurerm_managed_disk.managed_disk["SEYWINDOWSVM01-data01"]
    id = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/SEY-TERRAFORM-NE-RG01/providers/Microsoft.Compute/disks/SEYWINDOWSVM01-data01"
}

import {
    to = module.vm.azurerm_network_interface.network_interface["SEYWINDOWSVM01-nic0"]
    id = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/SEY-TERRAFORM-NE-RG01/providers/Microsoft.Network/networkInterfaces/SEYWINDOWSVM01-nic0"
}
import {
    to = module.vm.azurerm_network_interface.network_interface["SEYWINDOWSVM01-nic1"]
    id = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/SEY-TERRAFORM-NE-RG01/providers/Microsoft.Network/networkInterfaces/SEYWINDOWSVM01-nic1"
}

import {
    to = module.vm.azapi_resource.virtual_machine["SEYWINDOWSVM01"]
    id = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/SEY-TERRAFORM-NE-RG01/providers/Microsoft.Compute/virtualMachines/SEYWINDOWSVM01"
}