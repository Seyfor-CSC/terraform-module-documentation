# Variables

```
variable "config" {  type = list(object({
    # shared image gallery
    name                = string
    resource_group_name = string
    location            = string
    description         = optional(string)
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
|description | string | Optional |  |  |
|tags | map(any) | Optional |  |  |


