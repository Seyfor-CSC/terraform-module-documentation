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
      resource_group_name                        = optional(string) # If not provided, inherited in module from parent resource
      network_security_group_name                = optional(string) # Inherited in module from parent resource
      protocol                                   = string
      access                                     = string
      priority                                   = number
      direction                                  = string
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

    # monitoring
    monitoring = optional(list(object({                 # Custom object for enabling diagnostic settings
      diag_name                      = optional(string) # Name of the diagnostic setting
      log_analytics_workspace_id     = optional(string)
      eventhub_name                  = optional(string)
      eventhub_authorization_rule_id = optional(string)
      storage_account_id             = optional(string)
      categories = optional(object({
        network_security_group_event        = optional(bool, true)
        network_security_group_rule_counter = optional(bool, true)
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
|tags | map(any) | Optional |  |  |
|nsg_rule | list(object) | Optional | [] |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;resource_group_name | string | Optional |  |  If not provided, inherited in module from parent resource |
|&nbsp;network_security_group_name | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;protocol | string | Required |  |  |
|&nbsp;access | string | Required |  |  |
|&nbsp;priority | number | Required |  |  |
|&nbsp;direction | string | Required |  |  |
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
|monitoring | list(object) | Optional | [] |  Custom object for enabling diagnostic settings |
|&nbsp;diag_name | string | Optional |  |  Name of the diagnostic setting |
|&nbsp;log_analytics_workspace_id | string | Optional |  |  |
|&nbsp;eventhub_name | string | Optional |  |  |
|&nbsp;eventhub_authorization_rule_id | string | Optional |  |  |
|&nbsp;storage_account_id | string | Optional |  |  |
|&nbsp;categories | object | Optional |  |  |
|&nbsp;&nbsp;network_security_group_event | bool | Optional |  true |  |
|&nbsp;&nbsp;network_security_group_rule_counter | bool | Optional |  true |  |


