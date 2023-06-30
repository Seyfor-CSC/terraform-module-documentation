# Variables

```
variable "config" {  type = list(object({
    # monitor action group
    name                = string
    resource_group_name = string
    short_name          = string
    enabled             = optional(bool)
    arm_role_receiver = optional(list(object({
      name                    = string
      role_id                 = string
      use_common_alert_schema = optional(bool)
    })), [])
    automation_runbook_receiver = optional(list(object({
      name                    = string
      automation_account_id   = string
      runbook_name            = string
      webhook_resource_id     = string
      is_global_runbook       = bool
      service_uri             = string
      use_common_alert_schema = optional(bool)
    })), [])
    azure_app_push_receiver = optional(list(object({
      name          = string
      email_address = string
    })), [])
    azure_function_receiver = optional(list(object({
      name                     = string
      function_app_resource_id = string
      function_name            = string
      http_trigger_url         = string
      use_common_alert_schema  = optional(bool)
    })), [])
    email_receiver = optional(list(object({
      name                    = string
      email_address           = string
      use_common_alert_schema = optional(bool)
    })), [])
    event_hub_receiver = optional(list(object({
      name                    = string
      event_hub_name          = string
      event_hub_namespace     = string
      subscription_id         = optional(string)
      tenant_id               = optional(string)
      use_common_alert_schema = optional(bool)
    })), [])
    itsm_receiver = optional(list(object({
      name                 = string
      workspace_id         = string
      connection_id        = string
      ticket_configuration = string
      region               = string
    })), [])
    location = optional(string)
    logic_app_receiver = optional(list(object({
      name                    = string
      resource_id             = string
      callback_url            = string
      use_common_alert_schema = optional(bool)
    })), [])
    sms_receiver = optional(list(object({
      name         = string
      country_code = string
      phone_number = string
    })), [])
    voice_receiver = optional(list(object({
      name         = string
      country_code = string
      phone_number = string
    })), [])
    webhook_receiver = optional(list(object({
      name                    = string
      service_uri             = string
      use_common_alert_schema = optional(bool)
      aad_auth = optional(object({
        object_id      = string
        identifier_uri = optional(string)
        tenant_id      = optional(string)
      }))
    })), [])
    tags = optional(map(any))
  }))
}



```


## Table with config variables

| Name | Data Type | Requirement | Default Value | Comment |
| ------- | --------- | ----------- | ------------- | ------- |
|name | string | Required |  |  |
|resource_group_name | string | Required |  |  |
|short_name | string | Required |  |  |
|enabled | bool | Optional |  |  |
|arm_role_receiver | list(object) | Optional | [] |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;role_id | string | Required |  |  |
|&nbsp;use_common_alert_schema | bool | Optional |  |  |
|automation_runbook_receiver | list(object) | Optional | [] |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;automation_account_id | string | Required |  |  |
|&nbsp;runbook_name | string | Required |  |  |
|&nbsp;webhook_resource_id | string | Required |  |  |
|&nbsp;is_global_runbook | bool | Required |  |  |
|&nbsp;service_uri | string | Required |  |  |
|&nbsp;use_common_alert_schema | bool | Optional |  |  |
|azure_app_push_receiver | list(object) | Optional | [] |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;email_address | string | Required |  |  |
|azure_function_receiver | list(object) | Optional | [] |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;function_app_resource_id | string | Required |  |  |
|&nbsp;function_name | string | Required |  |  |
|&nbsp;http_trigger_url | string | Required |  |  |
|&nbsp;use_common_alert_schema | bool | Optional |  |  |
|email_receiver | list(object) | Optional | [] |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;email_address | string | Required |  |  |
|&nbsp;use_common_alert_schema | bool | Optional |  |  |
|event_hub_receiver | list(object) | Optional | [] |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;event_hub_name | string | Required |  |  |
|&nbsp;event_hub_namespace | string | Required |  |  |
|&nbsp;subscription_id | string | Optional |  |  |
|&nbsp;tenant_id | string | Optional |  |  |
|&nbsp;use_common_alert_schema | bool | Optional |  |  |
|itsm_receiver | list(object) | Optional | [] |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;workspace_id | string | Required |  |  |
|&nbsp;connection_id | string | Required |  |  |
|&nbsp;ticket_configuration | string | Required |  |  |
|&nbsp;region | string | Required |  |  |
|location | string | Optional |  |  |
|logic_app_receiver | list(object) | Optional | [] |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;resource_id | string | Required |  |  |
|&nbsp;callback_url | string | Required |  |  |
|&nbsp;use_common_alert_schema | bool | Optional |  |  |
|sms_receiver | list(object) | Optional | [] |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;country_code | string | Required |  |  |
|&nbsp;phone_number | string | Required |  |  |
|voice_receiver | list(object) | Optional | [] |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;country_code | string | Required |  |  |
|&nbsp;phone_number | string | Required |  |  |
|webhook_receiver | list(object) | Optional | [] |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;service_uri | string | Required |  |  |
|&nbsp;use_common_alert_schema | bool | Optional |  |  |
|&nbsp;aad_auth | object | Optional |  |  |
|&nbsp;&nbsp;object_id | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;identifier_uri | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;tenant_id | string | Optional |  |  |
|&nbsp;tags | map(any) | Optional |  |  |


