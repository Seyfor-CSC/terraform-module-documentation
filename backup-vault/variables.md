# Variables

```
variable "config" {  type = list(object({
    # data protection backup vault
    name                         = string
    resource_group_name          = string
    location                     = string
    datastore_type               = string
    redundancy                   = string
    cross_region_restore_enabled = optional(bool)
    identity = optional(object({
      type = string
    }))
    retention_duration_in_days = optional(number)
    soft_delete                = optional(string)
    tags                       = optional(map(any))

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
      time_zone = optional(string)
    })), [])

    # monitoring
    monitoring = optional(list(object({                 # Custom object for enabling diagnostic settings
      diag_name                      = optional(string) # Name of the diagnostic setting
      log_analytics_workspace_id     = optional(string)
      eventhub_name                  = optional(string)
      eventhub_authorization_rule_id = optional(string)
      storage_account_id             = optional(string)
      categories = optional(object({
        core_azure_backup                     = optional(bool, true)
        addon_azure_backup_jobs               = optional(bool, true)
        addon_azure_backup_policy             = optional(bool, true)
        addon_azure_backup_protected_instance = optional(bool, true)
        health                                = optional(bool, true)
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
|datastore_type | string | Required |  |  |
|redundancy | string | Required |  |  |
|cross_region_restore_enabled | bool | Optional |  |  |
|identity | object | Optional |  |  |
|&nbsp;type | string | Required |  |  |
|retention_duration_in_days | number | Optional |  |  |
|soft_delete | string | Optional |  |  |
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
|&nbsp;time_zone | string | Optional |  |  |
|monitoring | list(object) | Optional | [] |  Custom object for enabling diagnostic settings |
|&nbsp;diag_name | string | Optional |  |  Name of the diagnostic setting |
|&nbsp;log_analytics_workspace_id | string | Optional |  |  |
|&nbsp;eventhub_name | string | Optional |  |  |
|&nbsp;eventhub_authorization_rule_id | string | Optional |  |  |
|&nbsp;storage_account_id | string | Optional |  |  |
|&nbsp;categories | object | Optional |  |  |
|&nbsp;&nbsp;core_azure_backup | bool | Optional |  true |  |
|&nbsp;&nbsp;addon_azure_backup_jobs | bool | Optional |  true |  |
|&nbsp;&nbsp;addon_azure_backup_policy | bool | Optional |  true |  |
|&nbsp;&nbsp;addon_azure_backup_protected_instance | bool | Optional |  true |  |
|&nbsp;&nbsp;health | bool | Optional |  true |  |


