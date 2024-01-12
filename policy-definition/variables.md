# Variables

```
variable "config" {  type = list(object({
    # policy definition
    name                = string
    policy_type         = string
    mode                = string
    display_name        = string
    description         = optional(string)
    management_group_id = optional(string)
    policy_rule         = optional(string)
    metadata            = optional(string)
    parameters          = optional(string)
  }))
}


```


## Table with config variables

| Name | Data Type | Requirement | Default Value | Comment |
| ------- | --------- | ----------- | ------------- | ------- |
|name | string | Required |  |  |
|policy_type | string | Required |  |  |
|mode | string | Required |  |  |
|display_name | string | Required |  |  |
|description | string | Optional |  |  |
|management_group_id | string | Optional |  |  |
|policy_rule | string | Optional |  |  |
|metadata | string | Optional |  |  |
|parameters | string | Optional |  |  |


