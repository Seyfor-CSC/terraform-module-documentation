# Variables

```
variable "config" {  type = list(object({
    # cdn frondoor profile
    name                = string
    resource_group_name = string
    sku_name            = string
    identity = optional(object({
      type         = string
      identity_ids = optional(list(string))
    }))
    response_timeout_seconds = optional(number)
    tags                     = optional(map(any))

    # cdn frontdoor endpoint
    endpoint = optional(list(object({
      name                     = string
      cdn_frontdoor_profile_id = optional(string) # Inherited in module from parent resource
      enabled                  = optional(bool)
      tags                     = optional(map(any)) # If not provided, inherited in module from parent resource
    })), [])

    # cdn frontdoor origin group
    origin_group = optional(list(object({
      name                     = string
      cdn_frontdoor_profile_id = optional(string) # Inherited in module from parent resource
      load_balancing = object({
        additional_latency_in_milliseconds = optional(number)
        sample_size                        = optional(number)
        successful_samples_required        = optional(number)
      })
      health_probe = optional(object({
        protocol            = string
        interval_in_seconds = number
        request_type        = optional(string)
        path                = optional(string)
      }))
      restore_traffic_time_to_healed_or_new_endpoint_in_minutes = optional(number)
      session_affinity_enabled                                  = optional(bool)

      # cdn frontdoor origin
      origin = optional(list(object({
        name                           = string
        cdn_frontdoor_origin_group_id  = optional(string) # Inherited in module from parent resource
        host_name                      = string
        certificate_name_check_enabled = bool
        enabled                        = optional(bool)
        http_port                      = optional(number)
        https_port                     = optional(number)
        origin_host_header             = optional(string)
        priority                       = optional(number)
        private_link = optional(object({
          request_message        = optional(string)
          target_type            = optional(string)
          location               = string
          private_link_target_id = string
        }))
        weight = optional(number)
      })), [])
    })), [])

    # cdn frontdoor route
    route = optional(list(object({
      name                            = string
      cdn_frontdoor_endpoint_id       = optional(string)           # Do not use, is replaced by cdn_frontdoor_endpoint_name parameter
      cdn_frontdoor_endpoint_name     = optional(string)           # Custom variable replacing cdn_frontdoor_endpoint_id parameter. Frontdoor endpoint name, which is being created in this frontdoor, is expected
      cdn_frontdoor_origin_group_id   = optional(string)           # Do not use, is replaced by cdn_frontdoor_origin_group_name parameter
      cdn_frontdoor_origin_group_name = optional(string)           # Custom variable replacing cdn_frontdoor_origin_group_id parameter. Frontdoor origin group name, which is being created in this frontdoor, is expected
      cdn_frontdoor_origin_ids        = optional(list(string))     # Do not use, is replaced by cdn_frontdoor_origin_names parameter
      cdn_frontdoor_origin_names      = optional(list(string), []) # Custom variable replacing cdn_frontdoor_origin_ids parameter. Frontdoor origin names, which are being created in this frontdoor, are expected
      patterns_to_match               = list(string)
      supported_protocols             = list(string)
      forwarding_protocol             = optional(string)
      cache = optional(object({
        query_string_caching_behavior = optional(string)
        query_strings                 = optional(list(string))
        compression_enabled           = optional(bool)
        content_types_to_compress     = optional(list(string))
      }))
      cdn_frontdoor_custom_domain_ids   = optional(list(string)) # Do not use, is replaced by cdn_frontdoor_custom_domain_names parameter
      cdn_frontdoor_custom_domain_names = optional(list(string)) # Custom variable replacing cdn_frontdoor_custom_domain_ids parameter. Frontdoor custom domain names, which are being created in this frontdoor, are expected
      cdn_frontdoor_origin_path         = optional(string)
      cdn_frontdoor_rule_set_ids        = optional(list(string))
      enabled                           = optional(bool)
      https_redirect_enabled            = optional(bool)
      link_to_default_domain            = optional(bool)
    })), [])

    # cdn frontdoor custom domain
    custom_domain = optional(list(object({
      name                     = string
      cdn_frontdoor_profile_id = optional(string) # Inherited in module from parent resource
      host_name                = string
      tls = object({
        certificate_type        = optional(string)
        minimum_tls_version     = optional(string)
        cdn_frontdoor_secret_id = optional(string)
      })
      dns_zone_id = optional(string)
    })), [])

    # monitoring
    monitoring = optional(list(object({                 # Custom object for enabling diagnostic settings
      diag_name                      = optional(string) # Name of the diagnostic setting
      log_analytics_workspace_id     = optional(string)
      eventhub_name                  = optional(string)
      eventhub_authorization_rule_id = optional(string)
      storage_account_id             = optional(string)
      categories = optional(object({
        front_door_access_log                   = optional(bool, true)
        front_door_helath_probe_log             = optional(bool, true)
        front_door_web_application_firewall_log = optional(bool, true)
        all_metrics                             = optional(bool, true)
      }))
    })), [])
  }))
}


```


## Table with config variables

| Name | Data Type | Requirement | Default Value | Comment |
| ------- | --------- | ----------- | ------------- | ------- |
|name | string | Required |  |  |
|resource_group_name | string | Required |  |  |
|sku_name | string | Required |  |  |
|identity | object | Optional |  |  |
|&nbsp;type | string | Required |  |  |
|&nbsp;identity_ids | list(string) | Optional |  |  |
|response_timeout_seconds | number | Optional |  |  |
|tags | map(any) | Optional |  |  |
|endpoint | list(object) | Optional | [] |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;cdn_frontdoor_profile_id | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;enabled | bool | Optional |  |  |
|&nbsp;tags | map(any) | Optional |  |  If not provided, inherited in module from parent resource |
|origin_group | list(object) | Optional | [] |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;cdn_frontdoor_profile_id | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;load_balancing | object | Required |  |  |
|&nbsp;&nbsp;additional_latency_in_milliseconds | number | Optional |  |  |
|&nbsp;&nbsp;sample_size | number | Optional |  |  |
|&nbsp;&nbsp;successful_samples_required | number | Optional |  |  |
|&nbsp;health_probe | object | Optional |  |  |
|&nbsp;&nbsp;protocol | string | Required |  |  |
|&nbsp;&nbsp;interval_in_seconds | number | Required |  |  |
|&nbsp;&nbsp;request_type | string | Optional |  |  |
|&nbsp;&nbsp;path | string | Optional |  |  |
|&nbsp;restore_traffic_time_to_healed_or_new_endpoint_in_minutes | number | Optional |  |  |
|&nbsp;session_affinity_enabled | bool | Optional |  |  |
|&nbsp;origin | list(object) | Optional | [] |  |
|&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;cdn_frontdoor_origin_group_id | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;&nbsp;host_name | string | Required |  |  |
|&nbsp;&nbsp;certificate_name_check_enabled | bool | Required |  |  |
|&nbsp;&nbsp;enabled | bool | Optional |  |  |
|&nbsp;&nbsp;http_port | number | Optional |  |  |
|&nbsp;&nbsp;https_port | number | Optional |  |  |
|&nbsp;&nbsp;origin_host_header | string | Optional |  |  |
|&nbsp;&nbsp;priority | number | Optional |  |  |
|&nbsp;&nbsp;private_link | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;request_message | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;target_type | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;location | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;private_link_target_id | string | Required |  |  |
|&nbsp;&nbsp;weight | number | Optional |  |  |
|route | list(object) | Optional | [] |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;cdn_frontdoor_endpoint_id | string | Optional |  |  Do not use, is replaced by cdn_frontdoor_endpoint_name parameter |
|&nbsp;cdn_frontdoor_endpoint_name | string | Optional |  |  Custom variable replacing cdn_frontdoor_endpoint_id parameter. Frontdoor endpoint name, which is being created in this frontdoor, is expected |
|&nbsp;cdn_frontdoor_origin_group_id | string | Optional |  |  Do not use, is replaced by cdn_frontdoor_origin_group_name parameter |
|&nbsp;cdn_frontdoor_origin_group_name | string | Optional |  |  Custom variable replacing cdn_frontdoor_origin_group_id parameter. Frontdoor origin group name, which is being created in this frontdoor, is expected |
|&nbsp;cdn_frontdoor_origin_ids | list(string) | Optional |  |  Do not use, is replaced by cdn_frontdoor_origin_names parameter |
|&nbsp;cdn_frontdoor_origin_names | list(string) | Optional | [] |  Custom variable replacing cdn_frontdoor_origin_ids parameter. Frontdoor origin names, which are being created in this frontdoor, are expected |
|&nbsp;patterns_to_match | list(string) | Required |  |  |
|&nbsp;supported_protocols | list(string) | Required |  |  |
|&nbsp;forwarding_protocol | string | Optional |  |  |
|&nbsp;cache | object | Optional |  |  |
|&nbsp;&nbsp;query_string_caching_behavior | string | Optional |  |  |
|&nbsp;&nbsp;query_strings | list(string) | Optional |  |  |
|&nbsp;&nbsp;compression_enabled | bool | Optional |  |  |
|&nbsp;&nbsp;content_types_to_compress | list(string) | Optional |  |  |
|&nbsp;cdn_frontdoor_custom_domain_ids | list(string) | Optional |  |  Do not use, is replaced by cdn_frontdoor_custom_domain_names parameter |
|&nbsp;cdn_frontdoor_custom_domain_names | list(string) | Optional |  |  Custom variable replacing cdn_frontdoor_custom_domain_ids parameter. Frontdoor custom domain names, which are being created in this frontdoor, are expected |
|&nbsp;cdn_frontdoor_origin_path | string | Optional |  |  |
|&nbsp;cdn_frontdoor_rule_set_ids | list(string) | Optional |  |  |
|&nbsp;enabled | bool | Optional |  |  |
|&nbsp;https_redirect_enabled | bool | Optional |  |  |
|&nbsp;link_to_default_domain | bool | Optional |  |  |
|custom_domain | list(object) | Optional | [] |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;cdn_frontdoor_profile_id | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;host_name | string | Required |  |  |
|&nbsp;tls | object | Required |  |  |
|&nbsp;&nbsp;certificate_type | string | Optional |  |  |
|&nbsp;&nbsp;minimum_tls_version | string | Optional |  |  |
|&nbsp;&nbsp;cdn_frontdoor_secret_id | string | Optional |  |  |
|&nbsp;dns_zone_id | string | Optional |  |  |
|monitoring | list(object) | Optional | [] |  Custom object for enabling diagnostic settings |
|&nbsp;diag_name | string | Optional |  |  Name of the diagnostic setting |
|&nbsp;log_analytics_workspace_id | string | Optional |  |  |
|&nbsp;eventhub_name | string | Optional |  |  |
|&nbsp;eventhub_authorization_rule_id | string | Optional |  |  |
|&nbsp;storage_account_id | string | Optional |  |  |
|&nbsp;categories | object | Optional |  |  |
|&nbsp;&nbsp;front_door_access_log | bool | Optional |  true |  |
|&nbsp;&nbsp;front_door_helath_probe_log | bool | Optional |  true |  |
|&nbsp;&nbsp;front_door_web_application_firewall_log | bool | Optional |  true |  |
|&nbsp;&nbsp;all_metrics | bool | Optional |  true |  |


