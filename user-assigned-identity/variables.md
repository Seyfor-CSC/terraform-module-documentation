# Variables

```
variable "config" {  type = list(object({
    # user assigned identity
    name                = string
    resource_group_name = string
    location            = string
    isolation_scope     = optional(string)
    tags                = optional(map(any))

    # federated identity credential
    federated_identity_credential = optional(list(object({
      name                      = string
      user_assigned_identity_id = optional(string) # Inherited in module from parent resource
      audience                  = list(string)
      issuer                    = string
      subject                   = string
    })), [])
  }))
}


```


## Table with config variables

| Name | Data Type | Requirement | Default Value | Comment |
| ------- | --------- | ----------- | ------------- | ------- |
|name | string | Required |  |  |
|resource_group_name | string | Required |  |  |
|location | string | Required |  |  |
|isolation_scope | string | Optional |  |  |
|tags | map(any) | Optional |  |  |
|federated_identity_credential | list(object) | Optional | [] |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;user_assigned_identity_id | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;audience | list(string) | Required |  |  |
|&nbsp;issuer | string | Required |  |  |
|&nbsp;subject | string | Required |  |  |


