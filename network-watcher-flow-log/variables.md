# Variables

```
variable "config" {  type = list(object({
    # network watcher flow log
    name                 = string
    resource_group_name  = string
    network_watcher_name = string
    target_resource_id   = optional(string)
    storage_account_id   = string
    enabled              = bool
    retention_policy = object({
      enabled = bool
      days    = number
    })
    location = optional(string)
    traffic_analytics = optional(object({
      enabled               = bool
      workspace_id          = string
      workspace_region      = string
      workspace_resource_id = string
      interval_in_minutes   = optional(number)
    }))
    version = optional(number)
    tags    = optional(map(any))
  }))
}


```


## Table with config variables

| Name | Data Type | Requirement | Default Value | Comment |
| ------- | --------- | ----------- | ------------- | ------- |
|name | string | Required |  |  |
|resource_group_name | string | Required |  |  |
|network_watcher_name | string | Required |  |  |
|target_resource_id | string | Optional |  |  |
|storage_account_id | string | Required |  |  |
|enabled | bool | Required |  |  |
|retention_policy | object | Required |  |  |
|&nbsp;enabled | bool | Required |  |  |
|&nbsp;days | number | Required |  |  |
|location | string | Optional |  |  |
|traffic_analytics | object | Optional |  |  |
|&nbsp;enabled | bool | Required |  |  |
|&nbsp;workspace_id | string | Required |  |  |
|&nbsp;workspace_region | string | Required |  |  |
|&nbsp;workspace_resource_id | string | Required |  |  |
|&nbsp;interval_in_minutes | number | Optional |  |  |
|version | number | Optional |  |  |
|tags | map(any) | Optional |  |  |


