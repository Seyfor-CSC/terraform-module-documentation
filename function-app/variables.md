# Variables

```
variable "config" {  type = list(object({
    # function app
    os_type             = string # Custom variable. Possible values are "Windows" or "Linux"
    name                = string
    resource_group_name = string
    location            = string
    service_plan_id     = string
    site_config = object({
      always_on                              = optional(bool)
      api_definition_url                     = optional(string)
      api_management_api_id                  = optional(string)
      app_command_line                       = optional(string)
      app_scale_limit                        = optional(number)
      application_insights_connection_string = optional(string)
      application_insights_key               = optional(string)
      application_stack = optional(object({
        docker = optional(list(object({ # Linux only
          registry_url      = string
          image_name        = string
          image_tag         = string
          registry_username = optional(string)
          registry_password = optional(string)
        })), [])
        dotnet_version              = optional(string)
        use_dotnet_isolated_runtime = optional(bool)
        java_version                = optional(string)
        node_version                = optional(string)
        python_version              = optional(string) # Linux only
        powershell_core_version     = optional(string)
        use_custom_runtime          = optional(bool)
      }))
      app_service_logs = optional(object({
        disk_quota_mb         = optional(number)
        retention_period_days = optional(number)
      }))
      container_registry_managed_identity_client_id = optional(string) # Linux only
      container_registry_use_managed_identity       = optional(bool)   # Linux only
      cors = optional(object({
        allowed_origins     = optional(list(string))
        support_credentials = optional(bool)
      }))
      default_documents                 = optional(list(string))
      elastic_instance_minimum          = optional(number)
      ftps_state                        = optional(string)
      health_check_path                 = optional(string)
      health_check_eviction_time_in_min = optional(number)
      http2_enabled                     = optional(bool)
      ip_restriction = optional(list(object({
        action = optional(string)
        headers = optional(object({
          x_azure_fdid      = optional(list(string))
          x_fd_health_probe = optional(number)
          x_forwarded_for   = optional(list(string))
          x_forwarded_host  = optional(list(string))
        }))
        ip_address                = optional(string)
        name                      = optional(string)
        priority                  = optional(number)
        service_tag               = optional(string)
        virtual_network_subnet_id = optional(string)
        description               = optional(string)
      })), [])
      ip_restriction_default_action    = optional(string)
      load_balancing_mode              = optional(string)
      managed_pipeline_mode            = optional(string)
      minimum_tls_version              = optional(string)
      pre_warmed_instance_count        = optional(number)
      remote_debugging_enabled         = optional(bool)
      remote_debugging_version         = optional(string)
      runtime_scale_monitoring_enabled = optional(bool)
      scm_ip_restriction = optional(list(object({
        action = optional(string)
        headers = optional(object({
          x_azure_fdid      = optional(list(string))
          x_fd_health_probe = optional(number)
          x_forwarded_for   = optional(list(string))
          x_forwarded_host  = optional(list(string))
        }))
        ip_address                = optional(string)
        name                      = optional(string)
        priority                  = optional(number)
        service_tag               = optional(string)
        virtual_network_subnet_id = optional(string)
        description               = optional(string)
      })), [])
      scm_ip_restriction_default_action = optional(string)
      scm_minimum_tls_version           = optional(string)
      scm_use_main_ip_restriction       = optional(bool)
      use_32_bit_worker                 = optional(bool)
      vnet_route_all_enabled            = optional(bool)
      websockets_enabled                = optional(bool)
      worker_count                      = optional(number)
    })
    app_settings = optional(map(string))
    backup = optional(object({
      name = string
      schedule = object({
        frequency_interval       = number
        frequency_unit           = string
        keep_at_least_one_backup = optional(bool)
        retention_period_days    = optional(number)
        start_time               = optional(string)
      })
      storage_account_url = string
      enabled             = optional(bool)
    }))
    builtin_logging_enabled            = optional(bool)
    client_certificate_enabled         = optional(bool)
    client_certificate_mode            = optional(string)
    client_certificate_exclusion_paths = optional(string)
    connection_string = optional(list(object({
      name  = string
      type  = string
      value = string
    })), [])
    daily_memory_time_quota                  = optional(number)
    enabled                                  = optional(bool)
    content_share_force_disabled             = optional(bool)
    functions_extension_version              = optional(string)
    ftp_publish_basic_authentication_enabled = optional(bool)
    https_only                               = optional(bool)
    public_network_access_enabled            = optional(bool, false)
    identity = optional(object({
      type         = string
      identity_ids = optional(list(string))
    }))
    key_vault_reference_identity_id = optional(string)
    storage_account_access_key                     = optional(string)
    storage_account_name                           = optional(string)
    storage_uses_managed_identity                  = optional(bool)
    storage_key_vault_secret_id                    = optional(string)
    virtual_network_subnet_id                      = optional(string)
    vnet_image_pull_enabled                        = optional(bool)
    webdeploy_publish_basic_authentication_enabled = optional(bool)
    zip_deploy_file                                = optional(string)
    tags                                           = optional(map(any))

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

    # monitoring
    monitoring = optional(list(object({                 # Custom object for enabling diagnostic settings
      diag_name                      = optional(string) # Name of the diagnostic setting
      log_analytics_workspace_id     = optional(string)
      eventhub_name                  = optional(string)
      eventhub_authorization_rule_id = optional(string)
      storage_account_id             = optional(string)
      categories = optional(object({
        function_app_logs               = optional(bool, true)
        app_service_authentication_logs = optional(bool, false)
        all_metrics                     = optional(bool, true)
      }))
    })), [])
  }))
}


```


## Table with config variables

| Name | Data Type | Requirement | Default Value | Comment |
| ------- | --------- | ----------- | ------------- | ------- |
|os_type | string | Required |  |  Custom variable. Possible values are "Windows" or "Linux" |
|name | string | Required |  |  |
|resource_group_name | string | Required |  |  |
|location | string | Required |  |  |
|service_plan_id | string | Required |  |  |
|site_config | object | Required |  |  |
|&nbsp;always_on | bool | Optional |  |  |
|&nbsp;api_definition_url | string | Optional |  |  |
|&nbsp;api_management_api_id | string | Optional |  |  |
|&nbsp;app_command_line | string | Optional |  |  |
|&nbsp;app_scale_limit | number | Optional |  |  |
|&nbsp;application_insights_connection_string | string | Optional |  |  |
|&nbsp;application_insights_key | string | Optional |  |  |
|&nbsp;application_stack | object | Optional |  |  |
|&nbsp;&nbsp;docker | list(object) | Optional | [] |  Linux only |
|&nbsp;&nbsp;&nbsp;registry_url | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;image_name | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;image_tag | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;registry_username | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;registry_password | string | Optional |  |  |
|&nbsp;&nbsp;dotnet_version | string | Optional |  |  |
|&nbsp;&nbsp;use_dotnet_isolated_runtime | bool | Optional |  |  |
|&nbsp;&nbsp;java_version | string | Optional |  |  |
|&nbsp;&nbsp;node_version | string | Optional |  |  |
|&nbsp;&nbsp;python_version | string | Optional |  |  Linux only |
|&nbsp;&nbsp;powershell_core_version | string | Optional |  |  |
|&nbsp;&nbsp;use_custom_runtime | bool | Optional |  |  |
|&nbsp;app_service_logs | object | Optional |  |  |
|&nbsp;&nbsp;disk_quota_mb | number | Optional |  |  |
|&nbsp;&nbsp;retention_period_days | number | Optional |  |  |
|&nbsp;container_registry_managed_identity_client_id | string | Optional |  |  Linux only |
|&nbsp;container_registry_use_managed_identity | bool | Optional |  |  Linux only |
|&nbsp;cors | object | Optional |  |  |
|&nbsp;&nbsp;allowed_origins | list(string) | Optional |  |  |
|&nbsp;&nbsp;support_credentials | bool | Optional |  |  |
|&nbsp;default_documents | list(string) | Optional |  |  |
|&nbsp;elastic_instance_minimum | number | Optional |  |  |
|&nbsp;ftps_state | string | Optional |  |  |
|&nbsp;health_check_path | string | Optional |  |  |
|&nbsp;health_check_eviction_time_in_min | number | Optional |  |  |
|&nbsp;http2_enabled | bool | Optional |  |  |
|&nbsp;ip_restriction | list(object) | Optional | [] |  |
|&nbsp;&nbsp;action | string | Optional |  |  |
|&nbsp;&nbsp;headers | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;x_azure_fdid | list(string) | Optional |  |  |
|&nbsp;&nbsp;&nbsp;x_fd_health_probe | number | Optional |  |  |
|&nbsp;&nbsp;&nbsp;x_forwarded_for | list(string) | Optional |  |  |
|&nbsp;&nbsp;&nbsp;x_forwarded_host | list(string) | Optional |  |  |
|&nbsp;&nbsp;ip_address | string | Optional |  |  |
|&nbsp;&nbsp;name | string | Optional |  |  |
|&nbsp;&nbsp;priority | number | Optional |  |  |
|&nbsp;&nbsp;service_tag | string | Optional |  |  |
|&nbsp;&nbsp;virtual_network_subnet_id | string | Optional |  |  |
|&nbsp;&nbsp;description | string | Optional |  |  |
|&nbsp;ip_restriction_default_action | string | Optional |  |  |
|&nbsp;load_balancing_mode | string | Optional |  |  |
|&nbsp;managed_pipeline_mode | string | Optional |  |  |
|&nbsp;minimum_tls_version | string | Optional |  |  |
|&nbsp;pre_warmed_instance_count | number | Optional |  |  |
|&nbsp;remote_debugging_enabled | bool | Optional |  |  |
|&nbsp;remote_debugging_version | string | Optional |  |  |
|&nbsp;runtime_scale_monitoring_enabled | bool | Optional |  |  |
|&nbsp;scm_ip_restriction | list(object) | Optional | [] |  |
|&nbsp;&nbsp;action | string | Optional |  |  |
|&nbsp;&nbsp;headers | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;x_azure_fdid | list(string) | Optional |  |  |
|&nbsp;&nbsp;&nbsp;x_fd_health_probe | number | Optional |  |  |
|&nbsp;&nbsp;&nbsp;x_forwarded_for | list(string) | Optional |  |  |
|&nbsp;&nbsp;&nbsp;x_forwarded_host | list(string) | Optional |  |  |
|&nbsp;&nbsp;ip_address | string | Optional |  |  |
|&nbsp;&nbsp;name | string | Optional |  |  |
|&nbsp;&nbsp;priority | number | Optional |  |  |
|&nbsp;&nbsp;service_tag | string | Optional |  |  |
|&nbsp;&nbsp;virtual_network_subnet_id | string | Optional |  |  |
|&nbsp;&nbsp;description | string | Optional |  |  |
|&nbsp;scm_ip_restriction_default_action | string | Optional |  |  |
|&nbsp;scm_minimum_tls_version | string | Optional |  |  |
|&nbsp;scm_use_main_ip_restriction | bool | Optional |  |  |
|&nbsp;use_32_bit_worker | bool | Optional |  |  |
|&nbsp;vnet_route_all_enabled | bool | Optional |  |  |
|&nbsp;websockets_enabled | bool | Optional |  |  |
|&nbsp;worker_count | number | Optional |  |  |
|app_settings | map(string) | Optional |  |  |
|backup | object | Optional |  |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;schedule | object | Required |  |  |
|&nbsp;&nbsp;frequency_interval | number | Required |  |  |
|&nbsp;&nbsp;frequency_unit | string | Required |  |  |
|&nbsp;&nbsp;keep_at_least_one_backup | bool | Optional |  |  |
|&nbsp;&nbsp;retention_period_days | number | Optional |  |  |
|&nbsp;&nbsp;start_time | string | Optional |  |  |
|&nbsp;storage_account_url | string | Required |  |  |
|&nbsp;enabled | bool | Optional |  |  |
|builtin_logging_enabled | bool | Optional |  |  |
|client_certificate_enabled | bool | Optional |  |  |
|client_certificate_mode | string | Optional |  |  |
|client_certificate_exclusion_paths | string | Optional |  |  |
|connection_string | list(object) | Optional | [] |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;type | string | Required |  |  |
|&nbsp;value | string | Required |  |  |
|daily_memory_time_quota | number | Optional |  |  |
|enabled | bool | Optional |  |  |
|content_share_force_disabled | bool | Optional |  |  |
|functions_extension_version | string | Optional |  |  |
|ftp_publish_basic_authentication_enabled | bool | Optional |  |  |
|https_only | bool | Optional |  |  |
|public_network_access_enabled | bool | Optional |  false |  |
|identity | object | Optional |  |  |
|&nbsp;type | string | Required |  |  |
|&nbsp;identity_ids | list(string) | Optional |  |  |
|key_vault_reference_identity_id | string | Optional |  |  |
|storage_account_access_key | string | Optional |  |  |
|storage_account_name | string | Optional |  |  |
|storage_uses_managed_identity | bool | Optional |  |  |
|storage_key_vault_secret_id | string | Optional |  |  |
|virtual_network_subnet_id | string | Optional |  |  |
|vnet_image_pull_enabled | bool | Optional |  |  |
|webdeploy_publish_basic_authentication_enabled | bool | Optional |  |  |
|zip_deploy_file | string | Optional |  |  |
|tags | map(any) | Optional |  |  |
|private_endpoint | list(object) | Optional | [] |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;resource_group_name | string | Optional |  |  If not provided, inherited in module from parent resource |
|&nbsp;location | string | Optional |  |  If not provided, inherited in module from parent resource |
|&nbsp;subnet_id | string | Required |  |  |
|&nbsp;private_service_connection | list(object) | Required |  |  |
|&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;is_manual_connection | bool | Required |  |  |
|&nbsp;&nbsp;private_connection_resource_id | string | Optional |  |  |
|&nbsp;&nbsp;private_connection_resource_alias | string | Optional |  |  |
|&nbsp;&nbsp;subresource_names | list(string) | Optional |  |  |
|&nbsp;&nbsp;request_message | string | Optional |  |  |
|&nbsp;custom_network_interface_name | string | Optional |  |  |
|&nbsp;private_dns_zone_group | object | Optional |  |  |
|&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;private_dns_zone_ids | list(string) | Required |  |  |
|&nbsp;ip_configuration | list(object) | Optional | [] |  |
|&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;private_ip_address | string | Required |  |  |
|&nbsp;&nbsp;subresource_name | string | Required |  |  |
|&nbsp;&nbsp;member_name | string | Optional |  |  |
|&nbsp;tags | map(any) | Optional |  |  If not provided, inherited in module from parent resource |
|monitoring | list(object) | Optional | [] |  Custom object for enabling diagnostic settings |
|&nbsp;diag_name | string | Optional |  |  Name of the diagnostic setting |
|&nbsp;log_analytics_workspace_id | string | Optional |  |  |
|&nbsp;eventhub_name | string | Optional |  |  |
|&nbsp;eventhub_authorization_rule_id | string | Optional |  |  |
|&nbsp;storage_account_id | string | Optional |  |  |
|&nbsp;categories | object | Optional |  |  |
|&nbsp;&nbsp;function_app_logs | bool | Optional |  true |  |
|&nbsp;&nbsp;app_service_authentication_logs | bool | Optional |  false |  |
|&nbsp;&nbsp;all_metrics | bool | Optional |  true |  |


