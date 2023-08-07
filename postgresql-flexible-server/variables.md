# Variables

```
variable "config" {  type = list(object({
    # postgresql flexible server
    name                   = string
    resource_group_name    = string
    location               = string
    administrator_login    = optional(string)
    administrator_password = optional(string)
    authentication = optional(object({
      active_directory_auth_enabled = optional(bool)
      password_auth_enabled         = optional(bool)
      tenant_id                     = optional(string)
    }))
    backup_retention_days = optional(number)
    customer_managed_key = optional(object({
      key_vault_key_id                     = optional(string)
      primary_user_assigned_identity_id    = optional(string)
      geo_backup_key_vault_key_id          = optional(string)
      geo_backup_user_assigned_identity_id = optional(string)
    }))
    geo_redundant_backup_enabled = optional(bool)
    create_mode                  = optional(string)
    delegated_subnet_id          = optional(string)
    private_dns_zone_id          = optional(string)
    high_availability = optional(object({
      mode                      = string
      standby_availability_zone = optional(string)
    }))
    identity = optional(object({
      type         = string
      identity_ids = list(string)
    }))
    maintenance_window = optional(object({
      day_of_week  = optional(number)
      start_hour   = optional(number)
      start_minute = optional(number)
    }))
    point_in_time_restore_time_in_utc = optional(string)
    replication_role                  = optional(string)
    sku_name                          = optional(string)
    source_server_id                  = optional(string)
    storage_mb                        = optional(number)
    version                           = optional(string)
    zone                              = optional(string)
    tags                              = optional(map(any))

    # postgresql flexible server database
    flexible_db = optional(list(object({
      name      = string
      server_id = optional(string) # Inherited in module from parent resource
      charset   = optional(string)
      collation = optional(string)
    })), [])

    # postgresql flexible server configuration
    server_configuration = optional(list(object({
      name      = string
      server_id = optional(string) # Inherited in module from parent resource
      value     = string
    })), [])

    # postgresql flexible server active directory administrator
    server_ad_administrator = optional(list(object({
      server_name         = optional(string) # Inherited in module from parent resource
      resource_group_name = optional(string) # If not provided, inherited in module from parent resource
      object_id           = string
      tenant_id           = string
      principal_name      = string
      principal_type      = string
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
|administrator_login | string | Optional |  |  |
|administrator_password | string | Optional |  |  |
|authentication | object | Optional |  |  |
|&nbsp;active_directory_auth_enabled | bool | Optional |  |  |
|&nbsp;password_auth_enabled | bool | Optional |  |  |
|&nbsp;tenant_id | string | Optional |  |  |
|backup_retention_days | number | Optional |  |  |
|customer_managed_key | object | Optional |  |  |
|&nbsp;key_vault_key_id | string | Optional |  |  |
|&nbsp;primary_user_assigned_identity_id | string | Optional |  |  |
|&nbsp;geo_backup_key_vault_key_id | string | Optional |  |  |
|&nbsp;geo_backup_user_assigned_identity_id | string | Optional |  |  |
|geo_redundant_backup_enabled | bool | Optional |  |  |
|create_mode | string | Optional |  |  |
|delegated_subnet_id | string | Optional |  |  |
|private_dns_zone_id | string | Optional |  |  |
|high_availability | object | Optional |  |  |
|&nbsp;mode | string | Required |  |  |
|&nbsp;standby_availability_zone | string | Optional |  |  |
|identity | object | Optional |  |  |
|&nbsp;type | string | Required |  |  |
|&nbsp;identity_ids | list(string) | Required |  |  |
|maintenance_window | object | Optional |  |  |
|&nbsp;day_of_week | number | Optional |  |  |
|&nbsp;start_hour | number | Optional |  |  |
|&nbsp;start_minute | number | Optional |  |  |
|point_in_time_restore_time_in_utc | string | Optional |  |  |
|replication_role | string | Optional |  |  |
|sku_name | string | Optional |  |  |
|source_server_id | string | Optional |  |  |
|storage_mb | number | Optional |  |  |
|version | string | Optional |  |  |
|zone | string | Optional |  |  |
|tags | map(any) | Optional |  |  |
|flexible_db | list(object) | Optional | [] |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;server_id | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;charset | string | Optional |  |  |
|&nbsp;collation | string | Optional |  |  |
|server_configuration | list(object) | Optional | [] |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;server_id | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;value | string | Required |  |  |
|server_ad_administrator | list(object) | Optional | [] |  |
|&nbsp;server_name | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;resource_group_name | string | Optional |  |  If not provided, inherited in module from parent resource |
|&nbsp;object_id | string | Required |  |  |
|&nbsp;&nbsp;tenant_id | string | Required |  |  |
|&nbsp;&nbsp;principal_name | string | Required |  |  |
|&nbsp;&nbsp;principal_type | string | Required |  |  |
|&nbsp;monitoring | list(object) | Optional | [] |  Custom object for enabling diagnostic settings |
|&nbsp;&nbsp;diag_name | string | Optional |  |  Name of the diagnostic setting |
|&nbsp;&nbsp;log_analytics_workspace_id | string | Optional |  |  |
|&nbsp;&nbsp;eventhub_name | string | Optional |  |  |
|&nbsp;&nbsp;eventhub_authorization_rule_id | string | Optional |  |  |


