# Variables

```
variable "config" {  type = list(object({
    # virtual network
    name                = string
    resource_group_name = string
    location            = string
    address_space       = list(string)
    bgp_community       = optional(string)
    ddos_protection_plan = optional(object({
      id     = string
      enable = bool
    }))
    encryption = optional(object({
      enforcement = string
    }))
    dns_servers             = optional(list(string), [])
    edge_zone               = optional(string)
    flow_timeout_in_minutes = optional(number)
    tags                    = optional(map(any))

    # subnet
    subnets = list(object({
      name                 = string
      resource_group_name  = optional(string) # If not provided, inherited in module from parent resource
      virtual_network_name = optional(string) # Inherited in module from parent resource
      address_prefixes     = list(string)
      delegation = optional(object({
        name = string
        service_delegation = object({
          name    = string
          actions = optional(list(string))
        })
      }))
      default_outbound_access_enabled               = optional(bool)
      private_endpoint_network_policies             = optional(string)
      private_link_service_network_policies_enabled = optional(bool)
      service_endpoints                             = optional(list(string))
      service_endpoint_policy_ids                   = optional(list(string))
      nsg_name                                      = optional(string)
      route_table_name                              = optional(string)
      nat_gateway_name                              = optional(string)
      nsg_rg                                        = optional(string)
      route_table_rg                                = optional(string)
      nat_gateway_rg                                = optional(string)
    }))

    # monitoring
    monitoring = optional(list(object({                 # Custom object for enabling diagnostic settings
      diag_name                      = optional(string) # Name of the diagnostic setting
      log_analytics_workspace_id     = optional(string)
      eventhub_name                  = optional(string)
      eventhub_authorization_rule_id = optional(string)
      storage_account_id             = optional(string)
      categories = optional(object({
        vm_protection_alerts = optional(bool, true)
        all_metrics          = optional(bool, true)
      }))
    })), [])
  }))

  default = null
}

variable "subnets" {
  type = list(object({
    # subnet
    name                 = string
    resource_group_name  = string
    virtual_network_name = string
    address_prefixes     = list(string)
    delegation = optional(object({
      name = string
      service_delegation = object({
        name    = string
        actions = optional(list(string))
      })
    }))
    default_outbound_access_enabled               = optional(bool)
    private_endpoint_network_policies             = optional(string)
    private_link_service_network_policies_enabled = optional(bool)
    service_endpoints                             = optional(list(string))
    service_endpoint_policy_ids                   = optional(list(string))
    nsg_name                                      = optional(string)
    route_table_name                              = optional(string)
    nat_gateway_name                              = optional(string)
    nsg_rg                                        = optional(string)
    route_table_rg                                = optional(string)
    nat_gateway_rg                                = optional(string)
  }))

  default = null
}

variable "subscription_id" {
  type = string
}


```


## Table with config variables

| Name | Data Type | Requirement | Default Value | Comment |
| ------- | --------- | ----------- | ------------- | ------- |
|name | string | Required |  |  |
|resource_group_name | string | Required |  |  |
|location | string | Required |  |  |
|address_space | list(string) | Required |  |  |
|bgp_community | string | Optional |  |  |
|ddos_protection_plan | object | Optional |  |  |
|&nbsp;id | string | Required |  |  |
|&nbsp;enable | bool | Required |  |  |
|encryption | object | Optional |  |  |
|&nbsp;enforcement | string | Required |  |  |
|dns_servers | list(string) | Optional | [] |  |
|edge_zone | string | Optional |  |  |
|flow_timeout_in_minutes | number | Optional |  |  |
|tags | map(any) | Optional |  |  |
|subnets | list(object) | Required |  |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;resource_group_name | string | Optional |  |  If not provided, inherited in module from parent resource |
|&nbsp;virtual_network_name | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;address_prefixes | list(string) | Required |  |  |
|&nbsp;delegation | object | Optional |  |  |
|&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;service_delegation | object | Required |  |  |
|&nbsp;&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;actions | list(string) | Optional |  |  |
|&nbsp;default_outbound_access_enabled | bool | Optional |  |  |
|&nbsp;private_endpoint_network_policies | string | Optional |  |  |
|&nbsp;private_link_service_network_policies_enabled | bool | Optional |  |  |
|&nbsp;service_endpoints | list(string) | Optional |  |  |
|&nbsp;service_endpoint_policy_ids | list(string) | Optional |  |  |
|&nbsp;nsg_name | string | Optional |  |  |
|&nbsp;route_table_name | string | Optional |  |  |
|&nbsp;nat_gateway_name | string | Optional |  |  |
|&nbsp;nsg_rg | string | Optional |  |  |
|&nbsp;route_table_rg | string | Optional |  |  |
|&nbsp;nat_gateway_rg | string | Optional |  |  |
|monitoring | list(object) | Optional | [] |  Custom object for enabling diagnostic settings |
|&nbsp;diag_name | string | Optional |  |  Name of the diagnostic setting |
|&nbsp;log_analytics_workspace_id | string | Optional |  |  |
|&nbsp;eventhub_name | string | Optional |  |  |
|&nbsp;eventhub_authorization_rule_id | string | Optional |  |  |
|&nbsp;storage_account_id | string | Optional |  |  |
|&nbsp;categories | object | Optional |  |  |
|&nbsp;&nbsp;vm_protection_alerts | bool | Optional |  true |  |
|&nbsp;&nbsp;all_metrics | bool | Optional |  true |  |


