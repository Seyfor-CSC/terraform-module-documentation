# Variables

```
variable "config" {  type = list(object({
    # mssql managed instance
    name                         = string
    resource_group_name          = string
    location                     = string
    administrator_login          = string
    administrator_login_password = string
    license_type                 = string
    sku_name                     = string
    storage_size_in_gb           = number
    subnet_id                    = string
    vcores                       = number
    collation                    = optional(string)
    dns_zone_partner_id          = optional(string)
    identity = optional(object({
      type         = string
      identity_ids = optional(list(string))
    }))
    maintenance_configuration_name = optional(string)
    minimum_tls_version            = optional(string, "1.2")
    proxy_override                 = optional(string)
    public_data_endpoint_enabled   = optional(bool, false)
    storage_account_type           = optional(string)
    timezone_id                    = optional(string)
    tags                           = optional(map(any))

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
|administrator_login | string | Required |  |  |
|administrator_login_password | string | Required |  |  |
|license_type | string | Required |  |  |
|sku_name | string | Required |  |  |
|storage_size_in_gb | number | Required |  |  |
|subnet_id | string | Required |  |  |
|vcores | number | Required |  |  |
|collation | string | Optional |  |  |
|dns_zone_partner_id | string | Optional |  |  |
|identity | object | Optional |  |  |
|&nbsp;type | string | Required |  |  |
|&nbsp;identity_ids | list(string) | Optional |  |  |
|maintenance_configuration_name | string | Optional |  |  |
|minimum_tls_version | string | Optional |  "1.2" |  |
|proxy_override | string | Optional |  |  |
|public_data_endpoint_enabled | bool | Optional |  false |  |
|storage_account_type | string | Optional |  |  |
|timezone_id | string | Optional |  |  |
|tags | map(any) | Optional |  |  |
|monitoring | list(object) | Optional | [] |  Custom object for enabling diagnostic settings |
|&nbsp;diag_name | string | Optional |  |  Name of the diagnostic setting |
|&nbsp;log_analytics_workspace_id | string | Optional |  |  |
|&nbsp;eventhub_name | string | Optional |  |  |
|&nbsp;eventhub_authorization_rule_id | string | Optional |  |  |


