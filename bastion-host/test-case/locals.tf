locals {
  location = "northeurope"

  naming = {
    rg   = "SEY-BASTION-NE-RG01"
    bh_1 = "SEY-TERRAFORM-NE-BASTION01"
    bh_2 = "SEY-TERRAFORM-NE-BASTION02"
  }

  bh = [
    {
      name                = local.naming.bh_1
      location            = local.location
      resource_group_name = azurerm_resource_group.rg.name
      ip_configuration = {
        name                 = "ipconfig"
        subnet_id            = azurerm_subnet.subnet1.id
        public_ip_address_id = azurerm_public_ip.pip1.id
      }

      monitoring = [
        {
          diag_name                  = "Monitoring"
          log_analytics_workspace_id = azurerm_log_analytics_workspace.la.id
          categories = {
            bastion_audit_logs = false
          }
        }
      ]

      tags = {}
    },
    {
      name                = local.naming.bh_2
      location            = local.location
      resource_group_name = azurerm_resource_group.rg.name
      ip_configuration = {
        name                 = "ipconfig"
        subnet_id            = azurerm_subnet.subnet2.id
        public_ip_address_id = azurerm_public_ip.pip2.id
      }

      tags = {}
    }
  ]
}
