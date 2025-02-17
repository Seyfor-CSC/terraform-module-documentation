# Variables

```
variable "config" {  type = list(object({
    # storage account
    name                             = string
    resource_group_name              = string
    location                         = string
    account_tier                     = string
    account_replication_type         = string
    account_kind                     = optional(string)
    cross_tenant_replication_enabled = optional(bool)
    access_tier                      = optional(string)
    edge_zone                        = optional(string)
    https_traffic_only_enabled       = optional(bool)
    min_tls_version                  = optional(string)
    allow_nested_items_to_be_public  = optional(bool, false)
    shared_access_key_enabled        = optional(bool)
    public_network_access_enabled    = optional(bool, false)
    default_to_oauth_authentication  = optional(bool)
    is_hns_enabled                   = optional(bool)
    nfsv3_enabled                    = optional(bool)
    custom_domain = optional(object({
      name          = string
      use_subdomain = optional(bool)
    }))
    customer_managed_key = optional(object({
      key_vault_key_id          = string
      managed_hsm_key_id        = optional(string)
      user_assigned_identity_id = string
    }))
    identity = optional(object({
      type         = string
      identity_ids = optional(list(string))
    }))
    blob_properties = optional(object({
      cors_rule = optional(object({
        allowed_headers    = list(string)
        allowed_methods    = list(string)
        allowed_origins    = list(string)
        exposed_headers    = list(string)
        max_age_in_seconds = number
      }))
      delete_retention_policy = optional(object({
        days                     = optional(number)
        permanent_delete_enabled = optional(bool)
      }))
      restore_policy = optional(object({
        days = optional(number)
      }))
      versioning_enabled            = optional(bool)
      change_feed_enabled           = optional(bool)
      change_feed_retention_in_days = optional(number)
      default_service_version       = optional(string)
      last_access_time_enabled      = optional(bool)
      container_delete_retention_policy = optional(object({
        days = optional(number)
      }))
    }))
    queue_properties = optional(object({
      cors_rule = optional(object({
        allowed_headers    = list(string)
        allowed_methods    = list(string)
        allowed_origins    = list(string)
        exposed_headers    = list(string)
        max_age_in_seconds = number
      }))
      logging = optional(object({
        delete                = bool
        read                  = bool
        version               = string
        write                 = bool
        retention_policy_days = optional(number)
      }))
      minute_metrics = optional(object({
        enabled               = bool
        version               = string
        include_apis          = optional(bool)
        retention_policy_days = optional(number)
      }))
      hour_metrics = optional(object({
        enabled               = bool
        version               = string
        include_apis          = optional(bool)
        retention_policy_days = optional(number)
      }))
    }))
    static_website = optional(object({
      index_document     = optional(string)
      error_404_document = optional(string)
    }))
    share_properties = optional(object({
      cors_rule = optional(object({
        allowed_headers    = list(string)
        allowed_methods    = list(string)
        allowed_origins    = list(string)
        exposed_headers    = list(string)
        max_age_in_seconds = number
      }))
      retention_policy = optional(object({
        days = optional(number)
      }))
      smb = optional(object({
        versions                        = optional(list(string))
        authentication_types            = optional(list(string))
        kerberos_ticket_encryption_type = optional(list(string))
        channel_encryption_type         = optional(list(string))
        multichannel_enabled            = optional(bool)
      }))
    }))
    network_rules = optional(object({
      default_action             = string
      bypass                     = optional(list(string))
      ip_rules                   = optional(list(string))
      virtual_network_subnet_ids = optional(list(string))
      private_link_access = optional(list(object({
        endpoint_resource_id = string
        endpoint_tenant_id   = optional(string)
      })), [])
    }))
    large_file_share_enabled = optional(bool)
    local_user_enabled       = optional(bool)
    azure_files_authentication = optional(object({
      directory_type = string
      active_directory = optional(object({
        domain_name         = string
        domain_guid         = string
        domain_sid          = optional(string)
        storage_sid         = optional(string)
        forest_name         = optional(string)
        netbios_domain_name = optional(string)
      }))
      default_share_level_permission = optional(string)
    }))
    routing = optional(object({
      publish_internet_endpoints  = optional(bool)
      publish_microsoft_endpoints = optional(bool)
      choice                      = optional(string)
    }))
    queue_encryption_key_type         = optional(string)
    table_encryption_key_type         = optional(string)
    infrastructure_encryption_enabled = optional(bool)
    immutability_policy = optional(object({
      allow_protected_append_writes = bool
      state                         = string
      period_since_creation_in_days = number
    }))
    sas_policy = optional(object({
      expiration_period = string
      expiration_action = optional(string)
    }))
    allowed_copy_scope = optional(string)
    sftp_enabled       = optional(bool)
    dns_endpoint_type  = optional(string)
    tags               = optional(map(any))

    # storage container
    containers = optional(list(object({
      name                              = string
      storage_account_name              = optional(string) # Deprecated, use only for backward compatibility. See Known Issues in README.md for migration instructions.
      storage_account_id                = optional(string) # Inherited in module from parent resource
      container_access_type             = optional(string)
      default_encryption_scope          = optional(string)
      encryption_scope_override_enabled = optional(bool)
      metadata                          = optional(map(string))
    })), [])

    # storage share
    file_shares = optional(list(object({
      name                 = string
      storage_account_name              = optional(string) # Deprecated, use only for backward compatibility. See Known Issues in README.md for migration instructions.
      storage_account_id                = optional(string) # Inherited in module from parent resource
      quota                = number
      access_tier          = optional(string)
      acl = optional(list(object({
        id = string
        access_policy = optional(object({
          permissions = string
          start       = optional(string)
          expiry      = optional(string)
        }))
      })), [])
      enabled_protocol = optional(string)
      metadata         = optional(map(string))

      # backup protected file share
      share_backup = optional(object({
        resource_group_name       = optional(string) # If not provided, inherited in module from storage account
        recovery_vault_name       = string
        source_storage_account_id = optional(string) # Inherited in module from parent resource
        source_file_share_name    = optional(string) # Inherited in module from parent resource
        backup_policy_id          = string
      }))
    })), [])

    # storage queue
    queues = optional(list(object({
      name                 = string
      storage_account_name = optional(string) # Inherited in module from parent resource
      metadata             = optional(map(string))
    })), [])

    # storage table
    tables = optional(list(object({
      name                 = string
      storage_account_name = optional(string) # Inherited in module from parent resource
      acl = optional(list(object({
        id = string
        access_policy = optional(object({
          expiry      = string
          permissions = string
          start       = string
        }))
      })), [])
    })), [])

    # storage management policy
    management_policy = optional(object({
      storage_account_id = optional(string) # Inherited in module from parent resource
      rule = optional(list(object({
        name    = string
        enabled = optional(bool, true)
        filters = object({
          blob_types = list(string)
        })
        actions = object({
          version = optional(object({
            delete_after_days_since_creation = optional(number)
          }))
        })
      })), [])
    }))

    # backup container storage account
    backup_container = optional(object({     # Required if you want to backup file shares
      resource_group_name = optional(string) # If not provided, inherited in module from parent resource
      recovery_vault_name = string
      storage_account_id  = optional(string) # Inherited in module from parent resource
    }))

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
      categories_storage = optional(object({
        transaction = optional(bool, true)
        capacity    = optional(bool, true)
      }))
      categories_blob = optional(object({
        storage_read   = optional(bool, true)
        storage_write  = optional(bool, true)
        storage_delete = optional(bool, true)
        transaction    = optional(bool, true)
        capacity       = optional(bool, true)
      }))
      categories_queue = optional(object({
        storage_read   = optional(bool, true)
        storage_write  = optional(bool, true)
        storage_delete = optional(bool, true)
        transaction    = optional(bool, true)
        capacity       = optional(bool, true)
      }))
      categories_table = optional(object({
        storage_read   = optional(bool, true)
        storage_write  = optional(bool, true)
        storage_delete = optional(bool, true)
        transaction    = optional(bool, true)
        capacity       = optional(bool, true)
      }))
      categories_file = optional(object({
        storage_read   = optional(bool, true)
        storage_write  = optional(bool, true)
        storage_delete = optional(bool, true)
        transaction    = optional(bool, true)
        capacity       = optional(bool, true)
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
|account_tier | string | Required |  |  |
|account_replication_type | string | Required |  |  |
|account_kind | string | Optional |  |  |
|cross_tenant_replication_enabled | bool | Optional |  |  |
|access_tier | string | Optional |  |  |
|edge_zone | string | Optional |  |  |
|https_traffic_only_enabled | bool | Optional |  |  |
|min_tls_version | string | Optional |  |  |
|allow_nested_items_to_be_public | bool | Optional |  false |  |
|shared_access_key_enabled | bool | Optional |  |  |
|public_network_access_enabled | bool | Optional |  false |  |
|default_to_oauth_authentication | bool | Optional |  |  |
|is_hns_enabled | bool | Optional |  |  |
|nfsv3_enabled | bool | Optional |  |  |
|custom_domain | object | Optional |  |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;use_subdomain | bool | Optional |  |  |
|customer_managed_key | object | Optional |  |  |
|&nbsp;key_vault_key_id | string | Required |  |  |
|&nbsp;managed_hsm_key_id | string | Optional |  |  |
|&nbsp;user_assigned_identity_id | string | Required |  |  |
|identity | object | Optional |  |  |
|&nbsp;type | string | Required |  |  |
|&nbsp;identity_ids | list(string) | Optional |  |  |
|blob_properties | object | Optional |  |  |
|&nbsp;cors_rule | object | Optional |  |  |
|&nbsp;&nbsp;allowed_headers | list(string) | Required |  |  |
|&nbsp;&nbsp;allowed_methods | list(string) | Required |  |  |
|&nbsp;&nbsp;allowed_origins | list(string) | Required |  |  |
|&nbsp;&nbsp;exposed_headers | list(string) | Required |  |  |
|&nbsp;&nbsp;max_age_in_seconds | number | Required |  |  |
|&nbsp;delete_retention_policy | object | Optional |  |  |
|&nbsp;&nbsp;days | number | Optional |  |  |
|&nbsp;&nbsp;permanent_delete_enabled | bool | Optional |  |  |
|&nbsp;restore_policy | object | Optional |  |  |
|&nbsp;&nbsp;days | number | Optional |  |  |
|&nbsp;versioning_enabled | bool | Optional |  |  |
|&nbsp;change_feed_enabled | bool | Optional |  |  |
|&nbsp;change_feed_retention_in_days | number | Optional |  |  |
|&nbsp;default_service_version | string | Optional |  |  |
|&nbsp;last_access_time_enabled | bool | Optional |  |  |
|&nbsp;container_delete_retention_policy | object | Optional |  |  |
|&nbsp;&nbsp;days | number | Optional |  |  |
|queue_properties | object | Optional |  |  |
|&nbsp;cors_rule | object | Optional |  |  |
|&nbsp;&nbsp;allowed_headers | list(string) | Required |  |  |
|&nbsp;&nbsp;allowed_methods | list(string) | Required |  |  |
|&nbsp;&nbsp;allowed_origins | list(string) | Required |  |  |
|&nbsp;&nbsp;exposed_headers | list(string) | Required |  |  |
|&nbsp;&nbsp;max_age_in_seconds | number | Required |  |  |
|&nbsp;logging | object | Optional |  |  |
|&nbsp;&nbsp;delete | bool | Required |  |  |
|&nbsp;&nbsp;read | bool | Required |  |  |
|&nbsp;&nbsp;version | string | Required |  |  |
|&nbsp;&nbsp;write | bool | Required |  |  |
|&nbsp;&nbsp;retention_policy_days | number | Optional |  |  |
|&nbsp;minute_metrics | object | Optional |  |  |
|&nbsp;&nbsp;enabled | bool | Required |  |  |
|&nbsp;&nbsp;version | string | Required |  |  |
|&nbsp;&nbsp;include_apis | bool | Optional |  |  |
|&nbsp;&nbsp;retention_policy_days | number | Optional |  |  |
|&nbsp;hour_metrics | object | Optional |  |  |
|&nbsp;&nbsp;enabled | bool | Required |  |  |
|&nbsp;&nbsp;version | string | Required |  |  |
|&nbsp;&nbsp;include_apis | bool | Optional |  |  |
|&nbsp;&nbsp;retention_policy_days | number | Optional |  |  |
|static_website | object | Optional |  |  |
|&nbsp;index_document | string | Optional |  |  |
|&nbsp;error_404_document | string | Optional |  |  |
|share_properties | object | Optional |  |  |
|&nbsp;cors_rule | object | Optional |  |  |
|&nbsp;&nbsp;allowed_headers | list(string) | Required |  |  |
|&nbsp;&nbsp;allowed_methods | list(string) | Required |  |  |
|&nbsp;&nbsp;allowed_origins | list(string) | Required |  |  |
|&nbsp;&nbsp;exposed_headers | list(string) | Required |  |  |
|&nbsp;&nbsp;max_age_in_seconds | number | Required |  |  |
|&nbsp;retention_policy | object | Optional |  |  |
|&nbsp;&nbsp;days | number | Optional |  |  |
|&nbsp;smb | object | Optional |  |  |
|&nbsp;&nbsp;versions | list(string) | Optional |  |  |
|&nbsp;&nbsp;authentication_types | list(string) | Optional |  |  |
|&nbsp;&nbsp;kerberos_ticket_encryption_type | list(string) | Optional |  |  |
|&nbsp;&nbsp;channel_encryption_type | list(string) | Optional |  |  |
|&nbsp;&nbsp;multichannel_enabled | bool | Optional |  |  |
|network_rules | object | Optional |  |  |
|&nbsp;default_action | string | Required |  |  |
|&nbsp;bypass | list(string) | Optional |  |  |
|&nbsp;ip_rules | list(string) | Optional |  |  |
|&nbsp;virtual_network_subnet_ids | list(string) | Optional |  |  |
|&nbsp;private_link_access | list(object) | Optional | [] |  |
|&nbsp;&nbsp;endpoint_resource_id | string | Required |  |  |
|&nbsp;&nbsp;endpoint_tenant_id | string | Optional |  |  |
|large_file_share_enabled | bool | Optional |  |  |
|local_user_enabled | bool | Optional |  |  |
|azure_files_authentication | object | Optional |  |  |
|&nbsp;directory_type | string | Required |  |  |
|&nbsp;active_directory | object | Optional |  |  |
|&nbsp;&nbsp;domain_name | string | Required |  |  |
|&nbsp;&nbsp;domain_guid | string | Required |  |  |
|&nbsp;&nbsp;domain_sid | string | Optional |  |  |
|&nbsp;&nbsp;storage_sid | string | Optional |  |  |
|&nbsp;&nbsp;forest_name | string | Optional |  |  |
|&nbsp;&nbsp;netbios_domain_name | string | Optional |  |  |
|&nbsp;default_share_level_permission | string | Optional |  |  |
|routing | object | Optional |  |  |
|&nbsp;publish_internet_endpoints | bool | Optional |  |  |
|&nbsp;publish_microsoft_endpoints | bool | Optional |  |  |
|&nbsp;choice | string | Optional |  |  |
|queue_encryption_key_type | string | Optional |  |  |
|table_encryption_key_type | string | Optional |  |  |
|infrastructure_encryption_enabled | bool | Optional |  |  |
|immutability_policy | object | Optional |  |  |
|&nbsp;allow_protected_append_writes | bool | Required |  |  |
|&nbsp;state | string | Required |  |  |
|&nbsp;period_since_creation_in_days | number | Required |  |  |
|sas_policy | object | Optional |  |  |
|&nbsp;expiration_period | string | Required |  |  |
|&nbsp;expiration_action | string | Optional |  |  |
|allowed_copy_scope | string | Optional |  |  |
|sftp_enabled | bool | Optional |  |  |
|dns_endpoint_type | string | Optional |  |  |
|tags | map(any) | Optional |  |  |
|containers | list(object) | Optional | [] |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;storage_account_name | string | Optional |  |  Deprecated, use only for backward compatibility. See Known Issues in README.md for migration instructions. |
|&nbsp;storage_account_id | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;container_access_type | string | Optional |  |  |
|&nbsp;default_encryption_scope | string | Optional |  |  |
|&nbsp;encryption_scope_override_enabled | bool | Optional |  |  |
|&nbsp;metadata | map(string) | Optional |  |  |
|file_shares | list(object) | Optional | [] |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;storage_account_name | string | Optional |  |  Deprecated, use only for backward compatibility. See Known Issues in README.md for migration instructions. |
|&nbsp;storage_account_id | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;quota | number | Required |  |  |
|&nbsp;access_tier | string | Optional |  |  |
|&nbsp;acl | list(object) | Optional | [] |  |
|&nbsp;&nbsp;id | string | Required |  |  |
|&nbsp;&nbsp;access_policy | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;permissions | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;start | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;expiry | string | Optional |  |  |
|&nbsp;enabled_protocol | string | Optional |  |  |
|&nbsp;metadata | map(string) | Optional |  |  |
|&nbsp;share_backup | object | Optional |  |  |
|&nbsp;&nbsp;resource_group_name | string | Optional |  |  If not provided, inherited in module from storage account |
|&nbsp;&nbsp;recovery_vault_name | string | Required |  |  |
|&nbsp;&nbsp;source_storage_account_id | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;&nbsp;source_file_share_name | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;&nbsp;backup_policy_id | string | Required |  |  |
|queues | list(object) | Optional | [] |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;storage_account_name | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;metadata | map(string) | Optional |  |  |
|tables | list(object) | Optional | [] |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;storage_account_name | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;acl | list(object) | Optional | [] |  |
|&nbsp;&nbsp;id | string | Required |  |  |
|&nbsp;&nbsp;access_policy | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;expiry | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;permissions | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;start | string | Required |  |  |
|management_policy | object | Optional |  |  |
|&nbsp;storage_account_id | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;rule | list(object) | Optional | [] |  |
|&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;enabled | bool | Optional |  true |  |
|&nbsp;&nbsp;filters | object | Required |  |  |
|&nbsp;&nbsp;&nbsp;blob_types | list(string) | Required |  |  |
|&nbsp;&nbsp;actions | object | Required |  |  |
|&nbsp;&nbsp;&nbsp;version | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;delete_after_days_since_creation | number | Optional |  |  |
|backup_container | object | Optional |  |  Required if you want to backup file shares |
|&nbsp;resource_group_name | string | Optional |  |  If not provided, inherited in module from parent resource |
|&nbsp;recovery_vault_name | string | Required |  |  |
|&nbsp;storage_account_id | string | Optional |  |  Inherited in module from parent resource |
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
|&nbsp;categories_storage | object | Optional |  |  |
|&nbsp;&nbsp;transaction | bool | Optional |  true |  |
|&nbsp;&nbsp;capacity | bool | Optional |  true |  |
|&nbsp;categories_blob | object | Optional |  |  |
|&nbsp;&nbsp;storage_read | bool | Optional |  true |  |
|&nbsp;&nbsp;storage_write | bool | Optional |  true |  |
|&nbsp;&nbsp;storage_delete | bool | Optional |  true |  |
|&nbsp;&nbsp;transaction | bool | Optional |  true |  |
|&nbsp;&nbsp;capacity | bool | Optional |  true |  |
|&nbsp;categories_queue | object | Optional |  |  |
|&nbsp;&nbsp;storage_read | bool | Optional |  true |  |
|&nbsp;&nbsp;storage_write | bool | Optional |  true |  |
|&nbsp;&nbsp;storage_delete | bool | Optional |  true |  |
|&nbsp;&nbsp;transaction | bool | Optional |  true |  |
|&nbsp;&nbsp;capacity | bool | Optional |  true |  |
|&nbsp;categories_table | object | Optional |  |  |
|&nbsp;&nbsp;storage_read | bool | Optional |  true |  |
|&nbsp;&nbsp;storage_write | bool | Optional |  true |  |
|&nbsp;&nbsp;storage_delete | bool | Optional |  true |  |
|&nbsp;&nbsp;transaction | bool | Optional |  true |  |
|&nbsp;&nbsp;capacity | bool | Optional |  true |  |
|&nbsp;categories_file | object | Optional |  |  |
|&nbsp;&nbsp;storage_read | bool | Optional |  true |  |
|&nbsp;&nbsp;storage_write | bool | Optional |  true |  |
|&nbsp;&nbsp;storage_delete | bool | Optional |  true |  |
|&nbsp;&nbsp;transaction | bool | Optional |  true |  |
|&nbsp;&nbsp;capacity | bool | Optional |  true |  |


