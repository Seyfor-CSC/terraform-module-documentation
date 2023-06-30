# Variables

```
variable "config" {  type = list(object({
    # route table
    name                          = string
    resource_group_name           = string
    location                      = string
    disable_bgp_route_propagation = optional(bool)
    tags                          = optional(map(any))

    # route
    routes = optional(list(object({
      name                   = string
      address_prefix         = string
      next_hop_type          = string
      next_hop_in_ip_address = optional(string)
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
|disable_bgp_route_propagation | bool | Optional |  |  |
|tags | map(any) | Optional |  |  |
|routes | list(object) | Optional | [] |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;address_prefix | string | Required |  |  |
|&nbsp;next_hop_type | string | Required |  |  |
|&nbsp;next_hop_in_ip_address | string | Optional |  |  |


