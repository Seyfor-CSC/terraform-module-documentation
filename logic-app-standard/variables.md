# Variables

```
variable "config" {  type = list(object({
    # logic app standard
    name                       = string
    resource_group_name        = string
    location                   = string
    app_service_plan_id        = string
    storage_account_name       = string
    storage_account_access_key = string
    app_settings               = optional(map(any))
    use_extension_bundle       = optional(bool)
    bundle_version             = optional(string)
    connection_string = optional(object({
      name  = string
      type  = string
      value = string
    }))
    client_affinity_enabled = optional(bool)
    client_certificate_mode = optional(string)
    enabled                 = optional(bool)
    https_only              = optional(bool)
    identity = optional(object({
      type         = string
      identity_ids = optional(list(string))
    }))
    site_config = optional(object({
      always_on       = optional(bool)
      app_scale_limit = optional(number)
      cors = optional(object({
        allowed_origins     = list(string)
        support_credentials = optional(bool)
      }))
      dotnet_framework_version = optional(string)
      elastic_instance_minimum = optional(number)
      ftps_state               = optional(string)
      health_check_path        = optional(string)
      http2_enabled            = optional(bool)
      ip_restriction = optional(list(object({
        ip_address                = optional(string)
        service_tag               = optional(string)
        virtual_network_subnet_id = optional(string)
        name                      = optional(string)
        priority                  = optional(number)
        action                    = optional(string)
        headers = optional(object({
          x_azure_fdid      = optional(list(string))
          x_fd_health_probe = optional(list(number))
          x_forwarded_for   = optional(list(string))
          x_forwarded_host  = optional(list(string))
        }))
      })))
      scm_ip_restriction = optional(list(object({
        ip_address                = optional(string)
        service_tag               = optional(string)
        virtual_network_subnet_id = optional(string)
        name                      = optional(string)
        priority                  = optional(number)
        action                    = optional(string)
        headers = optional(object({
          x_azure_fdid      = optional(list(string))
          x_fd_health_probe = optional(list(number))
          x_forwarded_for   = optional(list(string))
          x_forwarded_host  = optional(list(string))
        }))
      })))
      scm_use_main_ip_restriction      = optional(bool)
      scm_min_tls_version              = optional(string)
      scm_type                         = optional(string)
      linux_fx_version                 = optional(string)
      min_tls_version                  = optional(string)
      pre_warmed_instance_count        = optional(number)
      runtime_scale_monitoring_enabled = optional(bool)
      use_32_bit_worker_process        = optional(bool)
      vnet_route_all_enabled           = optional(bool)
      websockets_enabled               = optional(bool)
    }))
    storage_account_share_name = optional(string)
    version                    = optional(string)
    virtual_network_subnet_id  = optional(string)
    tags                       = optional(map(any))

    # monitoring
    monitoring = optional(list(object({                 # Custom object for enabling diagnostic settings
      diag_name                      = optional(string) # Name of the diagnostic setting
      log_analytics_workspace_id     = optional(string)
      eventhub_name                  = optional(string)
      eventhub_authorization_rule_id = optional(string)
    })), [])
  }))
}


```


## Table with config variables

| Name | Data Type | Requirement | Default Value | Comment |
| ------- | --------- | ----------- | ------------- | ------- |
|name | string | Required |  |  |
|resource_group_name | string | Required |  |  |
|location | string | Required |  |  |
|app_service_plan_id | string | Required |  |  |
|storage_account_name | string | Required |  |  |
|storage_account_access_key | string | Required |  |  |
|app_settings | map(any) | Optional |  |  |
|use_extension_bundle | bool | Optional |  |  |
|bundle_version | string | Optional |  |  |
|connection_string | object | Optional |  |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;type | string | Required |  |  |
|&nbsp;value | string | Required |  |  |
|client_affinity_enabled | bool | Optional |  |  |
|client_certificate_mode | string | Optional |  |  |
|enabled | bool | Optional |  |  |
|https_only | bool | Optional |  |  |
|identity | object | Optional |  |  |
|&nbsp;type | string | Required |  |  |
|&nbsp;identity_ids | list(string) | Optional |  |  |
|site_config | object | Optional |  |  |
|&nbsp;always_on | bool | Optional |  |  |
|&nbsp;app_scale_limit | number | Optional |  |  |
|&nbsp;cors | object | Optional |  |  |
|&nbsp;&nbsp;allowed_origins | list(string) | Required |  |  |
|&nbsp;&nbsp;support_credentials | bool | Optional |  |  |
|&nbsp;dotnet_framework_version | string | Optional |  |  |
|&nbsp;elastic_instance_minimum | number | Optional |  |  |
|&nbsp;ftps_state | string | Optional |  |  |
|&nbsp;health_check_path | string | Optional |  |  |
|&nbsp;http2_enabled | bool | Optional |  |  |
|&nbsp;ip_restriction | list(object) | Optional | [] |  |
|&nbsp;&nbsp;ip_address | string | Optional |  |  |
|&nbsp;&nbsp;service_tag | string | Optional |  |  |
|&nbsp;&nbsp;virtual_network_subnet_id | string | Optional |  |  |
|&nbsp;&nbsp;name | string | Optional |  |  |
|&nbsp;&nbsp;priority | number | Optional |  |  |
|&nbsp;&nbsp;action | string | Optional |  |  |
|&nbsp;&nbsp;headers | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;x_azure_fdid | list(string) | Optional |  |  |
|&nbsp;&nbsp;&nbsp;x_fd_health_probe | list(number) | Optional |  |  |
|&nbsp;&nbsp;&nbsp;x_forwarded_for | list(string) | Optional |  |  |
|&nbsp;&nbsp;&nbsp;x_forwarded_host | list(string) | Optional |  |  |
|&nbsp;scm_ip_restriction | list(object) | Optional | [] |  |
|&nbsp;&nbsp;ip_address | string | Optional |  |  |
|&nbsp;&nbsp;service_tag | string | Optional |  |  |
|&nbsp;&nbsp;virtual_network_subnet_id | string | Optional |  |  |
|&nbsp;&nbsp;name | string | Optional |  |  |
|&nbsp;&nbsp;priority | number | Optional |  |  |
|&nbsp;&nbsp;action | string | Optional |  |  |
|&nbsp;&nbsp;headers | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;x_azure_fdid | list(string) | Optional |  |  |
|&nbsp;&nbsp;&nbsp;x_fd_health_probe | list(number) | Optional |  |  |
|&nbsp;&nbsp;&nbsp;x_forwarded_for | list(string) | Optional |  |  |
|&nbsp;&nbsp;&nbsp;x_forwarded_host | list(string) | Optional |  |  |
|&nbsp;scm_use_main_ip_restriction | bool | Optional |  |  |
|&nbsp;scm_min_tls_version | string | Optional |  |  |
|&nbsp;scm_type | string | Optional |  |  |
|&nbsp;linux_fx_version | string | Optional |  |  |
|&nbsp;min_tls_version | string | Optional |  |  |
|&nbsp;pre_warmed_instance_count | number | Optional |  |  |
|&nbsp;runtime_scale_monitoring_enabled | bool | Optional |  |  |
|&nbsp;use_32_bit_worker_process | bool | Optional |  |  |
|&nbsp;vnet_route_all_enabled | bool | Optional |  |  |
|&nbsp;websockets_enabled | bool | Optional |  |  |
|storage_account_share_name | string | Optional |  |  |
|version | string | Optional |  |  |
|virtual_network_subnet_id | string | Optional |  |  |
|tags | map(any) | Optional |  |  |
|monitoring | list(object) | Optional | [] |  Custom object for enabling diagnostic settings |
|&nbsp;diag_name | string | Optional |  |  Name of the diagnostic setting |
|&nbsp;log_analytics_workspace_id | string | Optional |  |  |
|&nbsp;eventhub_name | string | Optional |  |  |
|&nbsp;eventhub_authorization_rule_id | string | Optional |  |  |


