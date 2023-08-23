# Variables

```
variable "config" {  type = list(object({
    # purview account
    name                = string
    resource_group_name = string
    location            = string
    identity = object({
      type         = string
      identity_ids = optional(list(string))
    })
    public_network_enabled      = optional(bool)
    managed_resource_group_name = optional(string)
    tags                        = optional(map(any))
  }))
}


```


## Table with config variables

| Name | Data Type | Requirement | Default Value | Comment |
| ------- | --------- | ----------- | ------------- | ------- |
|name | string | Required |  |  |
|resource_group_name | string | Required |  |  |
|location | string | Required |  |  |
|identity | object | Required |  |  |
|&nbsp;type | string | Required |  |  |
|&nbsp;identity_ids | list(string) | Optional |  |  |
|public_network_enabled | bool | Optional |  |  |
|managed_resource_group_name | string | Optional |  |  |
|tags | map(any) | Optional |  |  |


