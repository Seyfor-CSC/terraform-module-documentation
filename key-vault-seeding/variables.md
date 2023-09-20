# Variables

```
variable "config" {  type = object({
    secret = optional(list(object({
      name            = string
      value           = optional(string) # If not provided, generated in module in 'random_password' resource
      key_vault_id    = optional(string)
      length          = optional(number, 12) # Custom variable setting the legth of the secret value
      content_type    = optional(string)
      not_before_date = optional(string)
      expiration_date = optional(string)
      tags            = optional(map(any))
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
|&nbsp;key_vault_id | string | Optional |  |  |
|&nbsp;length | number | Optional |  12 |  Custom variable setting the legth of the secret value |
|&nbsp;content_type | string | Optional |  |  |
|&nbsp;not_before_date | string | Optional |  |  |
|&nbsp;expiration_date | string | Optional |  |  |
|&nbsp;tags | map(any) | Optional |  |  |

