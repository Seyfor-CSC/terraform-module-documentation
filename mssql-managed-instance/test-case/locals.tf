locals {
  location = "northeurope"

  naming = {
    rg   = "SEY-TERRAFORM-NE-RG01"
    mi_1 = "SEY-TERRAFORM-NE-MI01"
  }

    mi = [
    {
      name                         = local.naming.mi_1
      location                     = local.location
      resource_group_name          = local.naming.rg
      administrator_login          = "useradmin"
      administrator_login_password = "Password1234"
      license_type                 = "LicenseIncluded"
      sku_name                     = "GP_Gen5"
      storage_size_in_gb           = 32
      vcores                       = 4
      subnet_id                    = data.azurerm_subnet.example.id
      identity = {
        type = "SystemAssigned"
      }

      monitoring = [
        {
          diag_name                  = "Monitoring"
          log_analytics_workspace_id = azurerm_log_analytics_workspace.la.id
        }
      ]

      tags = {}
    }
  ]
}
