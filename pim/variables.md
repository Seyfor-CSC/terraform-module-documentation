# Variables

```
variable "config" {  type = list(object({
    type               = string # Custom variable. Possible values are "Active" or "Eligible"
    custom_name        = optional(string)
    principal_id       = string
    role_definition_id = string
    scope              = string
    justification      = optional(string)
    schedule = optional(object({
      start_date_time = string
      expiration = optional(object({
        duration_days  = optional(number)
        duration_hours = optional(number)
        end_date_time  = optional(string)
      }))
    }))
    ticket = optional(object({
      number = optional(string)
      system = optional(string)
    }))
    condition         = optional(string) # eligible assignment only
    condition_version = optional(string) # eligible assignment only
  }))
}


```


## Table with config variables

| Name | Data Type | Requirement | Default Value | Comment |
| ------- | --------- | ----------- | ------------- | ------- |
|type | string | Required |  |  Custom variable. Possible values are "Active" or "Eligible" |
|custom_name | string | Optional |  |  |
|principal_id | string | Required |  |  |
|role_definition_id | string | Required |  |  |
|scope | string | Required |  |  |
|justification | string | Optional |  |  |
|schedule | object | Optional |  |  |
|&nbsp;start_date_time | string | Required |  |  |
|&nbsp;expiration | object | Optional |  |  |
|&nbsp;&nbsp;duration_days | number | Optional |  |  |
|&nbsp;&nbsp;duration_hours | number | Optional |  |  |
|&nbsp;&nbsp;end_date_time | string | Optional |  |  |
|ticket | object | Optional |  |  |
|&nbsp;number | string | Optional |  |  |
|&nbsp;system | string | Optional |  |  |
|condition | string | Optional |  |  eligible assignment only |
|condition_version | string | Optional |  |  eligible assignment only |


