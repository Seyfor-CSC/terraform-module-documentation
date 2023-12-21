# Variables

```
variable "config" {  type = list(object({
    # data protection backup vault
    name                = string
    resource_group_name = string
    location            = string
    datastore_type      = string
    redundancy          = string
    identity = optional(object({
      type = string
    }))
    tags = optional(map(any))

    # data protection backup policy disk
    backup_policy_disk = optional(list(object({
      name                            = string
      vault_id                        = optional(string) # Inherited in module from parent resource
      backup_repeating_time_intervals = list(string)
      default_retention_duration      = string
      retention_rule = optional(list(object({
        name     = string
        duration = string
        criteria = object({
          absolute_criteria = optional(string)
        })
        priority = number
      })), [])
    })), [])

    # monitoring
    monitoring = optional(list(object({                 # Custom object for enabling diagnostic settings
      diag_name                      = optional(string) # Name of the diagnostic setting
      log_analytics_workspace_id     = optional(string)
      eventhub_name                  = optional(string)
      eventhub_authorization_rule_id = optional(string)
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
|datastore_type | string | Required |  |  |
|redundancy | string | Required |  |  |
|identity | object | Optional |  |  |
|&nbsp;type | string | Required |  |  |
|tags | map(any) | Optional |  |  |
|backup_policy_disk | list(object) | Optional | [] |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;vault_id | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;backup_repeating_time_intervals | list(string) | Required |  |  |
|&nbsp;default_retention_duration | string | Required |  |  |
|&nbsp;retention_rule | list(object) | Optional | [] |  |
|&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;duration | string | Required |  |  |
|&nbsp;&nbsp;criteria | object | Required |  |  |
|&nbsp;&nbsp;&nbsp;absolute_criteria | string | Optional |  |  |
|&nbsp;&nbsp;priority | number | Required |  |  |
|monitoring | list(object) | Optional | [] |  Custom object for enabling diagnostic settings |
|&nbsp;diag_name | string | Optional |  |  Name of the diagnostic setting |
|&nbsp;log_analytics_workspace_id | string | Optional |  |  |
|&nbsp;eventhub_name | string | Optional |  |  |
|&nbsp;eventhub_authorization_rule_id | string | Optional |  |  |


