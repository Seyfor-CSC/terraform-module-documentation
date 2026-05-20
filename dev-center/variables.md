# Variables

```
variable "config" {  type = list(object({
    # dev center
    name                              = string
    resource_group_name               = string
    location                          = string
    project_catalog_item_sync_enabled = optional(bool)
    identity = optional(object({
      type         = string
      identity_ids = optional(list(string))
    }))
    tags = optional(map(any))

    # dev center project
    project = optional(list(object({
      name                = string
      resource_group_name = optional(string) # If not provided, inherited in module from parent resource
      location            = optional(string) # Inherited in module from parent resource
      dev_center_id       = optional(string) # If not provided, inherited in module from parent resource
      description         = optional(string)
      identity = optional(object({
        type         = string
        identity_ids = optional(list(string))
      }))
      maximum_dev_boxes_per_user = optional(number)
      tags                       = optional(map(any))
    })), [])

    # monitoring
    monitoring = optional(list(object({
      diag_name                      = optional(string)
      log_analytics_workspace_id     = optional(string)
      eventhub_name                  = optional(string)
      eventhub_authorization_rule_id = optional(string)
      storage_account_id             = optional(string)
      categories = optional(object({
        agent_health_status   = optional(bool, true)
        connection_event      = optional(bool, true)
        dataplane_audit_event = optional(bool, true)
        resource_operation    = optional(bool, true)
        usage                 = optional(bool, true)
        all_metrics           = optional(bool, false)
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
|project_catalog_item_sync_enabled | bool | Optional |  |  |
|identity | object | Optional |  |  |
|&nbsp;type | string | Required |  |  |
|&nbsp;identity_ids | list(string) | Optional |  |  |
|tags | map(any) | Optional |  |  |
|project | list(object) | Optional | [] |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;resource_group_name | string | Optional |  |  If not provided, inherited in module from parent resource |
|&nbsp;location | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;dev_center_id | string | Optional |  |  If not provided, inherited in module from parent resource |
|&nbsp;description | string | Optional |  |  |
|&nbsp;identity | object | Optional |  |  |
|&nbsp;&nbsp;type | string | Required |  |  |
|&nbsp;&nbsp;identity_ids | list(string) | Optional |  |  |
|&nbsp;maximum_dev_boxes_per_user | number | Optional |  |  |
|&nbsp;tags | map(any) | Optional |  |  |
|monitoring | list(object) | Optional | [] |  |
|&nbsp;diag_name | string | Optional |  |  |
|&nbsp;log_analytics_workspace_id | string | Optional |  |  |
|&nbsp;eventhub_name | string | Optional |  |  |
|&nbsp;eventhub_authorization_rule_id | string | Optional |  |  |
|&nbsp;storage_account_id | string | Optional |  |  |
|&nbsp;categories | object | Optional |  |  |
|&nbsp;&nbsp;agent_health_status | bool | Optional |  true |  |
|&nbsp;&nbsp;connection_event | bool | Optional |  true |  |
|&nbsp;&nbsp;dataplane_audit_event | bool | Optional |  true |  |
|&nbsp;&nbsp;resource_operation | bool | Optional |  true |  |
|&nbsp;&nbsp;usage | bool | Optional |  true |  |
|&nbsp;&nbsp;all_metrics | bool | Optional |  false |  |


