# Variables

```
variable "config" {  type = list(object({
    name                = string
    resource_group_name = string
    soa_record = optional(object({
      email         = string
      expire_time   = optional(number)
      minimum_ttl   = optional(number)
      refresh_time  = optional(number)
      retry_time    = optional(number)
      serial_number = optional(number)
      ttl           = optional(number)
      tags          = optional(map(any))
    }))
    tags = optional(map(any))
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
|&nbsp;serial_number | number | Optional |  |  |
|&nbsp;ttl | number | Optional |  |  |
|&nbsp;tags | map(any) | Optional |  |  |
|tags | map(any) | Optional |  |  |


