# Variables

```
variable "config" {  type = object({
    # key vault secret
    secret = optional(list(object({
      name            = string
      value           = optional(string) # If not provided, generated in module in 'random_password' resource
      key_vault_id    = string
      length          = optional(number, 12) # Custom variable setting the legth of the generated secret value
      special         = optional(bool, true) # Custom variable enabling special characters !@#$%&*()-_=+[]{}<>:?
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
|&nbsp;key_vault_id | string | Required |  |  |
|&nbsp;length | number | Optional |  12 |  Custom variable setting the legth of the generated secret value |
|content_type | string | Optional |  |  |
|not_before_date | string | Optional |  |  |
|expiration_date | string | Optional |  |  |
|tags | map(any) | Optional |  |  |


