# Variables

```
variable "config" {  type = list(object({
    # bastion host
    name                = string
    resource_group_name = string
    location            = string
    ip_configuration = optional(object({
      name                 = string
      subnet_id            = string
      public_ip_address_id = string
    }))
    copy_paste_enabled     = optional(bool)
    file_copy_enabled      = optional(bool)
    sku                    = optional(string)
    ip_connect_enabled     = optional(bool)
    kerberos_enabled       = optional(bool)
    scale_units            = optional(number)
    shareable_link_enabled = optional(bool)
    tunneling_enabled      = optional(bool)
    virtual_network_id     = optional(string)
    tags                   = optional(map(any))

    # monitoring
    monitoring = optional(list(object({                 # Custom object for enabling diagnostic settings
      diag_name                      = optional(string) # Name of the diagnostic setting
      log_analytics_workspace_id     = optional(string)
      eventhub_name                  = optional(string)
      eventhub_authorization_rule_id = optional(string)
      categories = optional(object({
        bastion_audit_logs = optional(bool, true)
        all_metrics        = optional(bool, true)
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
|ip_configuration | object | Optional |  |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;subnet_id | string | Required |  |  |
|&nbsp;public_ip_address_id | string | Required |  |  |
|copy_paste_enabled | bool | Optional |  |  |
|file_copy_enabled | bool | Optional |  |  |
|sku | string | Optional |  |  |
|ip_connect_enabled | bool | Optional |  |  |
|kerberos_enabled | bool | Optional |  |  |
|scale_units | number | Optional |  |  |
|shareable_link_enabled | bool | Optional |  |  |
|tunneling_enabled | bool | Optional |  |  |
|virtual_network_id | string | Optional |  |  |
|tags | map(any) | Optional |  |  |
|monitoring | list(object) | Optional | [] |  Custom object for enabling diagnostic settings |
|&nbsp;diag_name | string | Optional |  |  Name of the diagnostic setting |
|&nbsp;log_analytics_workspace_id | string | Optional |  |  |
|&nbsp;eventhub_name | string | Optional |  |  |
|&nbsp;eventhub_authorization_rule_id | string | Optional |  |  |
|&nbsp;categories | object | Optional |  |  |
|&nbsp;&nbsp;bastion_audit_logs | bool | Optional |  true |  |
|&nbsp;&nbsp;all_metrics | bool | Optional |  true |  |


