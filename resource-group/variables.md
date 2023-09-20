# Variables

```
variable "config" {  type = list(object({
    # resource group
    name       = string
    location   = string
    managed_by = optional(string)
    tags       = optional(map(any))
  }))
}


```


## Table with config variables

| Name | Data Type | Requirement | Default Value | Comment |
| ------- | --------- | ----------- | ------------- | ------- |
|name | string | Required |  |  |
|location | string | Required |  |  |
|managed_by | string | Optional |  |  |
|tags | map(any) | Optional |  |  |


