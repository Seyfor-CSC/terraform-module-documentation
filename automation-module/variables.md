# Variables

```
variable "config" {  type = list(object({
    # automation module
    name                    = string
    resource_group_name     = string
    automation_account_name = string
    module_link = object({
      uri = string
      hash = optional(object({
        algorithm = string
        value     = string
      }))
    })
  }))
}


```


## Table with config variables

| Name | Data Type | Requirement | Default Value | Comment |
| ------- | --------- | ----------- | ------------- | ------- |
|name | string | Required |  |  |
|resource_group_name | string | Required |  |  |
|automation_account_name | string | Required |  |  |
|module_link | object | Required |  |  |
|&nbsp;uri | string | Required |  |  |
|&nbsp;hash | object | Optional |  |  |
|&nbsp;&nbsp;algorithm | string | Required |  |  |
|&nbsp;&nbsp;value | string | Required |  |  |


