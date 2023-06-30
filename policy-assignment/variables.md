# Variables

```
variable "config" {  type = list(object({
    # policy assignment
    management_group_id  = optional(string) # Needs to be specified for management group level policy assignment
    subscription_id      = optional(string) # Needs to be specified for subscription level policy assignment
    name                 = string
    policy_definition_id = string
    description          = optional(string)
    display_name         = optional(string)
    enforce              = optional(bool)
    identity = optional(object({
      type         = string
      identity_ids = optional(list(string), [])
    }))
    location = optional(string)
    metadata = optional(string)
    non_compliance_message = optional(list(object({
      content                        = string
      policy_definition_reference_id = optional(string)
    })), [])
    not_scopes = optional(list(string), [])
    parameters = optional(string)
  }))
}


```


## Table with config variables

| Name | Data Type | Requirement | Default Value | Comment |
| ------- | --------- | ----------- | ------------- | ------- |
|management_group_id | string | Optional |  |  Needs to be specified for management group level policy assignment |
|subscription_id | string | Optional |  |  Needs to be specified for subscription level policy assignment |
|name | string | Required |  |  |
|policy_definition_id | string | Required |  |  |
|description | string | Optional |  |  |
|display_name | string | Optional |  |  |
|enforce | bool | Optional |  |  |
|identity | object | Optional |  |  |
|&nbsp;type | string | Required |  |  |
|&nbsp;identity_ids | list(string) | Optional | [] |  |
|location | string | Optional |  |  |
|metadata | string | Optional |  |  |
|non_compliance_message | list(object) | Optional | [] |  |
|&nbsp;content | string | Required |  |  |
|&nbsp;policy_definition_reference_id | string | Optional |  |  |
|not_scopes | list(string) | Optional | [] |  |
|parameters | string | Optional |  |  |


