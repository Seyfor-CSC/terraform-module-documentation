# Variables

```
variable "config" {  type = list(object({
    # role definition
    name               = string
    scope              = string
    role_definition_id = optional(string)
    description        = optional(string)
    permissions = optional(object({
      actions          = optional(list(string))
      data_actions     = optional(list(string))
      not_actions      = optional(list(string))
      not_data_actions = optional(list(string))
    }))
    assignable_scopes = optional(list(string))
  }))
}


```


## Table with config variables

| Name | Data Type | Requirement | Default Value | Comment |
| ------- | --------- | ----------- | ------------- | ------- |
|name | string | Required |  |  |
|scope | string | Required |  |  |
|role_definition_id | string | Optional |  |  |
|description | string | Optional |  |  |
|permissions | object | Optional |  |  |
|&nbsp;actions | list(string) | Optional |  |  |
|&nbsp;data_actions | list(string) | Optional |  |  |
|&nbsp;not_actions | list(string) | Optional |  |  |
|&nbsp;not_data_actions | list(string) | Optional |  |  |
|assignable_scopes | list(string) | Optional |  |  |


