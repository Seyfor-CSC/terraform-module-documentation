locals {
  location = "northeurope"

  naming = {
    rg    = "SEY-TERRAFORM-NE-RG01"
    caj_1 = "sey-terraform-ne-caj01"
    caj_2 = "sey-terraform-ne-caj02"
  }

  caj = [
    {
      name                         = local.naming.caj_1
      resource_group_name          = azurerm_resource_group.rg.name
      location                     = local.location
      container_app_environment_id = azurerm_container_app_environment.cae.id
      replica_timeout_in_seconds   = 10
      replica_retry_limit          = 10
      manual_trigger_config = {
        parallelism              = 4
        replica_completion_count = 1
      }
      template = {
        container = {
          image = "nginx:latest"
          name  = "testcontainerappsjob0"
          readiness_probe = {
            transport = "HTTP"
            port      = 5000
          }
          liveness_probe = {
            transport = "HTTP"
            port      = 80
            path      = "/"
            header = {
              name  = "Cache-Control"
              value = "no-cache"
            }
            initial_delay           = 5
            interval_seconds        = 20
            timeout                 = 2
            failure_count_threshold = 1
          }
          startup_probe = {
            transport = "TCP"
            port      = 5000
          }
          cpu    = 0.5
          memory = "1Gi"
        }
      }
      identity = {
        type = "SystemAssigned"
      }

      tags = {}
    },
    {
      name                         = local.naming.caj_2
      resource_group_name          = azurerm_resource_group.rg.name
      location                     = local.location
      container_app_environment_id = azurerm_container_app_environment.cae.id
      replica_timeout_in_seconds   = 10
      manual_trigger_config = {
        parallelism              = 4
        replica_completion_count = 1
      }
      template = {
        container = {
          image  = "hello-world:latest"
          name   = "testcontainerappsjob0"
          cpu    = 0.5
          memory = "1Gi"
        }
      }

      tags = {}
    }
  ]
}
