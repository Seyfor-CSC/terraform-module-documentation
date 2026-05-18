# Variables

```
variable "config" {  type = list(object({
    # application insights
    name                                  = string
    resource_group_name                   = string
    location                              = string
    application_type                      = string
    daily_data_cap_in_gb                  = optional(number)
    daily_data_cap_notifications_disabled = optional(bool)
    retention_in_days                     = optional(number)
    sampling_percentage                   = optional(number)
    disable_ip_masking                    = optional(bool)
    workspace_id                          = optional(string)
    local_authentication_disabled         = optional(bool)
    internet_ingestion_enabled            = optional(bool)
    internet_query_enabled                = optional(bool)
    force_customer_storage_for_profiler   = optional(bool)
    tags                                  = optional(map(any))
  }))
}


```


## Table with config variables

| Name | Data Type | Requirement | Default Value | Comment |
| ------- | --------- | ----------- | ------------- | ------- |
|name | string | Required |  |  |
|resource_group_name | string | Required |  |  |
|location | string | Required |  |  |
|application_type | string | Required |  |  |
|daily_data_cap_in_gb | number | Optional |  |  |
|daily_data_cap_notifications_disabled | bool | Optional |  |  |
|retention_in_days | number | Optional |  |  |
|sampling_percentage | number | Optional |  |  |
|disable_ip_masking | bool | Optional |  |  |
|workspace_id | string | Optional |  |  |
|local_authentication_disabled | bool | Optional |  |  |
|internet_ingestion_enabled | bool | Optional |  |  |
|internet_query_enabled | bool | Optional |  |  |
|force_customer_storage_for_profiler | bool | Optional |  |  |
|tags | map(any) | Optional |  |  |


