# Variables

```
variable "config" {  type = list(object({
    # managed redis
    name                = string
    resource_group_name = string
    location            = string
    sku_name            = string
    default_database = optional(object({
      access_keys_authentication_enabled = optional(bool)
      client_protocol                    = optional(string)
      clustering_policy                  = optional(string)
      eviction_policy                    = optional(string)
      geo_replication_group_name         = optional(string)
      module = optional(list(object({
        name = string
        args = optional(string)
      })), [])
      persistence_append_only_file_backup_frequency = optional(string)
      persistence_redis_database_backup_frequency   = optional(string)

      # monitoring
      monitoring = optional(list(object({                 # Custom object for enabling diagnostic settings
        diag_name                      = optional(string) # Name of the diagnostic setting
        log_analytics_workspace_id     = optional(string)
        eventhub_name                  = optional(string)
        eventhub_authorization_rule_id = optional(string)
        storage_account_id             = optional(string)
        categories = optional(object({
          connection_events = optional(bool, true)
        }))
      })), [])
    }))
    customer_managed_key = optional(object({
      key_vault_key_id          = string
      user_assigned_identity_id = string
    }))
    high_availability_enabled = optional(bool)
    identity = optional(object({
      type         = string
      identity_ids = optional(list(string))
    }))
    public_network_access = optional(string, "Disabled")
    tags                  = optional(map(any))

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
      storage_account_id             = optional(string)
      categories = optional(object({
        all_metrics = optional(bool, true)
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
|sku_name | string | Required |  |  |
|default_database | object | Optional |  |  |
|&nbsp;access_keys_authentication_enabled | bool | Optional |  |  |
|&nbsp;client_protocol | string | Optional |  |  |
|&nbsp;clustering_policy | string | Optional |  |  |
|&nbsp;eviction_policy | string | Optional |  |  |
|&nbsp;geo_replication_group_name | string | Optional |  |  |
|&nbsp;module | list(object) | Optional | [] |  |
|&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;args | string | Optional |  |  |
|&nbsp;persistence_append_only_file_backup_frequency | string | Optional |  |  |
|&nbsp;persistence_redis_database_backup_frequency | string | Optional |  |  |
|&nbsp;monitoring | list(object) | Optional | [] |  Custom object for enabling diagnostic settings |
|&nbsp;&nbsp;diag_name | string | Optional |  |  Name of the diagnostic setting |
|&nbsp;&nbsp;log_analytics_workspace_id | string | Optional |  |  |
|&nbsp;&nbsp;eventhub_name | string | Optional |  |  |
|&nbsp;&nbsp;eventhub_authorization_rule_id | string | Optional |  |  |
|&nbsp;&nbsp;storage_account_id | string | Optional |  |  |
|&nbsp;&nbsp;categories | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;connection_events | bool | Optional |  true |  |
|customer_managed_key | object | Optional |  |  |
|&nbsp;key_vault_key_id | string | Required |  |  |
|&nbsp;user_assigned_identity_id | string | Required |  |  |
|high_availability_enabled | bool | Optional |  |  |
|identity | object | Optional |  |  |
|&nbsp;type | string | Required |  |  |
|&nbsp;identity_ids | list(string) | Optional |  |  |
|public_network_access | string | Optional |  "Disabled" |  |
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
|&nbsp;storage_account_id | string | Optional |  |  |
|&nbsp;categories | object | Optional |  |  |
|&nbsp;&nbsp;all_metrics | bool | Optional |  true |  |


