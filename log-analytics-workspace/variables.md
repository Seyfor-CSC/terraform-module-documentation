# Variables

```
variable "config" {  type = list(object({
    # log analytics workspace
    name                            = string
    resource_group_name             = string
    location                        = string
    allow_resource_only_permissions = optional(bool)
    local_authentication_disabled   = optional(bool)
    sku                             = optional(string)
    retention_in_days               = optional(number, 90)
    daily_quota_gb                  = optional(number)
    cmk_for_query_forced            = optional(bool)
    identity = optional(object({
      type         = string
      identity_ids = optional(list(string))
    }))
    internet_ingestion_enabled              = optional(bool)
    internet_query_enabled                  = optional(bool)
    reservation_capacity_in_gb_per_day      = optional(number)
    data_collection_rule_id                 = optional(string)
    immediate_data_purge_on_30_days_enabled = optional(bool)
    tags                                    = optional(map(any))

    # monitoring
    monitoring = optional(list(object({                 # Custom object for enabling diagnostic settings
      diag_name                      = optional(string) # Name of the diagnostic setting
      log_analytics_workspace_id     = optional(string)
      self_logging                   = optional(bool, false)
      eventhub_name                  = optional(string)
      eventhub_authorization_rule_id = optional(string)
      storage_account_id             = optional(string)
      categories = optional(object({
        audit        = optional(bool, true)
        summary_logs = optional(bool, true)
        all_metrics  = optional(bool, true)
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
|allow_resource_only_permissions | bool | Optional |  |  |
|local_authentication_disabled | bool | Optional |  |  |
|sku | string | Optional |  |  |
|retention_in_days | number | Optional |  90 |  |
|daily_quota_gb | number | Optional |  |  |
|cmk_for_query_forced | bool | Optional |  |  |
|identity | object | Optional |  |  |
|&nbsp;type | string | Required |  |  |
|&nbsp;identity_ids | list(string) | Optional |  |  |
|internet_ingestion_enabled | bool | Optional |  |  |
|internet_query_enabled | bool | Optional |  |  |
|reservation_capacity_in_gb_per_day | number | Optional |  |  |
|data_collection_rule_id | string | Optional |  |  |
|immediate_data_purge_on_30_days_enabled | bool | Optional |  |  |
|tags | map(any) | Optional |  |  |
|monitoring | list(object) | Optional | [] |  Custom object for enabling diagnostic settings |
|&nbsp;diag_name | string | Optional |  |  Name of the diagnostic setting |
|&nbsp;log_analytics_workspace_id | string | Optional |  |  |
|&nbsp;self_logging | bool | Optional |  false |  |
|&nbsp;eventhub_name | string | Optional |  |  |
|&nbsp;eventhub_authorization_rule_id | string | Optional |  |  |
|&nbsp;storage_account_id | string | Optional |  |  |
|&nbsp;categories | object | Optional |  |  |
|&nbsp;&nbsp;audit | bool | Optional |  true |  |
|&nbsp;&nbsp;summary_logs | bool | Optional |  true |  |
|&nbsp;&nbsp;all_metrics | bool | Optional |  true |  |


