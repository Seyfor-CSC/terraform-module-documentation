# Variables

```
variable "config" {  type = list(object({
    capacity_reservation_group_id = string
    location                      = string
    # Accept VM configuration in the same format as mit.virtual-machine module
    # This allows using the same local variable for both modules
    vm_config = list(object({
      name                     = string
      size                     = string
      zone                     = optional(string)
      use_capacity_reservation = optional(bool, false)
    }))
    tags = optional(map(string), {})
  }))
}


```


## Table with config variables

| Name | Data Type | Requirement | Default Value | Comment |
| ------- | --------- | ----------- | ------------- | ------- |
|capacity_reservation_group_id | string | Required |  |  |
|location | string | Required |  |  |
|vm_config | list(object) | Required |  |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;size | string | Required |  |  |
|&nbsp;zone | string | Optional |  |  |
|&nbsp;use_capacity_reservation | bool | Optional |  false |  |


