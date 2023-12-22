# Variables

```
variable "config" {  type = list(object({
    # policy set definition
    name         = string
    policy_type  = string
    display_name = string
    policy_definition_reference = list(object({
      policy_definition_id = string
      parameter_values     = optional(string)
      reference_id         = optional(string)
      policy_group_names   = optional(list(string))
    }))
    policy_definition_group = optional(list(object({
      name                            = string
      display_name                    = optional(string)
      category                        = optional(string)
      description                     = optional(string)
      additional_metadata_resource_id = optional(string)
    })), [])
    description         = optional(string)
    management_group_id = optional(string)
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
|display_name | string | Required |  |  |
|policy_definition_reference | list(object) | Required |  |  |
|&nbsp;policy_definition_id | string | Required |  |  |
|&nbsp;parameter_values | string | Optional |  |  |
|&nbsp;reference_id | string | Optional |  |  |
|&nbsp;policy_group_names | list(string) | Optional |  |  |
|policy_definition_group | list(object) | Optional | [] |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;display_name | string | Optional |  |  |
|&nbsp;category | string | Optional |  |  |
|&nbsp;description | string | Optional |  |  |
|&nbsp;additional_metadata_resource_id | string | Optional |  |  |
|description | string | Optional |  |  |
|management_group_id | string | Optional |  |  |
|metadata | string | Optional |  |  |
|parameters | string | Optional |  |  |


