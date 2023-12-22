# Variables

```
variable "config" {  type = object({
    # virtual desktop host pool
    host_pools = optional(list(object({
      name                             = string
      resource_group_name              = string
      location                         = string
      type                             = string
      load_balancer_type               = string
      friendly_name                    = optional(string)
      description                      = optional(string)
      validate_environment             = optional(bool)
      start_vm_on_connect              = optional(bool)
      custom_rdp_properties            = optional(string)
      personal_desktop_assignment_type = optional(string)
      maximum_sessions_allowed         = optional(number)
      preferred_app_group_type         = optional(string)
      scheduled_agent_updates = optional(object({
        enabled                   = optional(bool)
        timezone                  = optional(string)
        use_session_host_timezone = optional(bool)
        schedule = optional(list(object({
          day_of_week = string
          hour_of_day = number
        })), [])
      }))
      tags = optional(map(any))

      # virtual desktop application group
      application_groups = optional(list(object({
        name                         = string
        resource_group_name          = optional(string) # If not provided, inherited in module from parent resource
        location                     = optional(string) # Inherited in module from parent resource
        type                         = string
        host_pool_id                 = optional(string) # Inherited in module from parent resource
        friendly_name                = optional(string)
        default_desktop_display_name = optional(string)
        description                  = optional(string)
        tags                         = optional(map(any)) # If not provided, inherited in module from parent resource

        # virtual desktop workspace application group association
        associations = optional(list(object({
          workspace_id         = optional(string) # Do not use, is replaced by workspace_name parameter
          workspace_name       = string           # Custom variable replacing workspace_id parameter. Workspace name, which is being created in this virtual desktop, is required
          application_group_id = optional(string) # Inherited in module from parent resource
        })), [])

        # monitoring
        monitoring = optional(list(object({                 # Custom object for enabling diagnostic settings
          diag_name                      = optional(string) # Name of the diagnostic setting
          log_analytics_workspace_id     = optional(string)
          eventhub_name                  = optional(string)
          eventhub_authorization_rule_id = optional(string)
        })), [])
      })), [])

      # virtual desktop host pool registration info
      registration_info = optional(object({
        expiration_date = string
        hostpool_id     = optional(string) # Inherited in module from parent resource
      }))

      # monitoring
      monitoring = optional(list(object({                 # Custom object for enabling diagnostic settings
        diag_name                      = optional(string) # Name of the diagnostic setting
        log_analytics_workspace_id     = optional(string)
        eventhub_name                  = optional(string)
        eventhub_authorization_rule_id = optional(string)
      })), [])

      # private endpoint
      private_endpoint = optional(list(object({
        name                = string
        resource_group_name = optional(string) # If not provided, inherited in module from parent resource
        location            = optional(string) # If not provided, inherited in module from parent resource
        subnet_id           = string
        private_service_connection = list(object({
          name                              = string
          is_manual_connection              = bool
          private_connection_resource_id    = optional(string)
          private_connection_resource_alias = optional(string)
          subresource_names                 = optional(list(string))
          request_message                   = optional(string)
        }))
        custom_network_interface_name = optional(string)
        private_dns_zone_group = optional(object({
          name                 = string
          private_dns_zone_ids = list(string)
        }))
        ip_configuration = optional(list(object({
          name               = string
          private_ip_address = string
          subresource_name   = string
          member_name        = optional(string)
        })), [])
        tags = optional(map(any)) # If not provided, inherited in module from parent resource
      })), [])
    })), [])

    # virtual desktop scaling plan
    scaling_plans = optional(list(object({
      name                = string
      resource_group_name = string
      location            = string
      schedule = list(object({
        days_of_week                         = list(string)
        name                                 = string
        off_peak_load_balancing_algorithm    = string
        off_peak_start_time                  = string
        peak_load_balancing_algorithm        = string
        peak_start_time                      = string
        ramp_down_capacity_threshold_percent = number
        ramp_down_force_logoff_users         = bool
        ramp_down_load_balancing_algorithm   = string
        ramp_down_minimum_hosts_percent      = number
        ramp_down_notification_message       = string
        ramp_down_start_time                 = string
        ramp_down_stop_hosts_when            = string
        ramp_down_wait_time_minutes          = number
        ramp_up_load_balancing_algorithm     = string
        ramp_up_start_time                   = string
        ramp_up_capacity_threshold_percent   = optional(number)
        ramp_up_minimum_hosts_percent        = optional(number)
      }))
      time_zone     = string
      description   = optional(string)
      exclusion_tag = optional(string)
      friendly_name = optional(string)
      host_pool = optional(list(object({
        hostpool_id          = optional(string) # Do not use, is replaced by hostpool_name parameter
        hostpool_name        = string           # Custom variable replacing hostpool_id parameter. Hostpool name, which is being created in this virtual desktop host pool, is required
        scaling_plan_enabled = bool
      })), [])
      tags          = optional(map(any))

      # monitoring
      monitoring = optional(list(object({                 # Custom object for enabling diagnostic settings
        diag_name                      = optional(string) # Name of the diagnostic setting
        log_analytics_workspace_id     = optional(string)
        eventhub_name                  = optional(string)
        eventhub_authorization_rule_id = optional(string)
      })), [])
    })), [])

    # virtual desktop workspace
    workspaces = optional(list(object({
      name                          = string
      resource_group_name           = string
      location                      = string
      friendly_name                 = optional(string)
      description                   = optional(string)
      public_network_access_enabled = optional(bool, false)
      tags                          = optional(map(any))

      # monitoring
      monitoring = optional(list(object({                 # Custom object for enabling diagnostic settings
        diag_name                      = optional(string) # Name of the diagnostic setting
        log_analytics_workspace_id     = optional(string)
        eventhub_name                  = optional(string)
        eventhub_authorization_rule_id = optional(string)
      })), [])

      # private endpoint
      private_endpoint = optional(list(object({
        name                = string
        resource_group_name = optional(string) # If not provided, inherited in module from parent resource
        location            = optional(string) # If not provided, inherited in module from parent resource
        subnet_id           = string
        private_service_connection = list(object({
          name                              = string
          is_manual_connection              = bool
          private_connection_resource_id    = optional(string)
          private_connection_resource_alias = optional(string)
          subresource_names                 = optional(list(string))
          request_message                   = optional(string)
        }))
        custom_network_interface_name = optional(string)
        private_dns_zone_group = optional(object({
          name                 = string
          private_dns_zone_ids = list(string)
        }))
        ip_configuration = optional(list(object({
          name               = string
          private_ip_address = string
          subresource_name   = string
          member_name        = optional(string)
        })), [])
        tags = optional(map(any)) # If not provided, inherited in module from parent resource
      })), [])
    })), [])
  })
}


```


## Table with config variables

| Name | Data Type | Requirement | Default Value | Comment |
| ------- | --------- | ----------- | ------------- | ------- |
|host_pools | list(object) | Optional | [] |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;resource_group_name | string | Required |  |  |
|&nbsp;location | string | Required |  |  |
|&nbsp;type | string | Required |  |  |
|&nbsp;load_balancer_type | string | Required |  |  |
|&nbsp;friendly_name | string | Optional |  |  |
|&nbsp;description | string | Optional |  |  |
|&nbsp;validate_environment | bool | Optional |  |  |
|&nbsp;start_vm_on_connect | bool | Optional |  |  |
|&nbsp;custom_rdp_properties | string | Optional |  |  |
|&nbsp;personal_desktop_assignment_type | string | Optional |  |  |
|&nbsp;maximum_sessions_allowed | number | Optional |  |  |
|&nbsp;preferred_app_group_type | string | Optional |  |  |
|&nbsp;scheduled_agent_updates | object | Optional |  |  |
|&nbsp;&nbsp;enabled | bool | Optional |  |  |
|&nbsp;&nbsp;timezone | string | Optional |  |  |
|&nbsp;&nbsp;use_session_host_timezone | bool | Optional |  |  |
|&nbsp;&nbsp;schedule | list(object) | Optional | [] |  |
|&nbsp;&nbsp;&nbsp;day_of_week | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;hour_of_day | number | Required |  |  |
|&nbsp;tags | map(any) | Optional |  |  |
|&nbsp;application_groups | list(object) | Optional | [] |  |
|&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;resource_group_name | string | Optional |  |  If not provided, inherited in module from parent resource |
|&nbsp;&nbsp;location | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;&nbsp;type | string | Required |  |  |
|&nbsp;&nbsp;host_pool_id | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;&nbsp;friendly_name | string | Optional |  |  |
|&nbsp;&nbsp;default_desktop_display_name | string | Optional |  |  |
|&nbsp;&nbsp;description | string | Optional |  |  |
|&nbsp;&nbsp;tags | map(any) | Optional |  |  If not provided, inherited in module from parent resource |
|&nbsp;&nbsp;associations | list(object) | Optional | [] |  |
|&nbsp;&nbsp;&nbsp;workspace_id | string | Optional |  |  Do not use, is replaced by workspace_name parameter |
|&nbsp;&nbsp;&nbsp;workspace_name | string | Required |  |  Custom variable replacing workspace_id parameter. Workspace name, which is being created in this virtual desktop, is required |
|&nbsp;&nbsp;&nbsp;application_group_id | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;&nbsp;monitoring | list(object) | Optional | [] |  Custom object for enabling diagnostic settings |
|&nbsp;&nbsp;&nbsp;diag_name | string | Optional |  |  Name of the diagnostic setting |
|&nbsp;&nbsp;&nbsp;log_analytics_workspace_id | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;eventhub_name | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;eventhub_authorization_rule_id | string | Optional |  |  |
|&nbsp;registration_info | object | Optional |  |  |
|&nbsp;&nbsp;expiration_date | string | Required |  |  |
|&nbsp;&nbsp;hostpool_id | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;monitoring | list(object) | Optional | [] |  Custom object for enabling diagnostic settings |
|&nbsp;&nbsp;diag_name | string | Optional |  |  Name of the diagnostic setting |
|&nbsp;&nbsp;log_analytics_workspace_id | string | Optional |  |  |
|&nbsp;&nbsp;eventhub_name | string | Optional |  |  |
|&nbsp;&nbsp;eventhub_authorization_rule_id | string | Optional |  |  |
|&nbsp;private_endpoint | list(object) | Optional | [] |  |
|&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;resource_group_name | string | Optional |  |  If not provided, inherited in module from parent resource |
|&nbsp;&nbsp;location | string | Optional |  |  If not provided, inherited in module from parent resource |
|&nbsp;&nbsp;subnet_id | string | Required |  |  |
|&nbsp;&nbsp;private_service_connection | list(object) | Required |  |  |
|&nbsp;&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;is_manual_connection | bool | Required |  |  |
|&nbsp;&nbsp;&nbsp;private_connection_resource_id | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;private_connection_resource_alias | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;subresource_names | list(string) | Optional |  |  |
|&nbsp;&nbsp;&nbsp;request_message | string | Optional |  |  |
|&nbsp;&nbsp;custom_network_interface_name | string | Optional |  |  |
|&nbsp;&nbsp;private_dns_zone_group | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;private_dns_zone_ids | list(string) | Required |  |  |
|&nbsp;&nbsp;ip_configuration | list(object) | Optional | [] |  |
|&nbsp;&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;private_ip_address | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;subresource_name | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;member_name | string | Optional |  |  |
|&nbsp;&nbsp;tags | map(any) | Optional |  |  If not provided, inherited in module from parent resource |
|scaling_plans | list(object) | Optional | [] |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;resource_group_name | string | Required |  |  |
|&nbsp;location | string | Required |  |  |
|&nbsp;schedule | list(object) | Required |  |  |
|&nbsp;&nbsp;days_of_week | list(string) | Required |  |  |
|&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;off_peak_load_balancing_algorithm | string | Required |  |  |
|&nbsp;&nbsp;off_peak_start_time | string | Required |  |  |
|&nbsp;&nbsp;peak_load_balancing_algorithm | string | Required |  |  |
|&nbsp;&nbsp;peak_start_time | string | Required |  |  |
|&nbsp;&nbsp;ramp_down_capacity_threshold_percent | number | Required |  |  |
|&nbsp;&nbsp;ramp_down_force_logoff_users | bool | Required |  |  |
|&nbsp;&nbsp;ramp_down_load_balancing_algorithm | string | Required |  |  |
|&nbsp;&nbsp;ramp_down_minimum_hosts_percent | number | Required |  |  |
|&nbsp;&nbsp;ramp_down_notification_message | string | Required |  |  |
|&nbsp;&nbsp;ramp_down_start_time | string | Required |  |  |
|&nbsp;&nbsp;ramp_down_stop_hosts_when | string | Required |  |  |
|&nbsp;&nbsp;ramp_down_wait_time_minutes | number | Required |  |  |
|&nbsp;&nbsp;ramp_up_load_balancing_algorithm | string | Required |  |  |
|&nbsp;&nbsp;ramp_up_start_time | string | Required |  |  |
|&nbsp;&nbsp;ramp_up_capacity_threshold_percent | number | Optional |  |  |
|&nbsp;&nbsp;ramp_up_minimum_hosts_percent | number | Optional |  |  |
|&nbsp;time_zone | string | Required |  |  |
|&nbsp;description | string | Optional |  |  |
|&nbsp;exclusion_tag | string | Optional |  |  |
|&nbsp;friendly_name | string | Optional |  |  |
|&nbsp;host_pool | list(object) | Optional | [] |  |
|&nbsp;&nbsp;hostpool_id | string | Optional |  |  Do not use, is replaced by hostpool_name parameter |
|&nbsp;&nbsp;hostpool_name | string | Required |  |  Custom variable replacing hostpool_id parameter. Hostpool name, which is being created in this virtual desktop host pool, is required |
|&nbsp;&nbsp;scaling_plan_enabled | bool | Required |  |  |
|&nbsp;tags | map(any) | Optional |  |  |
|&nbsp;monitoring | list(object) | Optional | [] |  Custom object for enabling diagnostic settings |
|&nbsp;&nbsp;diag_name | string | Optional |  |  Name of the diagnostic setting |
|&nbsp;&nbsp;log_analytics_workspace_id | string | Optional |  |  |
|&nbsp;&nbsp;eventhub_name | string | Optional |  |  |
|&nbsp;&nbsp;eventhub_authorization_rule_id | string | Optional |  |  |
|workspaces | list(object) | Optional | [] |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;resource_group_name | string | Required |  |  |
|&nbsp;location | string | Required |  |  |
|&nbsp;friendly_name | string | Optional |  |  |
|&nbsp;description | string | Optional |  |  |
|&nbsp;public_network_access_enabled | bool | Optional |  false |  |
|&nbsp;tags | map(any) | Optional |  |  |
|&nbsp;monitoring | list(object) | Optional | [] |  Custom object for enabling diagnostic settings |
|&nbsp;&nbsp;diag_name | string | Optional |  |  Name of the diagnostic setting |
|&nbsp;&nbsp;log_analytics_workspace_id | string | Optional |  |  |
|&nbsp;&nbsp;eventhub_name | string | Optional |  |  |
|&nbsp;&nbsp;eventhub_authorization_rule_id | string | Optional |  |  |
|&nbsp;private_endpoint | list(object) | Optional | [] |  |
|&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;resource_group_name | string | Optional |  |  If not provided, inherited in module from parent resource |
|&nbsp;&nbsp;location | string | Optional |  |  If not provided, inherited in module from parent resource |
|&nbsp;&nbsp;subnet_id | string | Required |  |  |
|&nbsp;&nbsp;private_service_connection | list(object) | Required |  |  |
|&nbsp;&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;is_manual_connection | bool | Required |  |  |
|&nbsp;&nbsp;&nbsp;private_connection_resource_id | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;private_connection_resource_alias | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;subresource_names | list(string) | Optional |  |  |
|&nbsp;&nbsp;&nbsp;request_message | string | Optional |  |  |
|&nbsp;&nbsp;custom_network_interface_name | string | Optional |  |  |
|&nbsp;&nbsp;private_dns_zone_group | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;private_dns_zone_ids | list(string) | Required |  |  |
|&nbsp;&nbsp;ip_configuration | list(object) | Optional | [] |  |
|&nbsp;&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;private_ip_address | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;subresource_name | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;member_name | string | Optional |  |  |
|&nbsp;&nbsp;tags | map(any) | Optional |  |  If not provided, inherited in module from parent resource |


