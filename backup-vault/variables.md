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

    # data_protection_backup_policy_disk
    backup_policy = optional(list(object({
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
|backup_policy | list(object) | Optional | [] |  |
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


