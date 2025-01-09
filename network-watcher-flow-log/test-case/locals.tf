locals {
  location = "northeurope"

  naming = {
    rg   = "SEY-FLOWLOG-NE-RG01"
    fl_1 = "SEY-TERRAFORM-NE-FL01"
    fl_2 = "SEY-TERRAFORM-NE-FL02"
  }

  flow_log = [
    {
      name                 = local.naming.fl_1
      network_watcher_name = azurerm_network_watcher.nw.name
      resource_group_name  = azurerm_resource_group.rg.name
      storage_account_id   = azurerm_storage_account.sa.id
      target_resource_id   = azurerm_subnet.subnet.id
      enabled              = true
      retention_policy = {
        enabled = true
        days    = 7
      }
    },
    {
      name                 = local.naming.fl_2
      network_watcher_name = azurerm_network_watcher.nw.name
      resource_group_name  = azurerm_resource_group.rg.name
      storage_account_id   = azurerm_storage_account.sa.id
      target_resource_id   = azurerm_virtual_network.vnet.id
      enabled              = true
      retention_policy = {
        enabled = true
        days    = 7
      }
    }
  ]
}
