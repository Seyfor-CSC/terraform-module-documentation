locals {
  location = "northeurope"

  naming = {
    rg          = "SEY-TERRAFORM-NE-RG01"
    pool_1      = "SEY-TERRAFORM-NE-POOL01"
    group_1     = "SEY-TERRAFORM-NE-GROUP01"
    group_2     = "SEY-TERRAFORM-NE-GROUP02"
    plan_1      = "SEY-TERRAFORM-NE-PLAN01"
    workspace_1 = "SEY-TERRAFORM-NE-WORKSPACE01"
  }

  virtual_desktop = {
    host_pools = [
      {
        name                = local.naming.pool_1
        resource_group_name = azurerm_resource_group.rg.name
        location            = local.location
        type                = "Pooled"
        load_balancer_type  = "DepthFirst"

        application_groups = [
          {
            name = local.naming.group_1
            type = "Desktop"

            associations = [
              {
                workspace_name = local.naming.workspace_1
              }
            ]

            monitoring = [
              {
                diag_name                  = "Monitoring"
                log_analytics_workspace_id = azurerm_log_analytics_workspace.la.id
              }
            ]
          },
          {
            name = local.naming.group_2
            type = "RemoteApp"
          }
        ]

        registration_info = {
          expiration_date = "2024-03-30T23:59:59Z"
        }

        monitoring = [
          {
            diag_name                  = "Monitoring"
            log_analytics_workspace_id = azurerm_log_analytics_workspace.la.id
            categories = {
              checkpoint               = false
              connection_graphics_data = false
            }
          }
        ]

        private_endpoint = [
          {
            name                          = "${local.naming.pool_1}-PE01"
            subnet_id                     = azurerm_subnet.subnet.id
            custom_network_interface_name = "${local.naming.pool_1}-PE01.nic"
            private_service_connection = [
              {
                name                 = "${local.naming.pool_1}-PE01-connection"
                is_manual_connection = false
                subresource_names    = ["connection"]
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

        tags = {}
      }
    ]

    scaling_plans = [
      {
        name                = local.naming.plan_1
        resource_group_name = azurerm_resource_group.rg.name
        location            = local.location
        time_zone           = "GMT Standard Time"
        schedule = [
          {
            name                                 = "Weekdays"
            days_of_week                         = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
            ramp_up_start_time                   = "05:00"
            ramp_up_load_balancing_algorithm     = "BreadthFirst"
            ramp_up_minimum_hosts_percent        = 20
            ramp_up_capacity_threshold_percent   = 10
            peak_start_time                      = "09:00"
            peak_load_balancing_algorithm        = "BreadthFirst"
            ramp_down_start_time                 = "19:00"
            ramp_down_load_balancing_algorithm   = "DepthFirst"
            ramp_down_minimum_hosts_percent      = 10
            ramp_down_force_logoff_users         = false
            ramp_down_wait_time_minutes          = 45
            ramp_down_notification_message       = "Please log off in the next 45 minutes..."
            ramp_down_capacity_threshold_percent = 5
            ramp_down_stop_hosts_when            = "ZeroSessions"
            off_peak_start_time                  = "22:00"
            off_peak_load_balancing_algorithm    = "DepthFirst"
          }
        ]
        host_pool = [
          {
            hostpool_name        = local.naming.pool_1
            scaling_plan_enabled = true
          }
        ]

        monitoring = [
          {
            diag_name                  = "Monitoring"
            log_analytics_workspace_id = azurerm_log_analytics_workspace.la.id
          }
        ]

        tags = {}
      }
    ]

    workspaces = [
      {
        name                = local.naming.workspace_1
        resource_group_name = azurerm_resource_group.rg.name
        location            = local.location

        monitoring = [
          {
            diag_name                  = "Monitoring"
            log_analytics_workspace_id = azurerm_log_analytics_workspace.la.id
          }
        ]

        private_endpoint = [
          {
            name                          = "${local.naming.workspace_1}-PE01"
            subnet_id                     = azurerm_subnet.subnet.id
            custom_network_interface_name = "${local.naming.workspace_1}-PE01.nic"
            private_service_connection = [
              {
                name                 = "${local.naming.workspace_1}-PE01-connection"
                is_manual_connection = false
                subresource_names    = ["global"]
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

        tags = {}
      }
    ]
  }
}
