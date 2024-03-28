# Variables

```
variable "config" {  type = list(object({
    # public ip prefix
    name                = string
    resource_group_name = string
    location            = string
    sku                 = optional(string)
    ip_version          = optional(string)
    prefix_length       = optional(number)
    zones               = optional(set(string))
    tags                = optional(map(any))

    # monitoring
    monitoring = optional(list(object({                 # Custom object for enabling diagnostic settings
      diag_name                      = optional(string) # Name of the diagnostic setting
      log_analytics_workspace_id     = optional(string)
      eventhub_name                  = optional(string)
      eventhub_authorization_rule_id = optional(string)
      categories = optional(object({
        ddos_protection_notifications = optional(bool, true)
        ddos_mitigation_flow_logs     = optional(bool, true)
        ddos_mitigation_reports       = optional(bool, true)
        all_metrics                   = optional(bool, true)
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
|sku | string | Optional |  |  |
|ip_version | string | Optional |  |  |
|prefix_length | number | Optional |  |  |
|zones | set(string) | Optional |  |  |
|tags | map(any) | Optional |  |  |
|monitoring | list(object) | Optional | [] |  Custom object for enabling diagnostic settings |
|&nbsp;diag_name | string | Optional |  |  Name of the diagnostic setting |
|&nbsp;log_analytics_workspace_id | string | Optional |  |  |
|&nbsp;eventhub_name | string | Optional |  |  |
|&nbsp;eventhub_authorization_rule_id | string | Optional |  |  |
|&nbsp;categories | object | Optional |  |  |
|&nbsp;&nbsp;ddos_protection_notifications | bool | Optional |  true |  |
|&nbsp;&nbsp;ddos_mitigation_flow_logs | bool | Optional |  true |  |
|&nbsp;&nbsp;ddos_mitigation_reports | bool | Optional |  true |  |
|&nbsp;&nbsp;all_metrics | bool | Optional |  true |  |


