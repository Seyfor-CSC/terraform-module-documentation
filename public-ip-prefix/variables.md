# Variables

```
variable "config" {  type = list(object({
    # public ip prefix
    name                = string
    resource_group_name = string
    location            = string
    sku                 = optional(string)
    ip_version          = optional(string)
    prefix_length       = optional(number)
    zones               = optional(set(string))
    tags                = optional(map(any))
  }))
}


```


## Table with config variables

| Name | Data Type | Requirement | Default Value | Comment |
| ------- | --------- | ----------- | ------------- | ------- |
|name | string | Required |  |  |
|resource_group_name | string | Required |  |  |
|location | string | Required |  |  |
|sku | string | Optional |  |  |
|ip_version | string | Optional |  |  |
|prefix_length | number | Optional |  |  |
|zones | set(string) | Optional |  |  |
|tags | map(any) | Optional |  |  |


