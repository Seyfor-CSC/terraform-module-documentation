# Variables

```
variable "config" {  type = list(object({
    # key vault
    name                = string
    resource_group_name = string
    location            = string
    sku_name            = string
    tenant_id           = optional(string) # Value is supplyed in module from data source "azurerm_client_config"
    access_policy = optional(list(object({
      tenant_id               = optional(string) # Value is supplyed in module from data source "azurerm_client_config"
      object_id               = string
      application_id          = optional(string)
      certificate_permissions = optional(list(string))
      key_permissions         = optional(list(string))
      secret_permissions      = optional(list(string))
      storage_permissions     = optional(list(string))
    })), [])
    enabled_for_deployment          = optional(bool)
    enabled_for_disk_encryption     = optional(bool)
    enabled_for_template_deployment = optional(bool)
    enable_rbac_authorization       = optional(bool, true)
    network_acls = optional(object({
      bypass                     = optional(string, "AzureServices")
      default_action             = string
      ip_rules                   = optional(list(string))
      virtual_network_subnet_ids = optional(list(string))
    }))
    purge_protection_enabled      = optional(bool)
    public_network_access_enabled = optional(bool)
    soft_delete_retention_days    = optional(number)
    contact = optional(list(object({
      email = string
      name  = optional(string)
      phone = optional(string)
    })), [])
    tags = optional(map(any))

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
|tenant_id | string | Optional |  |  Value is supplyed in module from data source "azurerm_client_config" |
|access_policy | list(object) | Optional | [] |  |
|&nbsp;tenant_id | string | Optional |  |  Value is supplyed in module from data source "azurerm_client_config" |
|&nbsp;object_id | string | Required |  |  |
|&nbsp;&nbsp;application_id | string | Optional |  |  |
|&nbsp;&nbsp;certificate_permissions | list(string) | Optional |  |  |
|&nbsp;&nbsp;key_permissions | list(string) | Optional |  |  |
|&nbsp;&nbsp;secret_permissions | list(string) | Optional |  |  |
|&nbsp;&nbsp;storage_permissions | list(string) | Optional |  |  |
|&nbsp;enabled_for_deployment | bool | Optional |  |  |
|&nbsp;enabled_for_disk_encryption | bool | Optional |  |  |
|&nbsp;enabled_for_template_deployment | bool | Optional |  |  |
|&nbsp;enable_rbac_authorization | bool | Optional |  true |  |
|&nbsp;network_acls | object | Optional |  |  |
|&nbsp;&nbsp;bypass | string | Optional |  "AzureServices" |  |
|&nbsp;&nbsp;default_action | string | Required |  |  |
|&nbsp;&nbsp;ip_rules | list(string) | Optional |  |  |
|&nbsp;&nbsp;virtual_network_subnet_ids | list(string) | Optional |  |  |
|&nbsp;purge_protection_enabled | bool | Optional |  |  |
|&nbsp;public_network_access_enabled | bool | Optional |  |  |
|&nbsp;soft_delete_retention_days | number | Optional |  |  |
|&nbsp;contact | list(object) | Optional | [] |  |
|&nbsp;&nbsp;email | string | Required |  |  |
|&nbsp;&nbsp;name | string | Optional |  |  |
|&nbsp;&nbsp;phone | string | Optional |  |  |
|&nbsp;tags | map(any) | Optional |  |  |
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
|&nbsp;&nbsp;private_dns_zone_group | list(object) | Optional | [] |  |
|&nbsp;&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;private_dns_zone_ids | list(string) | Required |  |  |
|&nbsp;&nbsp;ip_configuration | list(object) | Optional | [] |  |
|&nbsp;&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;private_ip_address | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;subresource_name | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;member_name | string | Optional |  |  |
|&nbsp;&nbsp;tags | map(any) | Optional |  |  |
|&nbsp;monitoring | list(object) | Optional | [] |  Custom object for enabling diagnostic settings |
|&nbsp;&nbsp;diag_name | string | Optional |  |  Name of the diagnostic setting |
|&nbsp;&nbsp;log_analytics_workspace_id | string | Optional |  |  |
|&nbsp;&nbsp;eventhub_name | string | Optional |  |  |
|&nbsp;&nbsp;eventhub_authorization_rule_id | string | Optional |  |  |


