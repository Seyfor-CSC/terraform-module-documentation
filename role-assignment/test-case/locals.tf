locals {
  location = "northeurope"

  naming = {
    rg = "SEY-TERRAFORM-NE-RG01"
    aa = "SEY-TERRAFORM-NE-AA01"
  }


  rbac = [
    {
      custom_name          = "${local.naming.rg}-RBAC01"
      scope                = azurerm_resource_group.rg.id
      role_definition_name = "Contributor"
      principal_id         = data.azurerm_client_config.azurerm_client_config.object_id
    },
    {
      custom_name          = "${local.naming.rg}-RBAC02"
      scope                = azurerm_resource_group.rg.id
      role_definition_name = "Reader"
      principal_id         = data.azurerm_client_config.azurerm_client_config.object_id
    },
    {
      custom_name          = "${local.naming.aa}-RBAC01"
      scope                = azurerm_automation_account.aa.id
      role_definition_name = "Contributor"
      principal_id         = data.azurerm_client_config.azurerm_client_config.object_id
    },
    {
      custom_name          = "${local.naming.aa}-RBAC02"
      scope                = azurerm_automation_account.aa.id
      role_definition_name = "Reader"
      principal_id         = data.azurerm_client_config.azurerm_client_config.object_id
    }
  ]
}
