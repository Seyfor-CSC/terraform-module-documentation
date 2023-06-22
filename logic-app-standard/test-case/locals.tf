locals {
  location = "northeurope"

  naming = {
    rg      = "SEY-TERRAFORM-NE-RG01"
    logic_1 = "SEY-TERRAFORM-NE-LOGIC01"
    logic_2 = "SEY-TERRAFORM-NE-LOGIC02"
  }

    logic = [
    {
      name                       = local.naming.logic_1
      location                   = local.location
      resource_group_name        = local.naming.rg
      app_service_plan_id        = azurerm_service_plan.asp.id
      storage_account_name       = azurerm_storage_account.sa.name
      storage_account_access_key = azurerm_storage_account.sa.primary_access_key
      identity = {
        type = "SystemAssigned"
      }
      app_settings = {
        "FUNCTIONS_WORKER_RUNTIME"     = "node"
        "WEBSITE_NODE_DEFAULT_VERSION" = "~18"
      }

      tags = {}
    },
    {
      name                       = local.naming.logic_2
      location                   = local.location
      resource_group_name        = local.naming.rg
      app_service_plan_id        = azurerm_service_plan.asp.id
      storage_account_name       = azurerm_storage_account.sa.name
      storage_account_access_key = azurerm_storage_account.sa.primary_access_key

      tags = {}
    }
  ]
}
