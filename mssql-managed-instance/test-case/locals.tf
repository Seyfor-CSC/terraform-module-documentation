locals {
  location = "northeurope"

  naming = {
    rg   = "SEY-MI-NE-RG01"
    mi_1 = "SEY-TERRAFORM-NE-MI01"
  }

  mi = [
    {
      name                         = local.naming.mi_1
      location                     = local.location
      resource_group_name          = azurerm_resource_group.rg.name
      administrator_login          = "useradmin"
      administrator_login_password = "Password1234"
      license_type                 = "LicenseIncluded"
      sku_name                     = "GP_Gen5"
      storage_size_in_gb           = 32
      vcores                       = 4
      subnet_id                    = azurerm_subnet.example.id
      identity = {
        type = "SystemAssigned"
      }

      private_endpoint = [
        {
          name                          = "${local.naming.mi_1}-PE01"
          subnet_id                     = azurerm_subnet.subnet.id
          custom_network_interface_name = "${local.naming.mi_1}-PE01.nic"
          private_service_connection = [
            {
              name                 = "${local.naming.mi_1}-PE01-connection"
              is_manual_connection = false
              subresource_names    = ["managedInstance"]
            }
          ]
          private_dns_zone_group = {
            name = azurerm_private_dns_zone.dns.name
            private_dns_zone_ids = [
              azurerm_private_dns_zone.dns.id
            ]
          }
        }
      ]

      monitoring = [
        {
          diag_name                  = "Monitoring"
          log_analytics_workspace_id = azurerm_log_analytics_workspace.la.id
          categories = {
            devops_operations_audit = false
          }
        }
      ]

      tags = {}
    }
  ]
}
