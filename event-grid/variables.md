# Variables

```
variable "config" {  type = object({
    system_topic = optional(list(object({
      name                   = string
      resource_group_name    = string
      location               = string
      source_arm_resource_id = string
      topic_type             = string
      identity = optional(object({
        type         = string
        identity_ids = optional(list(string))
      }))
      tags = optional(map(any))

      # monitoring
      monitoring = optional(list(object({                 # Custom object for enabling diagnostic settings
        diag_name                      = optional(string) # Name of the diagnostic setting
        log_analytics_workspace_id     = optional(string)
        eventhub_name                  = optional(string)
        eventhub_authorization_rule_id = optional(string)
        categories = optional(object({
          delivery_failures = optional(bool, true)
          all_metrics       = optional(bool, true)
        }))
      })), [])
    })), [])
  })
}


```


## Table with config variables

| Name | Data Type | Requirement | Default Value | Comment |
| ------- | --------- | ----------- | ------------- | ------- |
|system_topic | list(object) | Optional | [] |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;resource_group_name | string | Required |  |  |
|&nbsp;location | string | Required |  |  |
|&nbsp;source_arm_resource_id | string | Required |  |  |
|&nbsp;topic_type | string | Required |  |  |
|&nbsp;identity | object | Optional |  |  |
|&nbsp;&nbsp;type | string | Required |  |  |
|&nbsp;&nbsp;identity_ids | list(string) | Optional |  |  |
|&nbsp;tags | map(any) | Optional |  |  |
|&nbsp;monitoring | list(object) | Optional | [] |  Custom object for enabling diagnostic settings |
|&nbsp;&nbsp;diag_name | string | Optional |  |  Name of the diagnostic setting |
|&nbsp;&nbsp;log_analytics_workspace_id | string | Optional |  |  |
|&nbsp;&nbsp;eventhub_name | string | Optional |  |  |
|&nbsp;&nbsp;eventhub_authorization_rule_id | string | Optional |  |  |
|&nbsp;&nbsp;categories | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;delivery_failures | bool | Optional |  true |  |
|&nbsp;&nbsp;&nbsp;all_metrics | bool | Optional |  true |  |


