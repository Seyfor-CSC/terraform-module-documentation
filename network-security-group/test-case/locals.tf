locals {
  location = "northeurope"

  naming = {
    rg    = "SEY-TERRAFORM-NE-RG01"
    nsg_1 = "SEY-TERRAFORM-NE-NSG01"
    nsg_2 = "SEY-TERRAFORM-NE-NSG02"
    nw    = "SEY-TERRAFORM-NE-NW01"
    sa    = "seyterraformnesa01"
  }

  nsg = [
    {
      name                = local.naming.nsg_1
      location            = local.location
      resource_group_name = azurerm_resource_group.rg.name
      nsg_rule = [
        {
          name                       = "AllowAllInbound"
          priority                   = 100
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "*"
          source_port_range          = "*"
          destination_port_range     = "*"
          source_address_prefix      = "*"
          destination_address_prefix = "*"
        },
        {
          name                       = "AllowAllOutbound"
          priority                   = 101
          direction                  = "Outbound"
          access                     = "Allow"
          protocol                   = "*"
          source_port_range          = "*"
          destination_port_range     = "*"
          source_address_prefix      = "*"
          destination_address_prefix = "*"
        }
      ]
      nsg_flow_log = [
        {
          name                 = "flowlog"
          network_watcher_name = azurerm_network_watcher.nw.name
          resource_group_name  = azurerm_resource_group.rg.name
          storage_account_id   = azurerm_storage_account.sa.id
          enabled              = true
          retention_policy = {
            enabled = true
            days    = 7
          }
        }
      ]

      monitoring = [
        {
          diag_name                  = "Monitoring"
          log_analytics_workspace_id = azurerm_log_analytics_workspace.la.id
        }
      ]

      tags = {}
    },
    {
      name                = local.naming.nsg_2
      location            = local.location
      resource_group_name = azurerm_resource_group.rg.name

      tags = {}
    }
  ]
}
