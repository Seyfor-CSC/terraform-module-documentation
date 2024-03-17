# Variables

```
variable "config" {  type = list(object({
    # public ip
    name                    = string
    resource_group_name     = string
    location                = string
    allocation_method       = string
    zones                   = optional(set(string))
    ddos_protection_mode    = optional(string)
    ddos_protection_plan_id = optional(string)
    domain_name_label       = optional(string)
    edge_zone               = optional(string)
    idle_timeout_in_minutes = optional(number)
    ip_tags                 = optional(map(any))
    ip_version              = optional(string)
    public_ip_prefix_id     = optional(string)
    reverse_fqdn            = optional(string)
    sku                     = optional(string, "Standard")
    sku_tier                = optional(string)
    tags                    = optional(map(any))

    # monitoring
    monitoring = optional(list(object({                 # Custom object for enabling diagnostic settings
      diag_name                      = optional(string) # Name of the diagnostic setting
      log_analytics_workspace_id     = optional(string)
      eventhub_name                  = optional(string)
      eventhub_authorization_rule_id = optional(string)
      categories = optional(object({
        ddos_protection_notifications = optional(bool, true)
        ddos_mitigation_flow_logs     = optional(bool, true)
        ddos_mitigation_reports       = optional(bool, true)
        all_metrics                   = optional(bool, true)
      }))
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
|allocation_method | string | Required |  |  |
|zones | set(string) | Optional |  |  |
|ddos_protection_mode | string | Optional |  |  |
|ddos_protection_plan_id | string | Optional |  |  |
|domain_name_label | string | Optional |  |  |
|edge_zone | string | Optional |  |  |
|idle_timeout_in_minutes | number | Optional |  |  |
|ip_tags | map(any) | Optional |  |  |
|ip_version | string | Optional |  |  |
|public_ip_prefix_id | string | Optional |  |  |
|reverse_fqdn | string | Optional |  |  |
|sku | string | Optional |  "Standard" |  |
|sku_tier | string | Optional |  |  |
|tags | map(any) | Optional |  |  |
|monitoring | list(object) | Optional | [] |  Custom object for enabling diagnostic settings |
|&nbsp;diag_name | string | Optional |  |  Name of the diagnostic setting |
|&nbsp;log_analytics_workspace_id | string | Optional |  |  |
|&nbsp;eventhub_name | string | Optional |  |  |
|&nbsp;eventhub_authorization_rule_id | string | Optional |  |  |
|&nbsp;categories | object | Optional |  |  |
|&nbsp;&nbsp;ddos_protection_notifications | bool | Optional |  true |  |
|&nbsp;&nbsp;ddos_mitigation_flow_logs | bool | Optional |  true |  |
|&nbsp;&nbsp;ddos_mitigation_reports | bool | Optional |  true |  |
|&nbsp;&nbsp;all_metrics | bool | Optional |  true |  |


