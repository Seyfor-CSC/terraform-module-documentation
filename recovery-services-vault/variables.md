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
    public_network_access_enabled = optional(string)
    immutability                  = optional(string)
    storage_mode_type             = optional(string)
    cross_region_restore_enabled  = optional(string)
    soft_delete_enabled           = optional(string)
    encryption = optional(object({
      key_id                            = string
      infrastructure_encryption_enabled = bool
      user_assigned_identity_id         = optional(string)
      use_system_assigned_identity      = optional(bool)
    }))
    classic_vmware_replication_enabled = optional(bool)
    tags                               = optional(map(any))

    # backup policy vm
    backup_policy = optional(list(object({
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
        count    = number
        weekdays = list(string)
        weeks    = list(string)
      }))
      retention_yearly = optional(object({
        count    = number
        weekdays = list(string)
        weeks    = list(string)
        months   = list(string)
      }))

      # backup protected vm
      protected_vm = optional(list(object({
        resource_group_name = optional(string) # If not provided, inherited in module from parent resource
        recovery_vault_name = optional(string) # Inherited in module from parent resource
        source_vm_id        = optional(string)
        backup_policy_id    = optional(string) # Inherited in module from parent resource
        exclude_disk_luns   = optional(list(number))
        include_disk_luns   = optional(list(number))
      })), [])
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
      private_dns_zone_group = optional(list(object({
        name                 = string
        private_dns_zone_ids = list(string)
      })), [])
      ip_configuration = optional(list(object({
        name               = string
        private_ip_address = string
        subresource_name   = string
        member_name        = optional(string)
      })), [])
      tags = optional(map(any))
    })), [])

    # monitoring
    monitoring = optional(list(object({                 # Custom object for enabling diagnostic settings
      diag_name                      = optional(string) # Name of the diagnostic setting
      log_analytics_workspace_id     = optional(string)
      eventhub_name                  = optional(string)
      eventhub_authorization_rule_id = optional(string)
      recovery                       = optional(bool, false) # Custom variable used to enable recovery logs
      backup                         = optional(bool, false) # Custom variable used to enable backup logs
      backup_report                  = optional(bool, false) # Custom variable used to enable backup report logs
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
|public_network_access_enabled | string | Optional |  |  |
|immutability | string | Optional |  |  |
|storage_mode_type | string | Optional |  |  |
|cross_region_restore_enabled | string | Optional |  |  |
|soft_delete_enabled | string | Optional |  |  |
|encryption | object | Optional |  |  |
|&nbsp;key_id | string | Required |  |  |
|&nbsp;infrastructure_encryption_enabled | bool | Required |  |  |
|&nbsp;user_assigned_identity_id | string | Optional |  |  |
|&nbsp;use_system_assigned_identity | bool | Optional |  |  |
|classic_vmware_replication_enabled | bool | Optional |  |  |
|tags | map(any) | Optional |  |  |
|backup_policy | list(object) | Optional | [] |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;resource_group_name | string | Optional |  |  If not provided, inherited in module from parent resource |
|&nbsp;recovery_vault_name | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;backup | object | Required |  |  |
|&nbsp;&nbsp;frequency | string | Required |  |  |
|&nbsp;&nbsp;time | string | Required |  |  |
|&nbsp;&nbsp;hour_interval | number | Optional |  |  |
|&nbsp;&nbsp;hour_duration | number | Optional |  |  |
|&nbsp;&nbsp;weekdays | list(string) | Optional |  |  |
|&nbsp;policy_type | string | Optional |  |  |
|&nbsp;timezone | string | Optional |  |  |
|&nbsp;instant_restore_retention_days | number | Optional |  |  |
|&nbsp;instant_restore_resource_group | object | Optional |  |  |
|&nbsp;&nbsp;prefix | string | Required |  |  |
|&nbsp;&nbsp;suffix | string | Optional |  |  |
|&nbsp;retention_daily | object | Optional |  |  |
|&nbsp;&nbsp;count | number | Required |  |  |
|&nbsp;retention_weekly | object | Optional |  |  |
|&nbsp;&nbsp;count | number | Required |  |  |
|&nbsp;&nbsp;weekdays | list(string) | Required |  |  |
|&nbsp;retention_monthly | object | Optional |  |  |
|&nbsp;&nbsp;count | number | Required |  |  |
|&nbsp;&nbsp;weekdays | list(string) | Required |  |  |
|&nbsp;&nbsp;weeks | list(string) | Required |  |  |
|&nbsp;retention_yearly | object | Optional |  |  |
|&nbsp;&nbsp;count | number | Required |  |  |
|&nbsp;&nbsp;weekdays | list(string) | Required |  |  |
|&nbsp;&nbsp;weeks | list(string) | Required |  |  |
|&nbsp;&nbsp;months | list(string) | Required |  |  |
|&nbsp;protected_vm | list(object) | Optional | [] |  |
|&nbsp;&nbsp;resource_group_name | string | Optional |  |  If not provided, inherited in module from parent resource |
|&nbsp;&nbsp;recovery_vault_name | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;&nbsp;source_vm_id | string | Optional |  |  |
|&nbsp;&nbsp;backup_policy_id | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;&nbsp;exclude_disk_luns | list(number) | Optional |  |  |
|&nbsp;&nbsp;include_disk_luns | list(number) | Optional |  |  |
|private_endpoint | list(object) | Optional | [] |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;resource_group_name | string | Optional |  |  If not provided, inherited in module from parent resource |
|&nbsp;location | string | Optional |  |  If not provided, inherited in module from parent resource |
|&nbsp;subnet_id | string | Required |  |  |
|&nbsp;private_service_connection | list(object) | Required |  |  |
|&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;is_manual_connection | bool | Required |  |  |
|&nbsp;&nbsp;private_connection_resource_id | string | Optional |  |  |
|&nbsp;&nbsp;private_connection_resource_alias | string | Optional |  |  |
|&nbsp;&nbsp;subresource_names | list(string) | Optional |  |  |
|&nbsp;&nbsp;request_message | string | Optional |  |  |
|&nbsp;custom_network_interface_name | string | Optional |  |  |
|&nbsp;private_dns_zone_group | list(object) | Optional | [] |  |
|&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;private_dns_zone_ids | list(string) | Required |  |  |
|&nbsp;ip_configuration | list(object) | Optional | [] |  |
|&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;private_ip_address | string | Required |  |  |
|&nbsp;&nbsp;subresource_name | string | Required |  |  |
|&nbsp;&nbsp;member_name | string | Optional |  |  |
|&nbsp;tags | map(any) | Optional |  |  |
|monitoring | list(object) | Optional | [] |  Custom object for enabling diagnostic settings |
|&nbsp;diag_name | string | Optional |  |  Name of the diagnostic setting |
|&nbsp;log_analytics_workspace_id | string | Optional |  |  |
|&nbsp;eventhub_name | string | Optional |  |  |
|&nbsp;eventhub_authorization_rule_id | string | Optional |  |  |
|&nbsp;recovery | bool | Optional |  false |  Custom variable used to enable recovery logs |
|&nbsp;backup | bool | Optional |  false |  Custom variable used to enable backup logs |
|&nbsp;backup_report | bool | Optional |  false |  Custom variable used to enable backup report logs |


