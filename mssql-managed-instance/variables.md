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
    zone_redundant_enabled         = optional(bool)
    timezone_id                    = optional(string)
    tags                           = optional(map(any))

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
        sql_security_audit_events = optional(bool, true)
        devops_operations_audit   = optional(bool, true)
        resource_usage_stats      = optional(bool, true)
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
|zone_redundant_enabled | bool | Optional |  |  |
|timezone_id | string | Optional |  |  |
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
|&nbsp;&nbsp;sql_security_audit_events | bool | Optional |  true |  |
|&nbsp;&nbsp;devops_operations_audit | bool | Optional |  true |  |
|&nbsp;&nbsp;resource_usage_stats | bool | Optional |  true |  |


