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

    # monitoring
    monitoring = optional(list(object({                 # Custom object for enabling diagnostic settings
      diag_name                      = optional(string) # Name of the diagnostic setting
      log_analytics_workspace_id     = optional(string)
      eventhub_name                  = optional(string)
      eventhub_authorization_rule_id = optional(string)
      storage_account_id             = optional(string)
      categories = optional(object({
        all_metrics = optional(bool, true)
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
|os_type | string | Required |  |  |
|sku_name | string | Required |  |  |
|app_service_environment_id | string | Optional |  |  |
|maximum_elastic_worker_count | number | Optional |  |  |
|worker_count | number | Optional |  |  |
|per_site_scaling_enabled | bool | Optional |  |  |
|zone_balancing_enabled | bool | Optional |  |  |
|tags | map(any) | Optional |  |  |
|monitoring | list(object) | Optional | [] |  Custom object for enabling diagnostic settings |
|&nbsp;diag_name | string | Optional |  |  Name of the diagnostic setting |
|&nbsp;log_analytics_workspace_id | string | Optional |  |  |
|&nbsp;eventhub_name | string | Optional |  |  |
|&nbsp;eventhub_authorization_rule_id | string | Optional |  |  |
|&nbsp;storage_account_id | string | Optional |  |  |
|&nbsp;categories | object | Optional |  |  |
|&nbsp;&nbsp;all_metrics | bool | Optional |  true |  |


