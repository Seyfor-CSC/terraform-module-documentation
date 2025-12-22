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
      type         = string
      identity_ids = optional(list(string))
    }))
    retention_duration_in_days = optional(number)
    immutability               = optional(string)
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

    # data protection backup policy blob storage
    backup_policy_blob_storage = optional(list(object({
      name                                   = string
      vault_id                               = optional(string) # Inherited in module from parent resource
      backup_repeating_time_intervals        = optional(list(string))
      operational_default_retention_duration = optional(string)
      retention_rule = optional(list(object({
        name = string
        criteria = object({
          absolute_criteria      = optional(string)
          days_of_month          = optional(list(number))
          days_of_week           = optional(list(string))
          months_of_year         = optional(list(string))
          scheduled_backup_times = optional(list(string))
          weeks_of_month         = optional(list(string))
        })
        life_cycle = object({
          data_store_type = string
          duration        = string
        })
        priority = number
      })), [])
      time_zone                        = optional(string)
      vault_default_retention_duration = optional(string)
    })), [])

    # data protection backup policy postgresql flexible server
    backup_policy_postgresql_flexible_server = optional(list(object({
      name                            = string
      vault_id                        = optional(string) # Inherited in module from parent resource
      backup_repeating_time_intervals = list(string)
      default_retention_rule = object({
        life_cycle = object({
          data_store_type = string
          duration        = string
        })
      })
      retention_rule = optional(list(object({
        name = string
        criteria = object({
          absolute_criteria      = optional(string)
          days_of_week           = optional(list(string))
          months_of_year         = optional(list(string))
          scheduled_backup_times = optional(list(string))
          weeks_of_month         = optional(list(string))
        })
        life_cycle = object({
          data_store_type = string
          duration        = string
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
|&nbsp;identity_ids | list(string) | Optional |  |  |
|retention_duration_in_days | number | Optional |  |  |
|immutability | string | Optional |  |  |
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
|backup_policy_blob_storage | list(object) | Optional | [] |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;vault_id | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;backup_repeating_time_intervals | list(string) | Optional |  |  |
|&nbsp;operational_default_retention_duration | string | Optional |  |  |
|&nbsp;retention_rule | list(object) | Optional | [] |  |
|&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;criteria | object | Required |  |  |
|&nbsp;&nbsp;&nbsp;absolute_criteria | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;days_of_month | list(number) | Optional |  |  |
|&nbsp;&nbsp;&nbsp;days_of_week | list(string) | Optional |  |  |
|&nbsp;&nbsp;&nbsp;months_of_year | list(string) | Optional |  |  |
|&nbsp;&nbsp;&nbsp;scheduled_backup_times | list(string) | Optional |  |  |
|&nbsp;&nbsp;&nbsp;weeks_of_month | list(string) | Optional |  |  |
|&nbsp;&nbsp;life_cycle | object | Required |  |  |
|&nbsp;&nbsp;&nbsp;data_store_type | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;duration | string | Required |  |  |
|&nbsp;&nbsp;priority | number | Required |  |  |
|&nbsp;time_zone | string | Optional |  |  |
|&nbsp;vault_default_retention_duration | string | Optional |  |  |
|backup_policy_postgresql_flexible_server | list(object) | Optional | [] |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;vault_id | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;backup_repeating_time_intervals | list(string) | Required |  |  |
|&nbsp;default_retention_rule | object | Required |  |  |
|&nbsp;&nbsp;life_cycle | object | Required |  |  |
|&nbsp;&nbsp;&nbsp;data_store_type | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;duration | string | Required |  |  |
|&nbsp;retention_rule | list(object) | Optional | [] |  |
|&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;criteria | object | Required |  |  |
|&nbsp;&nbsp;&nbsp;absolute_criteria | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;days_of_week | list(string) | Optional |  |  |
|&nbsp;&nbsp;&nbsp;months_of_year | list(string) | Optional |  |  |
|&nbsp;&nbsp;&nbsp;scheduled_backup_times | list(string) | Optional |  |  |
|&nbsp;&nbsp;&nbsp;weeks_of_month | list(string) | Optional |  |  |
|&nbsp;&nbsp;life_cycle | object | Required |  |  |
|&nbsp;&nbsp;&nbsp;data_store_type | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;duration | string | Required |  |  |
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


