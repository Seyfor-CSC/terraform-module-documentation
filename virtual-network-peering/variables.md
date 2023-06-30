# Variables

```
variable "config" {  type = list(object({
    # virtual network peering
    name                         = string
    resource_group_name          = string
    virtual_network_name         = string
    remote_virtual_network_id    = string
    allow_virtual_network_access = optional(bool)
    allow_forwarded_traffic      = optional(bool)
    allow_gateway_transit        = optional(bool)
    use_remote_gateways          = optional(bool)
    hub_hub                      = optional(bool, false) # Custom variable setting allow_virtual_network_access, allow_forwarded_traffic, allow_gateway_transit variables to true
    hub_spoke                    = optional(bool, false) # Custom variable setting allow_virtual_network_access, allow_gateway_transit variables to true
    spoke_hub                    = optional(bool, false) # Custom variable setting allow_virtual_network_access, allow_forwarded_traffic, allow_gateway_transit variables to true
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
|use_remote_gateways | bool | Optional |  |  |
|hub_hub | bool | Optional |  false |  Custom variable setting allow_virtual_network_access, allow_forwarded_traffic, allow_gateway_transit variables to true |
|hub_spoke | bool | Optional |  false |  Custom variable setting allow_virtual_network_access, allow_gateway_transit variables to true |
|spoke_hub | bool | Optional |  false |  Custom variable setting allow_virtual_network_access, allow_forwarded_traffic, allow_gateway_transit variables to true |


