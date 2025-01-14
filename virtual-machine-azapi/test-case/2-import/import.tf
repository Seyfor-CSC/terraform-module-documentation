import {
  to = azurerm_resource_group.rg
  id = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/SEY-AZAPIVM-NE-RG01"
}

import {
  to = module.vm.azurerm_managed_disk.managed_disk["SEYAZAPIVM01-osdisk"]
  id = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/SEY-AZAPIVM-NE-RG01/providers/Microsoft.Compute/disks/SEYAZAPIVM01-osdisk"
}
import {
  to = module.vm.azurerm_managed_disk.managed_disk["SEYAZAPIVM01-data01"]
  id = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/SEY-AZAPIVM-NE-RG01/providers/Microsoft.Compute/disks/SEYAZAPIVM01-data01"
}

import {
  to = module.vm.azurerm_network_interface.network_interface["SEYAZAPIVM01-nic0"]
  id = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/SEY-AZAPIVM-NE-RG01/providers/Microsoft.Network/networkInterfaces/SEYAZAPIVM01-nic0"
}

import {
  to = module.vm.azapi_resource.virtual_machine["SEYAZAPIVM01"]
  id = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/SEY-AZAPIVM-NE-RG01/providers/Microsoft.Compute/virtualMachines/SEYAZAPIVM01"
}