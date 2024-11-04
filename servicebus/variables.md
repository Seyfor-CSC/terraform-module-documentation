# Variables

```
variable "config" {  type = list(object({
    name                = string
    resource_group_name = string
    location            = string
    sku                 = string
    identity = optional(object({
      type         = string
      identity_ids = optional(list(string))
    }))
    capacity                     = optional(number)
    premium_messaging_partitions = optional(number)
    customer_managed_key = optional(object({
      key_vault_key_id                  = string
      identity_id                       = string
      infrastructure_encryption_enabled = optional(bool)
    }))
    local_auth_enabled            = optional(bool)
    public_network_access_enabled = optional(bool, false)
    minimum_tls_version           = optional(string)
    network_rule_set = optional(object({
      default_action                = optional(string)
      public_network_access_enabled = optional(bool, false)
      trusted_services_allowed      = optional(bool)
      ip_rules                      = optional(list(string))
      network_rules = optional(list(object({
        subnet_id                            = string
        ignore_missing_vnet_service_endpoint = optional(bool)
      })), [])
      }), {
      trusted_services_allowed = true
    })
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
        diagnostic_error_logs      = optional(bool, true)
        operational_logs           = optional(bool, true)
        vnet_and_ip_filtering_logs = optional(bool, true)
        runtime_audit_logs         = optional(bool, true)
        application_metrics_logs   = optional(bool, false)
        all_metrics                = optional(bool, true)
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
|capacity | number | Optional |  |  |
|premium_messaging_partitions | number | Optional |  |  |
|customer_managed_key | object | Optional |  |  |
|&nbsp;key_vault_key_id | string | Required |  |  |
|&nbsp;identity_id | string | Required |  |  |
|&nbsp;infrastructure_encryption_enabled | bool | Optional |  |  |
|local_auth_enabled | bool | Optional |  |  |
|public_network_access_enabled | bool | Optional |  false |  |
|minimum_tls_version | string | Optional |  |  |
|network_rule_set | object | Optional |  |  |
|&nbsp;default_action | string | Optional |  |  |
|&nbsp;public_network_access_enabled | bool | Optional |  false |  |
|&nbsp;trusted_services_allowed | bool | Optional |  |  |
|&nbsp;ip_rules | list(string) | Optional |  |  |
|&nbsp;network_rules | list(object) | Optional | [] |  |
|&nbsp;&nbsp;subnet_id | string | Required |  |  |
|&nbsp;&nbsp;ignore_missing_vnet_service_endpoint | bool | Optional |  |  |
|trusted_services_allowed | true | Required |  |  |


