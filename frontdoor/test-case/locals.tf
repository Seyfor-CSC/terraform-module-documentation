locals {
  location = "northeurope"

  naming = {
    rg                = "SEY-FD-NE-RG01"
    frontdoor_profile = "SEY-TERRAFORM-NE-FD01"
    origin_group      = "SEY-TERRAFORM-NE-OG01"
    origin            = "SEY-TERRAFORM-NE-O01"
    endpoint          = "SEY-TERRAFORM-NE-EP01"
    custom_domain     = "SEY-TERRAFORM-NE-CD01"
  }

  frontdoor = [
    {
      name                     = local.naming.frontdoor_profile
      resource_group_name      = azurerm_resource_group.rg.name
      sku_name                 = "Premium_AzureFrontDoor"
      response_timeout_seconds = 120
      identity = {
        type = "SystemAssigned"
      }

      endpoint = [
        {
          name    = local.naming.endpoint
          enabled = true
        }
      ]

      origin_group = [
        {
          name = local.naming.origin_group
          load_balancing = {
            sample_size                 = 4
            successful_samples_required = 3
          }
          health_probe = {
            protocol            = "Https"
            interval_in_seconds = 100
            path                = "/health"
          }
          session_affinity_enabled = false

          origin = [
            {
              name                           = local.naming.origin
              host_name                      = "sey.contoso.com"
              enabled                        = true
              certificate_name_check_enabled = true
              https_port                     = 443
              priority                       = 1
              weight                         = 500
            }
          ]
        }
      ]

      route = [
        {
          name                              = "default-route"
          cdn_frontdoor_endpoint_name       = local.naming.endpoint
          cdn_frontdoor_origin_group_name   = local.naming.origin_group
          cdn_frontdoor_origin_names        = [local.naming.origin]
          cdn_frontdoor_custom_domain_names = [local.naming.custom_domain]
          patterns_to_match                 = ["/*"]
          supported_protocols               = ["Http", "Https"]
          forwarding_protocol               = "HttpsOnly"
          link_to_default_domain            = true
        }
      ]

      custom_domain = [
        {
          name      = local.naming.custom_domain
          host_name = "sey.contoso.com"
          tls = {
            certificate_type = "ManagedCertificate"
          }
        }
      ]

      monitoring = [
        {
          diag_name                  = "Monitoring"
          log_analytics_workspace_id = azurerm_log_analytics_workspace.la.id
        },
        {
          diag_name                      = "SecurityMonitoring"
          eventhub_name                  = azurerm_eventhub.eventhub.name
          eventhub_authorization_rule_id = "${azurerm_eventhub_namespace.eventhub_namespace.id}/authorizationRules/RootManageSharedAccessKey"
          categories = {
            all_metrics = false
          }
        }
      ]
    }
  ]
}
