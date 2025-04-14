# Variables

```
variable "config" {  type = list(object({
    # mssql failover group
    name      = string
    server_id = string
    partner_server = object({
      id = string
    })
    databases                                 = optional(list(string))
    readonly_endpoint_failover_policy_enabled = optional(bool)
    read_write_endpoint_failover_policy = object({
      mode          = string
      grace_minutes = optional(number)
    })
    tags = optional(map(any))
  }))
}


```


## Table with config variables

| Name | Data Type | Requirement | Default Value | Comment |
| ------- | --------- | ----------- | ------------- | ------- |
|name | string | Required |  |  |
|server_id | string | Required |  |  |
|partner_server | object | Required |  |  |
|&nbsp;id | string | Required |  |  |
|databases | list(string) | Optional |  |  |
|readonly_endpoint_failover_policy_enabled | bool | Optional |  |  |
|read_write_endpoint_failover_policy | object | Required |  |  |
|&nbsp;mode | string | Required |  |  |
|&nbsp;grace_minutes | number | Optional |  |  |
|tags | map(any) | Optional |  |  |


