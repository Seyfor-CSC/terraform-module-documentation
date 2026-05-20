locals {
  location = "swedencentral"

  naming = {
    rg    = "SEY-MDP-SWC-RG01"
    mdp_1 = "SEY-TERRAFORM-SWC-MDP01"
    mdp_2 = "SEY-TERRAFORM-SWC-MDP02"
  }

  config = [
    {
      name                  = local.naming.mdp_1
      location              = local.location
      resource_group_name   = azurerm_resource_group.rg.name
      dev_center_project_id = azurerm_dev_center_project.dc_project.id
      maximum_concurrency   = 2

      azure_devops_organization = {
        organization = [
          {
            parallelism = 2
            url         = "https://dev.azure.com/my-organization"
          }
        ]
      }

      virtual_machine_scale_set_fabric = {
        sku_name = "Standard_D2as_v5"
        image = [
          {
            well_known_image_name = "ubuntu-24.04/latest"
            buffer                = "*"
          }
        ]
      }

      stateless_agent = {
        manual_resource_prediction = {
          time_zone_name = "UTC"
          monday_schedule = [
            {
              count = 1
              time  = "08:00:00"
            },
            {
              count = 2
              time  = "13:00:00"
            }
          ]
          friday_schedule = [
            {
              count = 1
              time  = "18:00:00"
            }
          ]
        }
      }

      monitoring = [
        {
          diag_name                  = "Monitoring"
          log_analytics_workspace_id = azurerm_log_analytics_workspace.la.id
        }
      ]
    },
    {
      name                  = local.naming.mdp_2
      location              = local.location
      resource_group_name   = azurerm_resource_group.rg.name
      dev_center_project_id = azurerm_dev_center_project.dc_project.id
      maximum_concurrency   = 1

      azure_devops_organization = {
        organization = [
          {
            parallelism = 1
            url         = "https://dev.azure.com/my-organization"
          }
        ]
      }

      virtual_machine_scale_set_fabric = {
        sku_name = "Standard_D2as_v5"
        image = [
          {
            well_known_image_name = "windows-2022/latest"
          }
        ]
      }

      stateless_agent = {}
    }
  ]
}
