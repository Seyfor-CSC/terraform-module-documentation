# Variables

```
variable "config" {  type = list(object({
    # logic app workflow
    name                = string
    resource_group_name = string
    location            = string
    access_control = optional(object({
      action = optional(object({
        allowed_caller_ip_address_range = list(string)
      }))
      content = optional(object({
        allowed_caller_ip_address_range = list(string)
      }))
      trigger = optional(object({
        allowed_caller_ip_address_range = list(string)
        open_authentication_policy = optional(object({
          name = string
          claim = object({
            name  = string
            value = string
          })
        }))
      }))
      workflow_management = optional(object({
        allowed_caller_ip_address_range = list(string)
      }))
    }))
    identity = optional(object({
      type         = string
      identity_ids = optional(list(string))
    }))
    integration_service_environment_id = optional(string)
    logic_app_integration_account_id   = optional(string)
    enabled                            = optional(bool)
    workflow_parameters                = optional(map(string))
    workflow_schema                    = optional(string)
    workflow_version                   = optional(string)
    parameters                         = optional(map(string))
    tags                               = optional(map(any))

    # monitoring
    monitoring = optional(list(object({                 # Custom object for enabling diagnostic settings
      diag_name                      = optional(string) # Name of the diagnostic setting
      log_analytics_workspace_id     = optional(string)
      eventhub_name                  = optional(string)
      eventhub_authorization_rule_id = optional(string)
      categories = optional(object({
        workflow_runtime = optional(bool, true)
        all_metrics      = optional(bool, true)
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
|access_control | object | Optional |  |  |
|&nbsp;action | object | Optional |  |  |
|&nbsp;&nbsp;allowed_caller_ip_address_range | list(string) | Required |  |  |
|&nbsp;content | object | Optional |  |  |
|&nbsp;&nbsp;allowed_caller_ip_address_range | list(string) | Required |  |  |
|&nbsp;trigger | object | Optional |  |  |
|&nbsp;&nbsp;allowed_caller_ip_address_range | list(string) | Required |  |  |
|&nbsp;&nbsp;open_authentication_policy | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;claim | object | Required |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;value | string | Required |  |  |
|&nbsp;workflow_management | object | Optional |  |  |
|&nbsp;&nbsp;allowed_caller_ip_address_range | list(string) | Required |  |  |
|identity | object | Optional |  |  |
|&nbsp;type | string | Required |  |  |
|&nbsp;identity_ids | list(string) | Optional |  |  |
|integration_service_environment_id | string | Optional |  |  |
|logic_app_integration_account_id | string | Optional |  |  |
|enabled | bool | Optional |  |  |
|workflow_parameters | map(string) | Optional |  |  |
|workflow_schema | string | Optional |  |  |
|workflow_version | string | Optional |  |  |
|parameters | map(string) | Optional |  |  |
|tags | map(any) | Optional |  |  |
|monitoring | list(object) | Optional | [] |  Custom object for enabling diagnostic settings |
|&nbsp;diag_name | string | Optional |  |  Name of the diagnostic setting |
|&nbsp;log_analytics_workspace_id | string | Optional |  |  |
|&nbsp;eventhub_name | string | Optional |  |  |
|&nbsp;eventhub_authorization_rule_id | string | Optional |  |  |
|&nbsp;categories | object | Optional |  |  |
|&nbsp;&nbsp;workflow_runtime | bool | Optional |  true |  |
|&nbsp;&nbsp;all_metrics | bool | Optional |  true |  |


