locals {
  location = "northeurope"

  naming = {
    rg   = "SEY-TERRAFORM-NE-RG01"
    ca_1 = "sey-terraform-ne-ca01"
    ca_2 = "sey-terraform-ne-ca02"
  }

  ca = [
    {
      name                         = local.naming.ca_1
      resource_group_name          = azurerm_resource_group.rg.name
      container_app_environment_id = azurerm_container_app_environment.cae.id
      revision_mode                = "Single"
      template = {
        container = [
          {
            name   = "testcontainerapp0"
            image  = "nginx:latest"
            cpu    = 0.25
            memory = "0.5Gi"
            liveness_probe = {
              failure_count_threshold = 3
              header = {
                name  = "Custom-Header"
                value = "HeaderValue"
              }
              initial_delay    = 10
              interval_seconds = 30
              path             = "/healthz"
              port             = 80
              timeout          = 2
              transport        = "HTTP"
            }
            readiness_probe = {
              port      = 80
              transport = "HTTP"
            }
            startup_probe = {
              port      = 80
              transport = "TCP"
            }
          }
        ]
      }
      identity = {
        type = "SystemAssigned"
      }

      tags = {}
    },
    {
      name                         = local.naming.ca_2
      resource_group_name          = azurerm_resource_group.rg.name
      container_app_environment_id = azurerm_container_app_environment.cae.id
      revision_mode                = "Single"
      template = {
        container = [
          {
            name   = "testcontainerapp0"
            image  = "hello-world:latest"
            cpu    = 0.25
            memory = "0.5Gi"
          }
        ]
      }

      tags = {}
    }
  ]
}
