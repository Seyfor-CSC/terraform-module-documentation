# Variables

```
variable "config" {  type = list(object({
    # container app environment
    name                                        = string
    resource_group_name                         = string
    location                                    = string
    dapr_application_insights_connection_string = optional(string)
    infrastructure_resource_group_name          = optional(string)
    infrastructure_subnet_id                    = optional(string)
    internal_load_balancer_enabled              = optional(bool)
    zone_redundancy_enabled                     = optional(bool)
    log_analytics_workspace_id                  = optional(string)
    workload_profile = optional(object({
      name                  = string
      workload_profile_type = string
      maximum_count         = optional(number)
      minimum_count         = optional(number)
    }))
    mutual_tls_enabled = optional(bool)
    tags               = optional(map(any))

    # monitoring
    monitoring = optional(list(object({                 # Custom object for enabling diagnostic settings
      diag_name                      = optional(string) # Name of the diagnostic setting
      log_analytics_workspace_id     = optional(string)
      eventhub_name                  = optional(string)
      eventhub_authorization_rule_id = optional(string)
      storage_account_id             = optional(string)
      categories = optional(object({
        container_app_console_logs      = optional(bool, true)
        container_app_system_logs       = optional(bool, true)
        app_env_spring_app_console_logs = optional(bool, true)
        all_metrics                     = optional(bool, true)
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
|location | string | Required |  |  |
|dapr_application_insights_connection_string | string | Optional |  |  |
|infrastructure_resource_group_name | string | Optional |  |  |
|infrastructure_subnet_id | string | Optional |  |  |
|internal_load_balancer_enabled | bool | Optional |  |  |
|zone_redundancy_enabled | bool | Optional |  |  |
|log_analytics_workspace_id | string | Optional |  |  |
|workload_profile | object | Optional |  |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;workload_profile_type | string | Required |  |  |
|&nbsp;maximum_count | number | Optional |  |  |
|&nbsp;minimum_count | number | Optional |  |  |
|mutual_tls_enabled | bool | Optional |  |  |
|tags | map(any) | Optional |  |  |
|monitoring | list(object) | Optional | [] |  Custom object for enabling diagnostic settings |
|&nbsp;diag_name | string | Optional |  |  Name of the diagnostic setting |
|&nbsp;log_analytics_workspace_id | string | Optional |  |  |
|&nbsp;eventhub_name | string | Optional |  |  |
|&nbsp;eventhub_authorization_rule_id | string | Optional |  |  |
|&nbsp;storage_account_id | string | Optional |  |  |
|&nbsp;categories | object | Optional |  |  |
|&nbsp;&nbsp;container_app_console_logs | bool | Optional |  true |  |
|&nbsp;&nbsp;container_app_system_logs | bool | Optional |  true |  |
|&nbsp;&nbsp;app_env_spring_app_console_logs | bool | Optional |  true |  |
|&nbsp;&nbsp;all_metrics | bool | Optional |  true |  |


