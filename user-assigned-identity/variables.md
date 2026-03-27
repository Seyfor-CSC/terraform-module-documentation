# Variables

```
variable "config" {  type = list(object({
    # user assigned identity
    name                = string
    resource_group_name = string
    location            = string
    isolation_scope     = optional(string)
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
|isolation_scope | string | Optional |  |  |
|tags | map(any) | Optional |  |  |


