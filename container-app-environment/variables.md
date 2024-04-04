# Variables

```
variable "config" {  type = list(object({
    # container app environment
    name                                        = string
    resource_group_name                         = string
    location                                    = string
    dapr_application_insights_connection_string = optional(string)
    infrastructure_resource_group_name          = optional(string)
    infrastructure_subnet_id                    = optional(string)
    internal_load_balancer_enabled              = optional(bool)
    zone_redundancy_enabled                     = optional(bool)
    log_analytics_workspace_id                  = optional(string)
    workload_profile = optional(object({
      name                  = string
      workload_profile_type = string
      maximum_count         = number
      minimum_count         = number
    }))
    tags = optional(map(any))
  }))
}


```


## Table with config variables

| Name | Data Type | Requirement | Default Value | Comment |
| ------- | --------- | ----------- | ------------- | ------- |
|name | string | Required |  |  |
|resource_group_name | string | Required |  |  |
|location | string | Required |  |  |
|dapr_application_insights_connection_string | string | Optional |  |  |
|infrastructure_resource_group_name | string | Optional |  |  |
|infrastructure_subnet_id | string | Optional |  |  |
|internal_load_balancer_enabled | bool | Optional |  |  |
|zone_redundancy_enabled | bool | Optional |  |  |
|log_analytics_workspace_id | string | Optional |  |  |
|workload_profile | object | Optional |  |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;workload_profile_type | string | Required |  |  |
|&nbsp;maximum_count | number | Required |  |  |
|&nbsp;minimum_count | number | Required |  |  |
|tags | map(any) | Optional |  |  |


