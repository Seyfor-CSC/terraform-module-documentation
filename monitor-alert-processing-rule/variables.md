# Variables

```
variable "config" {  type = list(object({
    # monitor alert processing rule
    name                 = string
    resource_group_name  = string
    add_action_group_ids = optional(list(string)) # azurerm_monitor_alert_processing_rule_action_group only
    scopes               = list(string)
    condition = optional(object({
      alert_context = optional(object({
        operator = string
        values   = list(string)
      }))
      alert_rule_id = optional(object({
        operator = string
        values   = list(string)
      }))
      alert_rule_name = optional(object({
        operator = string
        values   = list(string)
      }))
      description = optional(object({
        operator = string
        values   = list(string)
      }))
      monitor_condition = optional(object({
        operator = string
        values   = list(string)
      }))
      monitor_service = optional(object({
        operator = string
        values   = list(string)
      }))
      severity = optional(object({
        operator = string
        values   = list(string)
      }))
      signal_type = optional(object({
        operator = string
        values   = list(string)
      }))
      target_resource = optional(object({
        operator = string
        values   = list(string)
      }))
      target_resource_group = optional(object({
        operator = string
        values   = list(string)
      }))
      target_resource_type = optional(object({
        operator = string
        values   = list(string)
      }))
    }))
    description = optional(string)
    enabled     = optional(bool)
    schedule = optional(object({
      effective_from  = optional(string)
      effective_until = optional(string)
      recurrence = optional(object({
        daily = optional(list(object({
          start_time = string
          end_time   = string
        })), [])
        weekly = optional(list(object({
          days_of_week = list(string)
          start_time   = optional(string)
          end_time     = optional(string)
        })), [])
        monthly = optional(list(object({
          days_of_month = list(number)
          start_time    = optional(string)
          end_time      = optional(string)
        })), [])
      }))
      time_zone = optional(string)
    }))
    tags = optional(map(any))
  }))
}


```


## Table with config variables

| Name | Data Type | Requirement | Default Value | Comment |
| ------- | --------- | ----------- | ------------- | ------- |
|name | string | Required |  |  |
|resource_group_name | string | Required |  |  |
|add_action_group_ids | list(string) | Optional |  |  azurerm_monitor_alert_processing_rule_action_group only |
|scopes | list(string) | Required |  |  |
|condition | object | Optional |  |  |
|&nbsp;alert_context | object | Optional |  |  |
|&nbsp;&nbsp;operator | string | Required |  |  |
|&nbsp;&nbsp;values | list(string) | Required |  |  |
|&nbsp;alert_rule_id | object | Optional |  |  |
|&nbsp;&nbsp;operator | string | Required |  |  |
|&nbsp;&nbsp;values | list(string) | Required |  |  |
|&nbsp;alert_rule_name | object | Optional |  |  |
|&nbsp;&nbsp;operator | string | Required |  |  |
|&nbsp;&nbsp;values | list(string) | Required |  |  |
|&nbsp;description | object | Optional |  |  |
|&nbsp;&nbsp;operator | string | Required |  |  |
|&nbsp;&nbsp;values | list(string) | Required |  |  |
|&nbsp;monitor_condition | object | Optional |  |  |
|&nbsp;&nbsp;operator | string | Required |  |  |
|&nbsp;&nbsp;values | list(string) | Required |  |  |
|&nbsp;monitor_service | object | Optional |  |  |
|&nbsp;&nbsp;operator | string | Required |  |  |
|&nbsp;&nbsp;values | list(string) | Required |  |  |
|&nbsp;severity | object | Optional |  |  |
|&nbsp;&nbsp;operator | string | Required |  |  |
|&nbsp;&nbsp;values | list(string) | Required |  |  |
|&nbsp;signal_type | object | Optional |  |  |
|&nbsp;&nbsp;operator | string | Required |  |  |
|&nbsp;&nbsp;values | list(string) | Required |  |  |
|&nbsp;target_resource | object | Optional |  |  |
|&nbsp;&nbsp;operator | string | Required |  |  |
|&nbsp;&nbsp;values | list(string) | Required |  |  |
|&nbsp;target_resource_group | object | Optional |  |  |
|&nbsp;&nbsp;operator | string | Required |  |  |
|&nbsp;&nbsp;values | list(string) | Required |  |  |
|&nbsp;target_resource_type | object | Optional |  |  |
|&nbsp;&nbsp;operator | string | Required |  |  |
|&nbsp;&nbsp;values | list(string) | Required |  |  |
|description | string | Optional |  |  |
|enabled | bool | Optional |  |  |
|schedule | object | Optional |  |  |
|&nbsp;effective_from | string | Optional |  |  |
|&nbsp;effective_until | string | Optional |  |  |
|&nbsp;recurrence | object | Optional |  |  |
|&nbsp;&nbsp;daily | list(object) | Optional | [] |  |
|&nbsp;&nbsp;&nbsp;start_time | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;end_time | string | Required |  |  |
|&nbsp;&nbsp;weekly | list(object) | Optional | [] |  |
|&nbsp;&nbsp;&nbsp;days_of_week | list(string) | Required |  |  |
|&nbsp;&nbsp;&nbsp;start_time | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;end_time | string | Optional |  |  |
|&nbsp;&nbsp;monthly | list(object) | Optional | [] |  |
|&nbsp;&nbsp;&nbsp;days_of_month | list(number) | Required |  |  |
|&nbsp;&nbsp;&nbsp;start_time | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;end_time | string | Optional |  |  |
|&nbsp;time_zone | string | Optional |  |  |
|tags | map(any) | Optional |  |  |


