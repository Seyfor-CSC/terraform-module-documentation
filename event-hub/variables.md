# Variables

```
variable "config" {  type = list(object({
    # eventhub namespace
    name                 = string
    resource_group_name  = string
    location             = string
    sku                  = string
    capacity             = optional(number)
    auto_inflate_enabled = optional(bool)
    dedicated_cluster_id = optional(string)
    identity = optional(object({
      type         = string
      identity_ids = optional(list(string))
    }))
    maximum_throughput_units = optional(number)
    network_rulesets = optional(object({
      default_action                 = string
      public_network_access_enabled  = optional(bool, false)
      trusted_service_access_enabled = optional(bool)
      virtual_network_rule = optional(list(object({
        subnet_id                                       = string
        ignore_missing_virtual_network_service_endpoint = optional(bool)
      })), [])
      ip_rule = optional(list(object({
        ip_mask = string
        action  = optional(string)
      })), [])
    }))
    local_authentication_enabled  = optional(bool)
    public_network_access_enabled = optional(bool, false)
    minimum_tls_version           = optional(string)
    tags                          = optional(map(any))

    # eventhub
    eventhub = optional(list(object({
      name              = string
      namespace_id      = optional(string) # Inherited in module from parent resource
      partition_count   = number
      message_retention = number
      capture_description = optional(object({
        enabled  = bool
        encoding = string
        destination = object({
          name                = string
          archive_name_format = string
          blob_container_name = string
          storage_account_id  = string
        })
        interval_in_seconds = optional(number)
        size_limit_in_bytes = optional(number)
        skip_empty_archives = optional(bool)
      }))
      status = optional(string)

      # eventhub consumer group
      eventhub_consumer_group = optional(list(object({
        name                = string
        namespace_name      = optional(string) # Inherited in module from parent resource
        eventhub_name       = optional(string) # Inherited in module from parent resource
        resource_group_name = optional(string) # If not provided, inherited in module from parent resource
        user_metadata       = optional(string)
      })), [])

      # eventhub authorization rule
      eventhub_authorization_rule = optional(list(object({
        name                = string
        namespace_name      = optional(string) # Inherited in module from parent resource
        eventhub_name       = optional(string) # Inherited in module from parent resource
        resource_group_name = optional(string) # If not provided, inherited in module from parent resource
        listen              = optional(bool)
        send                = optional(bool)
        manage              = optional(bool) # If set to true, listen and send are automatically set to true
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
        application_metrics_logs        = optional(bool, true)
        customer_managed_key_user_logs  = optional(bool, true)
        kafka_coordinator_logs          = optional(bool, true)
        auto_scale_logs                 = optional(bool, true)
        kafka_user_error_logs           = optional(bool, true)
        archive_logs                    = optional(bool, true)
        operational_logs                = optional(bool, true)
        event_hub_vnet_connection_event = optional(bool, false)
        runtime_audit_logs              = optional(bool, false)
        diagnostic_error_logs           = optional(bool, true)
        data_dr_logs                    = optional(bool, true)
        all_metrics                     = optional(bool, true)
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
|capacity | number | Optional |  |  |
|auto_inflate_enabled | bool | Optional |  |  |
|dedicated_cluster_id | string | Optional |  |  |
|identity | object | Optional |  |  |
|&nbsp;type | string | Required |  |  |
|&nbsp;identity_ids | list(string) | Optional |  |  |
|maximum_throughput_units | number | Optional |  |  |
|network_rulesets | object | Optional |  |  |
|&nbsp;default_action | string | Required |  |  |
|&nbsp;public_network_access_enabled | bool | Optional |  false |  |
|&nbsp;trusted_service_access_enabled | bool | Optional |  |  |
|&nbsp;virtual_network_rule | list(object) | Optional | [] |  |
|&nbsp;&nbsp;subnet_id | string | Required |  |  |
|&nbsp;&nbsp;ignore_missing_virtual_network_service_endpoint | bool | Optional |  |  |
|&nbsp;ip_rule | list(object) | Optional | [] |  |
|&nbsp;&nbsp;ip_mask | string | Required |  |  |
|&nbsp;&nbsp;action | string | Optional |  |  |
|local_authentication_enabled | bool | Optional |  |  |
|public_network_access_enabled | bool | Optional |  false |  |
|minimum_tls_version | string | Optional |  |  |
|tags | map(any) | Optional |  |  |
|eventhub | list(object) | Optional | [] |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;namespace_id | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;partition_count | number | Required |  |  |
|&nbsp;message_retention | number | Required |  |  |
|&nbsp;capture_description | object | Optional |  |  |
|&nbsp;&nbsp;enabled | bool | Required |  |  |
|&nbsp;&nbsp;encoding | string | Required |  |  |
|&nbsp;&nbsp;destination | object | Required |  |  |
|&nbsp;&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;archive_name_format | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;blob_container_name | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;storage_account_id | string | Required |  |  |
|&nbsp;&nbsp;interval_in_seconds | number | Optional |  |  |
|&nbsp;&nbsp;size_limit_in_bytes | number | Optional |  |  |
|&nbsp;&nbsp;skip_empty_archives | bool | Optional |  |  |
|&nbsp;status | string | Optional |  |  |
|&nbsp;eventhub_consumer_group | list(object) | Optional | [] |  |
|&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;namespace_name | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;&nbsp;eventhub_name | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;&nbsp;resource_group_name | string | Optional |  |  If not provided, inherited in module from parent resource |
|&nbsp;&nbsp;user_metadata | string | Optional |  |  |
|&nbsp;eventhub_authorization_rule | list(object) | Optional | [] |  |
|&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;namespace_name | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;&nbsp;eventhub_name | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;&nbsp;resource_group_name | string | Optional |  |  If not provided, inherited in module from parent resource |
|&nbsp;&nbsp;listen | bool | Optional |  |  |
|&nbsp;&nbsp;send | bool | Optional |  |  |
|&nbsp;&nbsp;manage | bool | Optional |  |  If set to true, listen and send are automatically set to true |
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
|&nbsp;&nbsp;application_metrics_logs | bool | Optional |  true |  |
|&nbsp;&nbsp;customer_managed_key_user_logs | bool | Optional |  true |  |
|&nbsp;&nbsp;kafka_coordinator_logs | bool | Optional |  true |  |
|&nbsp;&nbsp;auto_scale_logs | bool | Optional |  true |  |
|&nbsp;&nbsp;kafka_user_error_logs | bool | Optional |  true |  |
|&nbsp;&nbsp;archive_logs | bool | Optional |  true |  |
|&nbsp;&nbsp;operational_logs | bool | Optional |  true |  |
|&nbsp;&nbsp;event_hub_vnet_connection_event | bool | Optional |  false |  |
|&nbsp;&nbsp;runtime_audit_logs | bool | Optional |  false |  |
|&nbsp;&nbsp;diagnostic_error_logs | bool | Optional |  true |  |
|&nbsp;&nbsp;data_dr_logs | bool | Optional |  true |  |
|&nbsp;&nbsp;all_metrics | bool | Optional |  true |  |


