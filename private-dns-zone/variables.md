# Variables

```
variable "config" {  type = list(object({
    # private dns zone
    name                = string
    resource_group_name = string
    soa_record = optional(object({
      email        = string
      expire_time  = optional(number)
      minimum_ttl  = optional(number)
      refresh_time = optional(number)
      retry_time   = optional(number)
      ttl          = optional(number)
      tags         = optional(map(any)) # If not provided, inherited in module from parent resource
    }))
    tags = optional(map(any))

    # private dns zone virtual network link
    virtual_network_links = optional(list(object({
      name                  = string
      resource_group_name   = optional(string) # If not provided, inherited in module from parent resource
      private_dns_zone_name = optional(string) # Inherited in module from parent resource
      virtual_network_id    = string
      registration_enabled  = optional(bool)
      tags                  = optional(map(any)) # If not provided, inherited in module from parent resource
    })), [])
  }))
}


```


## Table with config variables

| Name | Data Type | Requirement | Default Value | Comment |
| ------- | --------- | ----------- | ------------- | ------- |
|name | string | Required |  |  |
|resource_group_name | string | Required |  |  |
|soa_record | object | Optional |  |  |
|&nbsp;email | string | Required |  |  |
|&nbsp;expire_time | number | Optional |  |  |
|&nbsp;minimum_ttl | number | Optional |  |  |
|&nbsp;refresh_time | number | Optional |  |  |
|&nbsp;retry_time | number | Optional |  |  |
|&nbsp;ttl | number | Optional |  |  |
|&nbsp;tags | map(any) | Optional |  |  If not provided, inherited in module from parent resource |
|tags | map(any) | Optional |  |  |
|virtual_network_links | list(object) | Optional | [] |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;resource_group_name | string | Optional |  |  If not provided, inherited in module from parent resource |
|&nbsp;private_dns_zone_name | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;virtual_network_id | string | Required |  |  |
|&nbsp;registration_enabled | bool | Optional |  |  |
|&nbsp;tags | map(any) | Optional |  |  If not provided, inherited in module from parent resource |


