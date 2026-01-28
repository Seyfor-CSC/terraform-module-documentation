# Variables

```
variable "config" {  type = list(object({
    # capacity reservation group
    name                = string
    resource_group_name = string
    location            = string
    zones               = optional(list(string))
    tags                = optional(map(string))
  }))
}


```


## Table with config variables

| Name | Data Type | Requirement | Default Value | Comment |
| ------- | --------- | ----------- | ------------- | ------- |
|name | string | Required |  |  |
|resource_group_name | string | Required |  |  |
|location | string | Required |  |  |
|zones | list(string) | Optional |  |  |
|tags | map(string) | Optional |  |  |


