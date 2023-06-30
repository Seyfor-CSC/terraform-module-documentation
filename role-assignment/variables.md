# Variables

```
variable "config" {  type = list(object({
    # role assignment
    custom_name                            = string # Custom variable used as a unique value for looping. Has to be a unique value for each role assignment
    scope                                  = string
    principal_id                           = string
    name                                   = optional(string)
    role_definition_id                     = optional(string)
    role_definition_name                   = optional(string)
    condition                              = optional(string)
    condition_version                      = optional(string)
    delegated_managed_identity_resource_id = optional(string)
    description                            = optional(string)
    skip_service_principal_aad_check       = optional(bool)
  }))
}


```


## Table with config variables

| Name | Data Type | Requirement | Default Value | Comment |
| ------- | --------- | ----------- | ------------- | ------- |
|custom_name | string | Required |  |  Custom variable used as a unique value for looping. Has to be a unique value for each role assignment |
|scope | string | Required |  |  |
|principal_id | string | Required |  |  |
|name | string | Optional |  |  |
|role_definition_id | string | Optional |  |  |
|role_definition_name | string | Optional |  |  |
|condition | string | Optional |  |  |
|condition_version | string | Optional |  |  |
|delegated_managed_identity_resource_id | string | Optional |  |  |
|description | string | Optional |  |  |
|skip_service_principal_aad_check | bool | Optional |  |  |


