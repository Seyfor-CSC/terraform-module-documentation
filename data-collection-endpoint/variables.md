# Variables

```
variable "config" {  type = list(object({
    # monitor data collection endpoint
    name                          = string
    resource_group_name           = string
    location                      = string
    description                   = optional(string)
    kind                          = optional(string)
    public_network_access_enabled = optional(bool, false)
    tags                          = optional(map(any))
  }))
}


```


## Table with config variables

| Name | Data Type | Requirement | Default Value | Comment |
| ------- | --------- | ----------- | ------------- | ------- |
|name | string | Required |  |  |
|resource_group_name | string | Required |  |  |
|location | string | Required |  |  |
|description | string | Optional |  |  |
|kind | string | Optional |  |  |
|public_network_access_enabled | bool | Optional |  false |  |
|tags | map(any) | Optional |  |  |


