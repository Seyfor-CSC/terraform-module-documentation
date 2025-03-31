# Variables

```
variable "config" {  type = list(object({
    # mssql server
    name                                    = string
    resource_group_name                     = string
    location                                = string
    version                                 = string
    administrator_login                     = optional(string)
    administrator_login_password            = optional(string)
    administrator_login_password_wo         = optional(string)
    administrator_login_password_wo_version = optional(string)
    azuread_administrator = optional(object({
      login_username              = string
      object_id                   = string
      tenant_id                   = optional(string)
      azuread_authentication_only = optional(bool)
    }))
    connection_policy = optional(string)
    identity = optional(object({
      type         = string
      identity_ids = optional(list(string))
    }))
    transparent_data_encryption_key_vault_key_id = optional(string)
    minimum_tls_version                          = optional(string)
    public_network_access_enabled                = optional(bool, false)
    outbound_network_restriction_enabled         = optional(bool)
    primary_user_assigned_identity_id            = optional(string)
    tags                                         = optional(map(any))

    # mssql elasticpool
    mssql_elasticpool = optional(list(object({
      name                = string
      resource_group_name = optional(string) # If not provided, inherited in module from parent resource
      location            = optional(string) # Inherited in module from parent resource 
      server_name         = optional(string) # Inherited in module from parent resource
      sku = object({
        name     = string
        capacity = number
        tier     = string
        family   = optional(string)
      })
      per_database_settings = object({
        min_capacity = number
        max_capacity = number
      })
      maintenance_configuration_name = optional(string)
      max_size_gb                    = optional(number)
      max_size_bytes                 = optional(number)
      enclave_type                   = optional(string)
      zone_redundant                 = optional(bool)
      license_type                   = optional(string)
      tags                           = optional(map(any)) # If not provided, inherited in module from parent resource

      # monitoring
      monitoring = optional(list(object({                 # Custom object for enabling diagnostic settings
        diag_name                      = optional(string) # Name of the diagnostic setting
        log_analytics_workspace_id     = optional(string)
        eventhub_name                  = optional(string)
        eventhub_authorization_rule_id = optional(string)
        storage_account_id             = optional(string)
        categories = optional(object({
          basic                     = optional(bool, true)
          instance_and_app_advanced = optional(bool, true)
        }))
      })), [])
    })), [])

    # mssql database
    mssql_db = optional(list(object({
      name                        = string
      server_id                   = optional(string) # Inherited in module from parent resource
      auto_pause_delay_in_minutes = optional(number)
      create_mode                 = optional(string)
      import = optional(object({
        storage_uri                  = string
        storage_key                  = string
        storage_key_type             = string
        administrator_login          = string
        administrator_login_password = string
        authentication_type          = string
        storage_account_id           = optional(string)
      }))
      creation_source_database_id    = optional(string)
      collation                      = optional(string)
      elastic_pool_id                = optional(string) # Do not use, is replaced by elastic_pool_name parameter
      elastic_pool_name              = optional(string) # Custom variable replacing elastic_pool_id parameter. Elastic Pool name, which is being created in this module, is expected
      enclave_type                   = optional(string)
      geo_backup_enabled             = optional(bool)
      maintenance_configuration_name = optional(string)
      ledger_enabled                 = optional(bool)
      license_type                   = optional(string)
      long_term_retention_policy = optional(object({
        weekly_retention  = optional(string)
        monthly_retention = optional(string)
        yearly_retention  = optional(string)
        week_of_year      = optional(number)
      }))
      max_size_gb                           = optional(number)
      min_capacity                          = optional(number)
      restore_point_in_time                 = optional(string)
      recover_database_id                   = optional(string)
      recovery_point_id                     = optional(string)
      restore_dropped_database_id           = optional(string)
      restore_long_term_retention_backup_id = optional(string)
      read_replica_count                    = optional(number)
      read_scale                            = optional(bool)
      sample_name                           = optional(string)
      short_term_retention_policy = optional(object({
        retention_days           = number
        backup_interval_in_hours = optional(number)
      }))
      sku_name             = optional(string)
      storage_account_type = optional(string)
      threat_detection_policy = optional(object({
        state                      = optional(string)
        disabled_alerts            = optional(list(string))
        email_account_admins       = optional(string)
        email_addresses            = optional(list(string))
        retention_days             = optional(number)
        storage_account_access_key = optional(string)
        storage_endpoint           = optional(string)
      }))
      identity = optional(object({
        type         = string
        identity_ids = list(string)
      }))
      transparent_data_encryption_enabled                        = optional(bool)
      transparent_data_encryption_key_vault_key_id               = optional(string)
      transparent_data_encryption_key_automatic_rotation_enabled = optional(bool)
      zone_redundant                                             = optional(bool)
      secondary_type                                             = optional(string)
      tags                                                       = optional(map(any)) # If not provided, inherited in module from parent resource

      # mssql database extended auditing policy
      db_auditing_policy = optional(object({
        database_id                             = optional(string) # Inherited in module from parent resource
        enabled                                 = optional(bool)
        storage_endpoint                        = optional(string)
        retention_in_days                       = optional(number)
        storage_account_access_key              = optional(string)
        storage_account_access_key_is_secondary = optional(bool)
        log_monitoring_enabled                  = optional(bool)
      }))

      # monitoring
      monitoring = optional(list(object({                 # Custom object for enabling diagnostic settings
        diag_name                      = optional(string) # Name of the diagnostic setting
        log_analytics_workspace_id     = optional(string)
        eventhub_name                  = optional(string)
        eventhub_authorization_rule_id = optional(string)
        storage_account_id             = optional(string)
        categories = optional(object({
          sql_insights                   = optional(bool, true)
          automatic_tuning               = optional(bool, true)
          query_store_runtime_statistics = optional(bool, true)
          query_store_wait_statistics    = optional(bool, true)
          errors                         = optional(bool, true)
          database_wait_statistics       = optional(bool, true)
          timeouts                       = optional(bool, true)
          blocks                         = optional(bool, true)
          deadlocks                      = optional(bool, true)
          basic                          = optional(bool, true)
          instance_and_app_advanced      = optional(bool, true)
          workload_management            = optional(bool, true)
        }))
      })), [])
    })), [])

    # mssql firewall rule
    firewall_rule = optional(list(object({
      name             = string
      server_id        = optional(string) # Inherited in module from parent resource
      start_ip_address = string
      end_ip_address   = string
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
  }))
}


```


## Table with config variables

| Name | Data Type | Requirement | Default Value | Comment |
| ------- | --------- | ----------- | ------------- | ------- |
|name | string | Required |  |  |
|resource_group_name | string | Required |  |  |
|location | string | Required |  |  |
|version | string | Required |  |  |
|administrator_login | string | Optional |  |  |
|administrator_login_password | string | Optional |  |  |
|administrator_login_password_wo | string | Optional |  |  |
|administrator_login_password_wo_version | string | Optional |  |  |
|azuread_administrator | object | Optional |  |  |
|&nbsp;login_username | string | Required |  |  |
|&nbsp;object_id | string | Required |  |  |
|&nbsp;&nbsp;tenant_id | string | Optional |  |  |
|&nbsp;&nbsp;azuread_authentication_only | bool | Optional |  |  |
|&nbsp;connection_policy | string | Optional |  |  |
|&nbsp;identity | object | Optional |  |  |
|&nbsp;&nbsp;type | string | Required |  |  |
|&nbsp;&nbsp;identity_ids | list(string) | Optional |  |  |
|&nbsp;transparent_data_encryption_key_vault_key_id | string | Optional |  |  |
|&nbsp;minimum_tls_version | string | Optional |  |  |
|&nbsp;public_network_access_enabled | bool | Optional |  false |  |
|&nbsp;outbound_network_restriction_enabled | bool | Optional |  |  |
|&nbsp;primary_user_assigned_identity_id | string | Optional |  |  |
|&nbsp;tags | map(any) | Optional |  |  |
|&nbsp;mssql_elasticpool | list(object) | Optional | [] |  |
|&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;resource_group_name | string | Optional |  |  If not provided, inherited in module from parent resource |
|&nbsp;&nbsp;location | string | Optional |  |  Inherited in module from parent resource  |
|&nbsp;&nbsp;server_name | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;&nbsp;sku | object | Required |  |  |
|&nbsp;&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;capacity | number | Required |  |  |
|&nbsp;&nbsp;&nbsp;tier | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;family | string | Optional |  |  |
|&nbsp;&nbsp;per_database_settings | object | Required |  |  |
|&nbsp;&nbsp;&nbsp;min_capacity | number | Required |  |  |
|&nbsp;&nbsp;&nbsp;max_capacity | number | Required |  |  |
|&nbsp;&nbsp;maintenance_configuration_name | string | Optional |  |  |
|&nbsp;&nbsp;max_size_gb | number | Optional |  |  |
|&nbsp;&nbsp;max_size_bytes | number | Optional |  |  |
|&nbsp;&nbsp;enclave_type | string | Optional |  |  |
|&nbsp;&nbsp;zone_redundant | bool | Optional |  |  |
|&nbsp;&nbsp;license_type | string | Optional |  |  |
|&nbsp;&nbsp;tags | map(any) | Optional |  |  If not provided, inherited in module from parent resource |
|&nbsp;&nbsp;monitoring | list(object) | Optional | [] |  Custom object for enabling diagnostic settings |
|&nbsp;&nbsp;&nbsp;diag_name | string | Optional |  |  Name of the diagnostic setting |
|&nbsp;&nbsp;&nbsp;log_analytics_workspace_id | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;eventhub_name | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;eventhub_authorization_rule_id | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;storage_account_id | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;categories | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;basic | bool | Optional |  true |  |
|&nbsp;&nbsp;&nbsp;&nbsp;instance_and_app_advanced | bool | Optional |  true |  |
|&nbsp;mssql_db | list(object) | Optional | [] |  |
|&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;server_id | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;&nbsp;auto_pause_delay_in_minutes | number | Optional |  |  |
|&nbsp;&nbsp;create_mode | string | Optional |  |  |
|&nbsp;&nbsp;import | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;storage_uri | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;storage_key | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;storage_key_type | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;administrator_login | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;administrator_login_password | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;authentication_type | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;storage_account_id | string | Optional |  |  |
|&nbsp;&nbsp;creation_source_database_id | string | Optional |  |  |
|&nbsp;&nbsp;collation | string | Optional |  |  |
|&nbsp;&nbsp;elastic_pool_id | string | Optional |  |  Do not use, is replaced by elastic_pool_name parameter |
|&nbsp;&nbsp;elastic_pool_name | string | Optional |  |  Custom variable replacing elastic_pool_id parameter. Elastic Pool name, which is being created in this module, is expected |
|&nbsp;&nbsp;enclave_type | string | Optional |  |  |
|&nbsp;&nbsp;geo_backup_enabled | bool | Optional |  |  |
|&nbsp;&nbsp;maintenance_configuration_name | string | Optional |  |  |
|&nbsp;&nbsp;ledger_enabled | bool | Optional |  |  |
|&nbsp;&nbsp;license_type | string | Optional |  |  |
|&nbsp;&nbsp;long_term_retention_policy | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;weekly_retention | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;monthly_retention | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;yearly_retention | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;week_of_year | number | Optional |  |  |
|&nbsp;&nbsp;max_size_gb | number | Optional |  |  |
|&nbsp;&nbsp;min_capacity | number | Optional |  |  |
|&nbsp;&nbsp;restore_point_in_time | string | Optional |  |  |
|&nbsp;&nbsp;recover_database_id | string | Optional |  |  |
|&nbsp;&nbsp;recovery_point_id | string | Optional |  |  |
|&nbsp;&nbsp;restore_dropped_database_id | string | Optional |  |  |
|&nbsp;&nbsp;restore_long_term_retention_backup_id | string | Optional |  |  |
|&nbsp;&nbsp;read_replica_count | number | Optional |  |  |
|&nbsp;&nbsp;read_scale | bool | Optional |  |  |
|&nbsp;&nbsp;sample_name | string | Optional |  |  |
|&nbsp;&nbsp;short_term_retention_policy | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;retention_days | number | Required |  |  |
|&nbsp;&nbsp;&nbsp;backup_interval_in_hours | number | Optional |  |  |
|&nbsp;&nbsp;sku_name | string | Optional |  |  |
|&nbsp;&nbsp;storage_account_type | string | Optional |  |  |
|&nbsp;&nbsp;threat_detection_policy | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;state | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;disabled_alerts | list(string) | Optional |  |  |
|&nbsp;&nbsp;&nbsp;email_account_admins | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;email_addresses | list(string) | Optional |  |  |
|&nbsp;&nbsp;&nbsp;retention_days | number | Optional |  |  |
|&nbsp;&nbsp;&nbsp;storage_account_access_key | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;storage_endpoint | string | Optional |  |  |
|&nbsp;&nbsp;identity | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;type | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;identity_ids | list(string) | Required |  |  |
|&nbsp;&nbsp;transparent_data_encryption_enabled | bool | Optional |  |  |
|&nbsp;&nbsp;transparent_data_encryption_key_vault_key_id | string | Optional |  |  |
|&nbsp;&nbsp;transparent_data_encryption_key_automatic_rotation_enabled | bool | Optional |  |  |
|&nbsp;&nbsp;zone_redundant | bool | Optional |  |  |
|&nbsp;&nbsp;secondary_type | string | Optional |  |  |
|&nbsp;&nbsp;tags | map(any) | Optional |  |  If not provided, inherited in module from parent resource |
|&nbsp;&nbsp;db_auditing_policy | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;database_id | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;&nbsp;&nbsp;enabled | bool | Optional |  |  |
|&nbsp;&nbsp;&nbsp;storage_endpoint | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;retention_in_days | number | Optional |  |  |
|&nbsp;&nbsp;&nbsp;storage_account_access_key | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;storage_account_access_key_is_secondary | bool | Optional |  |  |
|&nbsp;&nbsp;&nbsp;log_monitoring_enabled | bool | Optional |  |  |
|&nbsp;&nbsp;monitoring | list(object) | Optional | [] |  Custom object for enabling diagnostic settings |
|&nbsp;&nbsp;&nbsp;diag_name | string | Optional |  |  Name of the diagnostic setting |
|&nbsp;&nbsp;&nbsp;log_analytics_workspace_id | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;eventhub_name | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;eventhub_authorization_rule_id | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;storage_account_id | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;categories | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;sql_insights | bool | Optional |  true |  |
|&nbsp;&nbsp;&nbsp;&nbsp;automatic_tuning | bool | Optional |  true |  |
|&nbsp;&nbsp;&nbsp;&nbsp;query_store_runtime_statistics | bool | Optional |  true |  |
|&nbsp;&nbsp;&nbsp;&nbsp;query_store_wait_statistics | bool | Optional |  true |  |
|&nbsp;&nbsp;&nbsp;&nbsp;errors | bool | Optional |  true |  |
|&nbsp;&nbsp;&nbsp;&nbsp;database_wait_statistics | bool | Optional |  true |  |
|&nbsp;&nbsp;&nbsp;&nbsp;timeouts | bool | Optional |  true |  |
|&nbsp;&nbsp;&nbsp;&nbsp;blocks | bool | Optional |  true |  |
|&nbsp;&nbsp;&nbsp;&nbsp;deadlocks | bool | Optional |  true |  |
|&nbsp;&nbsp;&nbsp;&nbsp;basic | bool | Optional |  true |  |
|&nbsp;&nbsp;&nbsp;&nbsp;instance_and_app_advanced | bool | Optional |  true |  |
|&nbsp;&nbsp;&nbsp;&nbsp;workload_management | bool | Optional |  true |  |
|&nbsp;firewall_rule | list(object) | Optional | [] |  |
|&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;server_id | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;&nbsp;start_ip_address | string | Required |  |  |
|&nbsp;&nbsp;end_ip_address | string | Required |  |  |
|&nbsp;private_endpoint | list(object) | Optional | [] |  |
|&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;resource_group_name | string | Optional |  |  If not provided, inherited in module from parent resource |
|&nbsp;&nbsp;location | string | Optional |  |  If not provided, inherited in module from parent resource |
|&nbsp;&nbsp;subnet_id | string | Required |  |  |
|&nbsp;&nbsp;private_service_connection | list(object) | Required |  |  |
|&nbsp;&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;is_manual_connection | bool | Required |  |  |
|&nbsp;&nbsp;&nbsp;private_connection_resource_id | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;private_connection_resource_alias | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;subresource_names | list(string) | Optional |  |  |
|&nbsp;&nbsp;&nbsp;request_message | string | Optional |  |  |
|&nbsp;&nbsp;custom_network_interface_name | string | Optional |  |  |
|&nbsp;&nbsp;private_dns_zone_group | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;private_dns_zone_ids | list(string) | Required |  |  |
|&nbsp;&nbsp;ip_configuration | list(object) | Optional | [] |  |
|&nbsp;&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;private_ip_address | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;subresource_name | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;member_name | string | Optional |  |  |
|&nbsp;&nbsp;tags | map(any) | Optional |  |  If not provided, inherited in module from parent resource |


