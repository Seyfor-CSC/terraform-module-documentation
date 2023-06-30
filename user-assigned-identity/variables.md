# Variables

```
variable "config" {  type = list(object({
    # user assigned identity
    name                = string
    resource_group_name = string
    location            = string
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
|tags | map(any) | Optional |  |  |


