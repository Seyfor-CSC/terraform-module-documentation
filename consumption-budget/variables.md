# Variables

```
variable "config" {  type = list(object({
    # consumption budget
    name                = string
    management_group_id = optional(string) # Needs to be specified for management group level consumption budget
    resource_group_id   = optional(string) # Needs to be specified for resource group level consumption budget
    resource_group_name = optional(string) # Needs to be specified for resource group level consumption budget
    subscription_id     = optional(string) # Needs to be specified for subscription level consumption budget
    amount              = number
    time_period = object({
      start_date = string
      end_date   = optional(string)
    })
    notification = list(object({
      operator       = string
      threshold      = number
      contact_emails = optional(list(string)) # Required for Management Group scope
      contact_groups = optional(list(string)) # Resource Group or Subscription scope only
      contact_roles  = optional(list(string)) # Resource Group or Subscription scope only
      threshold_type = optional(string)
      enabled        = optional(bool)
    }))
    time_grain = optional(string)
    filter = optional(object({
      dimension = optional(list(object({
        name     = string
        operator = optional(string)
        values   = list(string)
      })), [])
      tag = optional(list(object({
        name     = string
        operator = optional(string)
        values   = list(string)
      })), [])
    }))
  }))
}


```


## Table with config variables

| Name | Data Type | Requirement | Default Value | Comment |
| ------- | --------- | ----------- | ------------- | ------- |
|name | string | Required |  |  |
|management_group_id | string | Optional |  |  Needs to be specified for management group level consumption budget |
|resource_group_id | string | Optional |  |  Needs to be specified for resource group level consumption budget |
|resource_group_name | string | Optional |  |  Needs to be specified for resource group level consumption budget |
|subscription_id | string | Optional |  |  Needs to be specified for subscription level consumption budget |
|amount | number | Required |  |  |
|time_period | object | Required |  |  |
|&nbsp;start_date | string | Required |  |  |
|&nbsp;end_date | string | Optional |  |  |
|notification | list(object) | Required |  |  |
|&nbsp;operator | string | Required |  |  |
|&nbsp;threshold | number | Required |  |  |
|&nbsp;contact_emails | list(string) | Optional |  |  Required for Management Group scope |
|&nbsp;contact_groups | list(string) | Optional |  |  Resource Group or Subscription scope only |
|&nbsp;contact_roles | list(string) | Optional |  |  Resource Group or Subscription scope only |
|&nbsp;threshold_type | string | Optional |  |  |
|&nbsp;enabled | bool | Optional |  |  |
|time_grain | string | Optional |  |  |
|filter | object | Optional |  |  |
|&nbsp;dimension | list(object) | Optional | [] |  |
|&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;operator | string | Optional |  |  |
|&nbsp;&nbsp;values | list(string) | Required |  |  |
|&nbsp;tag | list(object) | Optional | [] |  |
|&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;operator | string | Optional |  |  |
|&nbsp;&nbsp;values | list(string) | Required |  |  |


