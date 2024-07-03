# Variables

```
variable "config" {  type = list(object({
    # redis cache
    name                = string
    resource_group_name = string
    location            = string
    capacity            = number
    family              = string
    sku_name            = string
    enable_non_ssl_port = optional(bool)
    identity = optional(object({
      type         = string
      identity_ids = optional(list(string))
    }))
    minimum_tls_version = optional(string)
    patch_schedule = optional(list(object({
      day_of_week        = string
      start_hour_utc     = optional(number)
      maintenance_window = optional(string)
    })), [])
    private_static_ip_address     = optional(string)
    public_network_access_enabled = optional(bool, false)
    redis_configuration = optional(object({
      aof_backup_enabled                      = optional(bool)
      aof_storage_connection_string_0         = optional(string)
      aof_storage_connection_string_1         = optional(string)
      enable_authentication                   = optional(bool)
      active_directory_authentication_enabled = optional(bool)
      maxmemory_reserved                      = optional(number)
      maxmemory_delta                         = optional(number)
      maxmemory_policy                        = optional(string)
      data_persistence_authentication_method  = optional(string)
      maxfragmentationmemory_reserved         = optional(number)
      rdb_backup_enabled                      = optional(bool)
      rdb_backup_frequency                    = optional(number)
      rdb_backup_max_snapshot_count           = optional(number)
      rdb_storage_connection_string           = optional(string)
      storage_account_subscription_id         = optional(string)
      notify_keyspace_events                  = optional(string)
    }))
    replicas_per_master  = optional(number)
    replicas_per_primary = optional(number)
    redis_version        = optional(number)
    tenant_settings      = optional(map(string))
    shard_count          = optional(number)
    subnet_id            = optional(string)
    zones                = optional(list(string))
    tags                 = optional(map(any))

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
      categories = optional(object({
        connected_client_list             = optional(bool, true)
        ms_entra_authentication_audit_log = optional(bool, true)
        all_metrics                       = optional(bool, true)
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
|capacity | number | Required |  |  |
|family | string | Required |  |  |
|sku_name | string | Required |  |  |
|enable_non_ssl_port | bool | Optional |  |  |
|identity | object | Optional |  |  |
|&nbsp;type | string | Required |  |  |
|&nbsp;identity_ids | list(string) | Optional |  |  |
|minimum_tls_version | string | Optional |  |  |
|patch_schedule | list(object) | Optional | [] |  |
|&nbsp;day_of_week | string | Required |  |  |
|&nbsp;start_hour_utc | number | Optional |  |  |
|&nbsp;maintenance_window | string | Optional |  |  |
|private_static_ip_address | string | Optional |  |  |
|public_network_access_enabled | bool | Optional |  false |  |
|redis_configuration | object | Optional |  |  |
|&nbsp;aof_backup_enabled | bool | Optional |  |  |
|&nbsp;aof_storage_connection_string_0 | string | Optional |  |  |
|&nbsp;aof_storage_connection_string_1 | string | Optional |  |  |
|&nbsp;enable_authentication | bool | Optional |  |  |
|&nbsp;active_directory_authentication_enabled | bool | Optional |  |  |
|&nbsp;maxmemory_reserved | number | Optional |  |  |
|&nbsp;maxmemory_delta | number | Optional |  |  |
|&nbsp;maxmemory_policy | string | Optional |  |  |
|&nbsp;data_persistence_authentication_method | string | Optional |  |  |
|&nbsp;maxfragmentationmemory_reserved | number | Optional |  |  |
|&nbsp;rdb_backup_enabled | bool | Optional |  |  |
|&nbsp;rdb_backup_frequency | number | Optional |  |  |
|&nbsp;rdb_backup_max_snapshot_count | number | Optional |  |  |
|&nbsp;rdb_storage_connection_string | string | Optional |  |  |
|&nbsp;storage_account_subscription_id | string | Optional |  |  |
|&nbsp;notify_keyspace_events | string | Optional |  |  |
|replicas_per_master | number | Optional |  |  |
|replicas_per_primary | number | Optional |  |  |
|redis_version | number | Optional |  |  |
|tenant_settings | map(string) | Optional |  |  |
|shard_count | number | Optional |  |  |
|subnet_id | string | Optional |  |  |
|zones | list(string) | Optional |  |  |
|tags | map(any) | Optional |  |  |
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
|&nbsp;private_dns_zone_group | object | Optional |  |  |
|&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;private_dns_zone_ids | list(string) | Required |  |  |
|&nbsp;ip_configuration | list(object) | Optional | [] |  |
|&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;private_ip_address | string | Required |  |  |
|&nbsp;&nbsp;subresource_name | string | Required |  |  |
|&nbsp;&nbsp;member_name | string | Optional |  |  |
|&nbsp;tags | map(any) | Optional |  |  If not provided, inherited in module from parent resource |
|monitoring | list(object) | Optional | [] |  Custom object for enabling diagnostic settings |
|&nbsp;diag_name | string | Optional |  |  Name of the diagnostic setting |
|&nbsp;log_analytics_workspace_id | string | Optional |  |  |
|&nbsp;eventhub_name | string | Optional |  |  |
|&nbsp;eventhub_authorization_rule_id | string | Optional |  |  |
|&nbsp;categories | object | Optional |  |  |
|&nbsp;&nbsp;connected_client_list | bool | Optional |  true |  |
|&nbsp;&nbsp;ms_entra_authentication_audit_log | bool | Optional |  true |  |
|&nbsp;&nbsp;all_metrics | bool | Optional |  true |  |


