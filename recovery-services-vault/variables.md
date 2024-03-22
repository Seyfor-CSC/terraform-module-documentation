# Variables

```
variable "config" {  type = list(object({
    # recovery services vault
    name                = string
    resource_group_name = string
    location            = string
    sku                 = string
    identity = optional(object({
      type         = string
      identity_ids = optional(list(string))
    }))
    public_network_access_enabled = optional(bool, false)
    immutability                  = optional(string)
    storage_mode_type             = optional(string)
    cross_region_restore_enabled  = optional(bool)
    soft_delete_enabled           = optional(bool)
    encryption = optional(object({
      key_id                            = string
      infrastructure_encryption_enabled = bool
      user_assigned_identity_id         = optional(string)
      use_system_assigned_identity      = optional(bool)
    }))
    classic_vmware_replication_enabled = optional(bool)
    monitoring_rsv = optional(object({
      alerts_for_all_job_failures_enabled            = optional(bool)
      alerts_for_critical_operation_failures_enabled = optional(bool)
      }),
      {
        alerts_for_all_job_failures_enabled            = false
        alerts_for_critical_operation_failures_enabled = false
      }
    )
    tags = optional(map(any))

    # backup policy vm
    backup_policy_vm = optional(list(object({
      name                = string
      resource_group_name = optional(string) # If not provided, inherited in module from parent resource
      recovery_vault_name = optional(string) # Inherited in module from parent resource
      backup = object({
        frequency     = string
        time          = string
        hour_interval = optional(number)
        hour_duration = optional(number)
        weekdays      = optional(list(string))
      })
      policy_type                    = optional(string)
      timezone                       = optional(string)
      instant_restore_retention_days = optional(number)
      instant_restore_resource_group = optional(object({
        prefix = string
        suffix = optional(string)
      }))
      retention_daily = optional(object({
        count = number
      }))
      retention_weekly = optional(object({
        count    = number
        weekdays = list(string)
      }))
      retention_monthly = optional(object({
        count             = number
        weekdays          = optional(list(string))
        weeks             = optional(list(string))
        days              = optional(list(number))
        include_last_days = optional(bool)
      }))
      retention_yearly = optional(object({
        count             = number
        months            = list(string)
        weekdays          = optional(list(string))
        weeks             = optional(list(string))
        days              = optional(list(number))
        include_last_days = optional(bool)
      }))
    })), [])

    # backup policy file share
    backup_policy_file_share = optional(list(object({
      name                = string
      resource_group_name = optional(string) # If not provided, inherited in module from parent resource
      recovery_vault_name = optional(string) # Inherited in module from parent resource
      backup = object({
        frequency = string
        time      = optional(string)
        hourly = optional(object({
          interval        = optional(number)
          start_time      = optional(string)
          window_duration = optional(number)
        }))
      })
      retention_daily = object({
        count = number
      })
      timezone = optional(string)
      retention_weekly = optional(object({
        count    = number
        weekdays = list(string)
      }))
      retention_monthly = optional(object({
        count             = number
        weekdays          = optional(list(string))
        weeks             = optional(list(string))
        days              = optional(list(number))
        include_last_days = optional(bool)
      }))
      retention_yearly = optional(object({
        count             = number
        months            = list(string)
        weeks             = optional(list(string))
        weekdays          = optional(list(string))
        days              = optional(list(number))
        include_last_days = optional(bool)
      }))
    })), [])

    # private endpoint
    private_endpoint = optional(list(object({
      name                = string
      resource_group_name = optional(string) # If not provided, inherited in module from parent resource
      location            = optional(string) # If not provided, inherited in module from parent resource
      subnet_id           = string
      private_service_connection = list(object({
        name                              = string
        is_manual_connection              = bool
        private_connection_resource_id    = optional(string)
        private_connection_resource_alias = optional(string)
        subresource_names                 = optional(list(string))
        request_message                   = optional(string)
      }))
      custom_network_interface_name = optional(string)
      private_dns_zone_group = optional(object({
        name                 = string
        private_dns_zone_ids = list(string)
      }))
      ip_configuration = optional(list(object({
        name               = string
        private_ip_address = string
        subresource_name   = string
        member_name        = optional(string)
      })), [])
      tags = optional(map(any)) # If not provided, inherited in module from parent resource
    })), [])

    # monitoring
    monitoring = optional(list(object({                 # Custom object for enabling diagnostic settings
      diag_name                      = optional(string) # Name of the diagnostic setting
      log_analytics_workspace_id     = optional(string)
      eventhub_name                  = optional(string)
      eventhub_authorization_rule_id = optional(string)
      recovery                       = optional(bool, false) # Custom variable used to enable recovery logs
      backup                         = optional(bool, false) # Custom variable used to enable new backup logs
      backup_report                  = optional(bool, false) # Custom variable used to enable backup legacy logs
      categories = optional(object({
        # backup report - legacy event
        azure_backup_report = optional(bool, false) # to be depraced
        # backup - new events (replacemment for legacy event)
        core_azure_backup                     = optional(bool, true)
        addon_azure_backup_protected_instance = optional(bool, true)
        addon_azure_backup_jobs               = optional(bool, true)
        addon_azure_backup_policy             = optional(bool, true)
        addon_azure_backup_storage            = optional(bool, true)
        addon_azure_backup_alerts             = optional(bool, false) # to be deprecated
        # recovery
        azure_site_recovery_jobs                         = optional(bool, true)
        azure_site_recovery_replicated_items             = optional(bool, true)
        azure_site_recovery_events                       = optional(bool, true)
        azure_site_recovery_replication_stats            = optional(bool, true)
        azure_site_recovery_replication_data_upload_rate = optional(bool, true)
        azure_site_recovery_protected_disk_data_churn    = optional(bool, true)
        azure_site_recovery_recovery_points              = optional(bool, true)
        # others
        asr_jobs                = optional(bool, true)
        asr_replicated_items    = optional(bool, true)
        azure_backup_operations = optional(bool, true)
        health                  = optional(bool, true)
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
|sku | string | Required |  |  |
|identity | object | Optional |  |  |
|&nbsp;type | string | Required |  |  |
|&nbsp;identity_ids | list(string) | Optional |  |  |
|public_network_access_enabled | bool | Optional |  false |  |
|immutability | string | Optional |  |  |
|storage_mode_type | string | Optional |  |  |
|cross_region_restore_enabled | bool | Optional |  |  |
|soft_delete_enabled | bool | Optional |  |  |
|encryption | object | Optional |  |  |
|&nbsp;key_id | string | Required |  |  |
|&nbsp;infrastructure_encryption_enabled | bool | Required |  |  |
|&nbsp;user_assigned_identity_id | string | Optional |  |  |
|&nbsp;use_system_assigned_identity | bool | Optional |  |  |
|classic_vmware_replication_enabled | bool | Optional |  |  |
|monitoring_rsv | object | Optional |  |  |
|&nbsp;alerts_for_all_job_failures_enabled | bool | Optional |  |  |
|&nbsp;alerts_for_critical_operation_failures_enabled | bool | Optional |  |  |
|alerts_for_all_job_failures_enabled | false | Required |  |  |
|alerts_for_critical_operation_failures_enabled | false | Required |  |  |


