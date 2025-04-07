# Variables

```
variable "config" {  type = list(object({
    # role management policy
    custom_name        = string
    role_definition_id = string
    scope              = string
    activation_rules = optional(object({
      approval_stage = optional(object({
        primary_approver = list(object({
          object_id = string
          type      = string
        }))
      }))
      maximum_duration                                   = optional(string)
      require_approval                                   = optional(bool)
      require_justification                              = optional(bool)
      require_multifactor_authentication                 = optional(bool)
      require_ticket_info                                = optional(bool)
      required_conditional_access_authentication_context = optional(bool)
    }))
    active_assignment_rules = optional(object({
      expiration_required                = optional(bool)
      expire_after                       = optional(string)
      require_justification              = optional(bool)
      require_multifactor_authentication = optional(bool)
      require_ticket_info                = optional(bool)
    }))
    eligible_assignment_rules = optional(object({
      expiration_required = optional(bool)
      expire_after        = optional(string)
    }))
    notification_rules = optional(object({
      active_assignments = optional(object({
        admin_notifications = optional(object({
          additional_recipients = optional(list(string))
          default_recipients    = bool
          notification_level    = string
        }))
        approver_notifications = optional(object({
          additional_recipients = optional(list(string))
          default_recipients    = bool
          notification_level    = string
        }))
        assignee_notifications = optional(object({
          additional_recipients = optional(list(string))
          default_recipients    = bool
          notification_level    = string
        }))
      }))
      eligible_activations = optional(object({
        admin_notifications = optional(object({
          additional_recipients = optional(list(string))
          default_recipients    = bool
          notification_level    = string
        }))
        approver_notifications = optional(object({
          additional_recipients = optional(list(string))
          default_recipients    = bool
          notification_level    = string
        }))
        assignee_notifications = optional(object({
          additional_recipients = optional(list(string))
          default_recipients    = bool
          notification_level    = string
        }))
      }))
      eligible_assignments = optional(object({
        admin_notifications = optional(object({
          additional_recipients = optional(list(string))
          default_recipients    = bool
          notification_level    = string
        }))
        approver_notifications = optional(object({
          additional_recipients = optional(list(string))
          default_recipients    = bool
          notification_level    = string
        }))
        assignee_notifications = optional(object({
          additional_recipients = optional(list(string))
          default_recipients    = bool
          notification_level    = string
        }))
      }))
    }))
  }))
}


```


## Table with config variables

| Name | Data Type | Requirement | Default Value | Comment |
| ------- | --------- | ----------- | ------------- | ------- |
|custom_name | string | Required |  |  |
|role_definition_id | string | Required |  |  |
|scope | string | Required |  |  |
|activation_rules | object | Optional |  |  |
|&nbsp;approval_stage | object | Optional |  |  |
|&nbsp;&nbsp;primary_approver | list(object) | Required |  |  |
|&nbsp;&nbsp;&nbsp;object_id | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;type | string | Required |  |  |
|&nbsp;&nbsp;maximum_duration | string | Optional |  |  |
|&nbsp;&nbsp;require_approval | bool | Optional |  |  |
|&nbsp;&nbsp;require_justification | bool | Optional |  |  |
|&nbsp;&nbsp;require_multifactor_authentication | bool | Optional |  |  |
|&nbsp;&nbsp;require_ticket_info | bool | Optional |  |  |
|&nbsp;&nbsp;required_conditional_access_authentication_context | bool | Optional |  |  |
|&nbsp;active_assignment_rules | object | Optional |  |  |
|&nbsp;&nbsp;expiration_required | bool | Optional |  |  |
|&nbsp;&nbsp;expire_after | string | Optional |  |  |
|&nbsp;&nbsp;require_justification | bool | Optional |  |  |
|&nbsp;&nbsp;require_multifactor_authentication | bool | Optional |  |  |
|&nbsp;&nbsp;require_ticket_info | bool | Optional |  |  |
|&nbsp;eligible_assignment_rules | object | Optional |  |  |
|&nbsp;&nbsp;expiration_required | bool | Optional |  |  |
|&nbsp;&nbsp;expire_after | string | Optional |  |  |
|&nbsp;notification_rules | object | Optional |  |  |
|&nbsp;&nbsp;active_assignments | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;admin_notifications | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;additional_recipients | list(string) | Optional |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;default_recipients | bool | Required |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;notification_level | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;approver_notifications | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;additional_recipients | list(string) | Optional |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;default_recipients | bool | Required |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;notification_level | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;assignee_notifications | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;additional_recipients | list(string) | Optional |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;default_recipients | bool | Required |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;notification_level | string | Required |  |  |
|&nbsp;&nbsp;eligible_activations | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;admin_notifications | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;additional_recipients | list(string) | Optional |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;default_recipients | bool | Required |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;notification_level | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;approver_notifications | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;additional_recipients | list(string) | Optional |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;default_recipients | bool | Required |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;notification_level | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;assignee_notifications | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;additional_recipients | list(string) | Optional |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;default_recipients | bool | Required |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;notification_level | string | Required |  |  |
|&nbsp;&nbsp;eligible_assignments | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;admin_notifications | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;additional_recipients | list(string) | Optional |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;default_recipients | bool | Required |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;notification_level | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;approver_notifications | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;additional_recipients | list(string) | Optional |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;default_recipients | bool | Required |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;notification_level | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;assignee_notifications | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;additional_recipients | list(string) | Optional |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;default_recipients | bool | Required |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;notification_level | string | Required |  |  |


