# Variables

```
variable "config" {  type = object({
    # key vault secret
    secret = optional(list(object({
      name             = string
      value            = optional(string) # If not provided, generated in module in 'random_password' resource
      value_wo         = optional(string)
      value_wo_version = optional(string)
      key_vault_id     = string
      content_type     = optional(string)
      not_before_date  = optional(string)
      expiration_date  = optional(string)
      tags             = optional(map(any))

      # random password
      length           = optional(number, 12)
      lower            = optional(bool)
      min_lower        = optional(number)
      min_numeric      = optional(number)
      min_special      = optional(number)
      min_upper        = optional(number)
      numeric          = optional(bool)
      override_special = optional(string)
      special          = optional(bool)
      upper            = optional(bool)
    })), [])
  })
}


```


## Table with config variables

| Name | Data Type | Requirement | Default Value | Comment |
| ------- | --------- | ----------- | ------------- | ------- |
|secret | list(object) | Optional | [] |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;value | string | Optional |  |  If not provided, generated in module in 'random_password' resource |
|&nbsp;value_wo | string | Optional |  |  |
|&nbsp;value_wo_version | string | Optional |  |  |
|&nbsp;key_vault_id | string | Required |  |  |
|&nbsp;content_type | string | Optional |  |  |
|&nbsp;not_before_date | string | Optional |  |  |
|&nbsp;expiration_date | string | Optional |  |  |
|&nbsp;tags | map(any) | Optional |  |  |
|&nbsp;length | number | Optional |  12 |  |
|&nbsp;lower | bool | Optional |  |  |
|&nbsp;min_lower | number | Optional |  |  |
|&nbsp;min_numeric | number | Optional |  |  |
|&nbsp;min_special | number | Optional |  |  |
|&nbsp;min_upper | number | Optional |  |  |
|&nbsp;numeric | bool | Optional |  |  |
|&nbsp;override_special | string | Optional |  |  |
|&nbsp;special | bool | Optional |  |  |
|&nbsp;upper | bool | Optional |  |  |


