# Variables

```
variable "config" {  type = list(object({
    # service plan
    name                         = string
    resource_group_name          = string
    location                     = string
    os_type                      = string
    sku_name                     = string
    app_service_environment_id   = optional(string)
    maximum_elastic_worker_count = optional(number)
    worker_count                 = optional(number)
    per_site_scaling_enabled     = optional(bool)
    zone_balancing_enabled       = optional(bool)
    tags                         = optional(map(any))

    # web app
    web_app = optional(list(object({
      name                = string
      resource_group_name = optional(string) # If not provided, inherited in module from parent resource
      location            = optional(string) # Inherited in module from parent resource
      service_plan_id     = optional(string) # Inherited in module from parent resource
      site_config = object({
        application_stack = optional(object({
          current_stack                = optional(string) # Windows Web App only
          docker_image_name            = optional(string)
          docker_registry_url          = optional(string)
          docker_registry_username     = optional(string)
          docker_registry_password     = optional(string)
          dotnet_version               = optional(string)
          dotnet_core_version          = optional(string) # Windows Web App only
          go_version                   = optional(string) # Linux Web App only
          tomcat_version               = optional(string) # Windows Web App only
          java_embedded_server_enabled = optional(bool)   # Windows Web App only
          java_version                 = optional(string) # Windows Web App only
          java_server                  = optional(string) # Linux Web App only
          java_server_version          = optional(string) # Linux Web App only
          node_version                 = optional(string)
          php_version                  = optional(string)
          python                       = optional(bool)   # Windows Web App only
          python_version               = optional(string) # Linux Web App only
          ruby_version                 = optional(string) # Linux Web App only
        }))
        cors = optional(object({
          allowed_origins     = list(string)
          support_credentials = optional(bool)
        }))
        ftps_state = optional(string)
        http2_enabled = optional(bool)
        ip_restriction = optional(list(object({
          name   = string # Is required for looping purposes. Has to be a unique value per web app
          action = optional(string)
          headers = optional(object({
            x_azure_fdid      = optional(list(string))
            x_fd_health_probe = optional(number)
            x_forwarded_for   = optional(list(string))
            x_forwarded_host  = optional(list(string))
          }))
          ip_address                = optional(string)
          priority                  = optional(number)
          service_tag               = optional(string)
          virtual_network_subnet_id = optional(string)
        })), [])
        vnet_route_all_enabled = optional(bool)
      })
      app_settings = optional(map(any))
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
      client_affinity_enabled = optional(bool)
      connection_string = optional(list(object({
        name  = string
        type  = string
        value = string
      })), [])
      https_only                    = optional(bool)
      public_network_access_enabled = optional(bool)
      identity = optional(object({
        type         = string
        identity_ids = optional(list(string))
      }))
      key_vault_reference_identity_id = optional(string)
      logs = optional(object({
        application_logs = optional(object({
          azure_blob_storage = optional(object({
            level             = string
            retention_in_days = number
            sas_url           = string
          }))
          file_system_level = string
        }))
        detailed_error_messages = optional(bool)
        failed_request_tracing  = optional(bool)
        http_logs = optional(object({
          azure_blob_storage = optional(object({
            retention_in_days = optional(number)
            sas_url           = string
          }))
          file_system = optional(object({
            retention_in_days = number
            retention_in_mb   = number
          }))
        }))
      }))
      virtual_network_subnet_id = optional(string)
      tags = optional(map(any)) # If not provided, inherited in module from parent resource

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
        private_dns_zone_group = optional(list(object({
          name                 = string
          private_dns_zone_ids = list(string)
        })), [])
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
      })), [])
    })), [])
    })
  )
}


```


## Table with config variables

| Name | Data Type | Requirement | Default Value | Comment |
| ------- | --------- | ----------- | ------------- | ------- |
|name | string | Required |  |  |
|resource_group_name | string | Required |  |  |
|location | string | Required |  |  |
|os_type | string | Required |  |  |
|sku_name | string | Required |  |  |
|app_service_environment_id | string | Optional |  |  |
|maximum_elastic_worker_count | number | Optional |  |  |
|worker_count | number | Optional |  |  |
|per_site_scaling_enabled | bool | Optional |  |  |
|zone_balancing_enabled | bool | Optional |  |  |
|tags | map(any) | Optional |  |  |
|web_app | list(object) | Optional | [] |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;resource_group_name | string | Optional |  |  If not provided, inherited in module from parent resource |
|&nbsp;location | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;service_plan_id | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;site_config | object | Required |  |  |
|&nbsp;&nbsp;application_stack | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;current_stack | string | Optional |  |  Windows Web App only |
|&nbsp;&nbsp;&nbsp;docker_image_name | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;docker_registry_url | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;docker_registry_username | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;docker_registry_password | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;dotnet_version | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;dotnet_core_version | string | Optional |  |  Windows Web App only |
|&nbsp;&nbsp;&nbsp;go_version | string | Optional |  |  Linux Web App only |
|&nbsp;&nbsp;&nbsp;tomcat_version | string | Optional |  |  Windows Web App only |
|&nbsp;&nbsp;&nbsp;java_embedded_server_enabled | bool | Optional |  |  Windows Web App only |
|&nbsp;&nbsp;&nbsp;java_version | string | Optional |  |  Windows Web App only |
|&nbsp;&nbsp;&nbsp;java_server | string | Optional |  |  Linux Web App only |
|&nbsp;&nbsp;&nbsp;java_server_version | string | Optional |  |  Linux Web App only |
|&nbsp;&nbsp;&nbsp;node_version | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;php_version | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;python | bool | Optional |  |  Windows Web App only |
|&nbsp;&nbsp;&nbsp;python_version | string | Optional |  |  Linux Web App only |
|&nbsp;&nbsp;&nbsp;ruby_version | string | Optional |  |  Linux Web App only |
|&nbsp;&nbsp;cors | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;allowed_origins | list(string) | Required |  |  |
|&nbsp;&nbsp;&nbsp;support_credentials | bool | Optional |  |  |
|&nbsp;&nbsp;ftps_state | string | Optional |  |  |
|&nbsp;&nbsp;http2_enabled | bool | Optional |  |  |
|&nbsp;&nbsp;ip_restriction | list(object) | Optional | [] |  |
|&nbsp;&nbsp;&nbsp;name | string | Required |  |  Is required for looping purposes. Has to be a unique value per web app |
|&nbsp;&nbsp;&nbsp;action | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;headers | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;x_azure_fdid | list(string) | Optional |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;x_fd_health_probe | number | Optional |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;x_forwarded_for | list(string) | Optional |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;x_forwarded_host | list(string) | Optional |  |  |
|&nbsp;&nbsp;&nbsp;ip_address | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;priority | number | Optional |  |  |
|&nbsp;&nbsp;&nbsp;service_tag | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;virtual_network_subnet_id | string | Optional |  |  |
|&nbsp;&nbsp;vnet_route_all_enabled | bool | Optional |  |  |
|&nbsp;app_settings | map(any) | Optional |  |  |
|&nbsp;backup | object | Optional |  |  |
|&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;schedule | object | Required |  |  |
|&nbsp;&nbsp;&nbsp;frequency_interval | number | Required |  |  |
|&nbsp;&nbsp;&nbsp;frequency_unit | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;keep_at_least_one_backup | bool | Optional |  |  |
|&nbsp;&nbsp;&nbsp;retention_period_days | number | Optional |  |  |
|&nbsp;&nbsp;&nbsp;start_time | string | Optional |  |  |
|&nbsp;&nbsp;storage_account_url | string | Required |  |  |
|&nbsp;&nbsp;enabled | bool | Optional |  |  |
|&nbsp;client_affinity_enabled | bool | Optional |  |  |
|&nbsp;connection_string | list(object) | Optional | [] |  |
|&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;type | string | Required |  |  |
|&nbsp;&nbsp;value | string | Required |  |  |
|&nbsp;https_only | bool | Optional |  |  |
|&nbsp;public_network_access_enabled | bool | Optional |  |  |
|&nbsp;identity | object | Optional |  |  |
|&nbsp;&nbsp;type | string | Required |  |  |
|&nbsp;&nbsp;identity_ids | list(string) | Optional |  |  |
|&nbsp;key_vault_reference_identity_id | string | Optional |  |  |
|&nbsp;logs | object | Optional |  |  |
|&nbsp;&nbsp;application_logs | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;azure_blob_storage | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;level | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;retention_in_days | number | Required |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;sas_url | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;file_system_level | string | Required |  |  |
|&nbsp;&nbsp;detailed_error_messages | bool | Optional |  |  |
|&nbsp;&nbsp;failed_request_tracing | bool | Optional |  |  |
|&nbsp;&nbsp;http_logs | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;azure_blob_storage | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;retention_in_days | number | Optional |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;sas_url | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;file_system | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;retention_in_days | number | Required |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;retention_in_mb | number | Required |  |  |
|&nbsp;virtual_network_subnet_id | string | Optional |  |  |
|&nbsp;tags | map(any) | Optional |  |  If not provided, inherited in module from parent resource |
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
|&nbsp;&nbsp;private_dns_zone_group | list(object) | Optional | [] |  |
|&nbsp;&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;private_dns_zone_ids | list(string) | Required |  |  |
|&nbsp;&nbsp;ip_configuration | list(object) | Optional | [] |  |
|&nbsp;&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;private_ip_address | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;subresource_name | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;member_name | string | Optional |  |  |
|&nbsp;&nbsp;tags | map(any) | Optional |  |  If not provided, inherited in module from parent resource |
|&nbsp;monitoring | list(object) | Optional | [] |  Custom object for enabling diagnostic settings |
|&nbsp;&nbsp;diag_name | string | Optional |  |  Name of the diagnostic setting |
|&nbsp;&nbsp;log_analytics_workspace_id | string | Optional |  |  |
|&nbsp;&nbsp;eventhub_name | string | Optional |  |  |
|&nbsp;&nbsp;eventhub_authorization_rule_id | string | Optional |  |  |


