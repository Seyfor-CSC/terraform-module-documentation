# Variables

```
variable "config" {  type = list(object({
    # resource group
    name     = string
    location = string
    tags     = optional(map(any))
  }))
}


```


## Table with config variables

| Name | Data Type | Requirement | Default Value | Comment |
| ------- | --------- | ----------- | ------------- | ------- |
|name | string | Required |  |  |
|location | string | Required |  |  |
|tags | map(any) | Optional |  |  |


