# Variables

```
variable "config" {  type = list(object({
    # purview account
    name                = string
    resource_group_name = string
    location            = string
    identity = object({
      type         = string
      identity_ids = optional(list(string))
    })
    public_network_enabled      = optional(bool, false)
    managed_resource_group_name = optional(string)
    tags                        = optional(map(any))

    # monitoring
    monitoring = optional(list(object({                 # Custom object for enabling diagnostic settings
      diag_name                      = optional(string) # Name of the diagnostic setting
      log_analytics_workspace_id     = optional(string)
      eventhub_name                  = optional(string)
      eventhub_authorization_rule_id = optional(string)
      storage_account_id             = optional(string)
      categories = optional(object({
        security                   = optional(bool, true)
        data_sensitivity_log_event = optional(bool, true)
        scan_status_log_event      = optional(bool, true)
        all_metrics                = optional(bool, true)
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
|identity | object | Required |  |  |
|&nbsp;type | string | Required |  |  |
|&nbsp;identity_ids | list(string) | Optional |  |  |
|public_network_enabled | bool | Optional |  false |  |
|managed_resource_group_name | string | Optional |  |  |
|tags | map(any) | Optional |  |  |
|monitoring | list(object) | Optional | [] |  Custom object for enabling diagnostic settings |
|&nbsp;diag_name | string | Optional |  |  Name of the diagnostic setting |
|&nbsp;log_analytics_workspace_id | string | Optional |  |  |
|&nbsp;eventhub_name | string | Optional |  |  |
|&nbsp;eventhub_authorization_rule_id | string | Optional |  |  |
|&nbsp;storage_account_id | string | Optional |  |  |
|&nbsp;categories | object | Optional |  |  |
|&nbsp;&nbsp;security | bool | Optional |  true |  |
|&nbsp;&nbsp;data_sensitivity_log_event | bool | Optional |  true |  |
|&nbsp;&nbsp;scan_status_log_event | bool | Optional |  true |  |
|&nbsp;&nbsp;all_metrics | bool | Optional |  true |  |


