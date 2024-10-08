# Variables

```
variable "config" {  type = list(object({
    # virtual network peering
    name                                   = string
    resource_group_name                    = string
    virtual_network_name                   = string
    remote_virtual_network_id              = string
    allow_virtual_network_access           = optional(bool)
    allow_forwarded_traffic                = optional(bool)
    allow_gateway_transit                  = optional(bool)
    local_subnet_names                     = optional(list(string))
    only_ipv6_peering_enabled              = optional(bool)
    peer_complete_virtual_networks_enabled = optional(bool)
    remote_subnet_names                    = optional(list(string))
    use_remote_gateways                    = optional(bool)
    triggers                               = optional(map(any))
    hub_hub                                = optional(bool, false) # Custom variable setting allow_virtual_network_access, allow_forwarded_traffic, allow_gateway_transit variables to true
    hub_spoke                              = optional(bool, false) # Custom variable setting allow_virtual_network_access, allow_gateway_transit variables to true
    spoke_hub                              = optional(bool, false) # Custom variable setting allow_virtual_network_access, allow_forwarded_traffic, allow_gateway_transit variables to true
  }))
}


```


## Table with config variables

| Name | Data Type | Requirement | Default Value | Comment |
| ------- | --------- | ----------- | ------------- | ------- |
|name | string | Required |  |  |
|resource_group_name | string | Required |  |  |
|virtual_network_name | string | Required |  |  |
|remote_virtual_network_id | string | Required |  |  |
|allow_virtual_network_access | bool | Optional |  |  |
|allow_forwarded_traffic | bool | Optional |  |  |
|allow_gateway_transit | bool | Optional |  |  |
|local_subnet_names | list(string) | Optional |  |  |
|only_ipv6_peering_enabled | bool | Optional |  |  |
|peer_complete_virtual_networks_enabled | bool | Optional |  |  |
|remote_subnet_names | list(string) | Optional |  |  |
|use_remote_gateways | bool | Optional |  |  |
|triggers | map(any) | Optional |  |  |
|hub_hub | bool | Optional |  false |  Custom variable setting allow_virtual_network_access, allow_forwarded_traffic, allow_gateway_transit variables to true |
|hub_spoke | bool | Optional |  false |  Custom variable setting allow_virtual_network_access, allow_gateway_transit variables to true |
|spoke_hub | bool | Optional |  false |  Custom variable setting allow_virtual_network_access, allow_forwarded_traffic, allow_gateway_transit variables to true |


