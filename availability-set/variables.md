# Variables

```
variable "config" {  type = list(object({
    # availability set
    name                         = string
    resource_group_name          = string
    location                     = string
    platform_update_domain_count = optional(number)
    platform_fault_domain_count  = optional(number)
    proximity_placement_group_id = optional(string)
    managed                      = optional(bool)
    tags                         = optional(map(any))
  }))
}


```


## Table with config variables

| Name | Data Type | Requirement | Default Value | Comment |
| ------- | --------- | ----------- | ------------- | ------- |
|name | string | Required |  |  |
|resource_group_name | string | Required |  |  |
|location | string | Required |  |  |
|platform_update_domain_count | number | Optional |  |  |
|platform_fault_domain_count | number | Optional |  |  |
|proximity_placement_group_id | string | Optional |  |  |
|managed | bool | Optional |  |  |
|tags | map(any) | Optional |  |  |


