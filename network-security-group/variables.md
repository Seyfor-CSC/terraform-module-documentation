# Variables

```
variable "config" {  type = list(object({
    # network security group
    name                = string
    resource_group_name = string
    location            = string
    tags                = optional(map(any))

    # network security rule
    nsg_rule = optional(list(object({
      name                                       = string
      protocol                                   = string
      access                                     = string
      priority                                   = number
      direction                                  = string
      resource_group_name                        = optional(string) # If not provided, inherited in module from parent resource
      description                                = optional(string)
      source_port_range                          = optional(string)
      source_port_ranges                         = optional(list(string))
      destination_port_range                     = optional(string)
      destination_port_ranges                    = optional(list(string))
      source_address_prefix                      = optional(string)
      source_address_prefixes                    = optional(list(string))
      source_application_security_group_ids      = optional(list(string))
      destination_address_prefix                 = optional(string)
      destination_address_prefixes               = optional(list(string))
      destination_application_security_group_ids = optional(list(string))
    })), [])

    # network watcher flow log
    nsg_flow_log = optional(list(object({
      name                      = string
      network_watcher_name      = string
      resource_group_name       = string
      network_security_group_id = optional(string) # Inherited in module from parent resource
      storage_account_id        = string
      enabled                   = bool
      retention_policy = object({
        enabled = bool
        days    = number
      })
      location = optional(string)
      traffic_analytics = optional(object({
        enabled               = bool
        workspace_id          = string
        workspace_region      = string
        workspace_resource_id = string
        interval_in_minutes   = optional(number)
      }))
      version = optional(number)
      tags    = optional(map(any))
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
|tags | map(any) | Optional |  |  |
|nsg_rule | list(object) | Optional | [] |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;protocol | string | Required |  |  |
|&nbsp;access | string | Required |  |  |
|&nbsp;priority | number | Required |  |  |
|&nbsp;direction | string | Required |  |  |
|&nbsp;resource_group_name | string | Optional |  |  If not provided, inherited in module from parent resource |
|&nbsp;description | string | Optional |  |  |
|&nbsp;source_port_range | string | Optional |  |  |
|&nbsp;source_port_ranges | list(string) | Optional |  |  |
|&nbsp;destination_port_range | string | Optional |  |  |
|&nbsp;destination_port_ranges | list(string) | Optional |  |  |
|&nbsp;source_address_prefix | string | Optional |  |  |
|&nbsp;source_address_prefixes | list(string) | Optional |  |  |
|&nbsp;source_application_security_group_ids | list(string) | Optional |  |  |
|&nbsp;destination_address_prefix | string | Optional |  |  |
|&nbsp;destination_address_prefixes | list(string) | Optional |  |  |
|&nbsp;destination_application_security_group_ids | list(string) | Optional |  |  |
|nsg_flow_log | list(object) | Optional | [] |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;network_watcher_name | string | Required |  |  |
|&nbsp;resource_group_name | string | Required |  |  |
|&nbsp;network_security_group_id | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;storage_account_id | string | Required |  |  |
|&nbsp;enabled | bool | Required |  |  |
|&nbsp;retention_policy | object | Required |  |  |
|&nbsp;&nbsp;enabled | bool | Required |  |  |
|&nbsp;&nbsp;days | number | Required |  |  |
|&nbsp;location | string | Optional |  |  |
|&nbsp;traffic_analytics | object | Optional |  |  |
|&nbsp;&nbsp;enabled | bool | Required |  |  |
|&nbsp;&nbsp;workspace_id | string | Required |  |  |
|&nbsp;&nbsp;workspace_region | string | Required |  |  |
|&nbsp;&nbsp;workspace_resource_id | string | Required |  |  |
|&nbsp;&nbsp;interval_in_minutes | number | Optional |  |  |
|&nbsp;version | number | Optional |  |  |
|&nbsp;tags | map(any) | Optional |  |  |
|monitoring | list(object) | Optional | [] |  Custom object for enabling diagnostic settings |
|&nbsp;diag_name | string | Optional |  |  Name of the diagnostic setting |
|&nbsp;log_analytics_workspace_id | string | Optional |  |  |
|&nbsp;eventhub_name | string | Optional |  |  |
|&nbsp;eventhub_authorization_rule_id | string | Optional |  |  |


