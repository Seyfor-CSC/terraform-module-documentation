locals {
  location = "northeurope"

  naming = {
    rg         = "SEY-DEVCENTER-NE-RG01"
    devcenter1 = "sey-terraform-ne-dc01"
    devcenter2 = "sey-terraform-ne-dc02"
    project1   = "sey-devcenter-ne-prj01"
    project2   = "sey-devcenter-ne-prj02"
  }

  config = [
    {
      name                              = local.naming.devcenter1
      location                          = local.location
      resource_group_name               = azurerm_resource_group.rg.name
      project_catalog_item_sync_enabled = true
      identity = {
        type = "SystemAssigned"
      }
      monitoring = [
        {
          diag_name                  = "Monitoring"
          log_analytics_workspace_id = azurerm_log_analytics_workspace.la.id
          categories = {
            usage = false
          }
        }
      ]

      project = [
        {
          name                       = local.naming.project1
          description                = "Primary engineering project"
          maximum_dev_boxes_per_user = 10
          identity = {
            type = "SystemAssigned"
          }
        }
      ]
    },
    {
      name                = local.naming.devcenter2
      location            = local.location
      resource_group_name = azurerm_resource_group.rg.name
    }
  ]
}
