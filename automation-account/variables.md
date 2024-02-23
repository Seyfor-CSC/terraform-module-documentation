# Variables

```
variable "config" {  type = list(object({
    # automation account
    name                          = string
    resource_group_name           = string
    location                      = string
    sku_name                      = string
    local_authentication_enabled  = optional(bool)
    public_network_access_enabled = optional(bool, false)
    identity = optional(object({
      type         = string
      identity_ids = optional(list(string))
    }))
    encryption = optional(object({
      key_vault_key_id          = string
      user_assigned_identity_id = optional(string)
    }))
    tags = optional(map(any))

    # automation runbook
    runbook = optional(list(object({
      name                    = string
      resource_group_name     = optional(string) # If not provided, inherited in module from parent resource
      location                = optional(string) # Inherited in module from parent resource
      automation_account_name = optional(string) # Inherited in module from parent resource
      runbook_type            = string
      log_progress            = bool
      log_verbose             = bool
      publish_content_link = optional(object({
        uri     = string
        version = optional(string)
        hash = optional(object({
          algorithm = string
          value     = string
        }))
      }))
      description              = optional(string)
      content                  = optional(string)
      log_activity_trace_level = optional(number)
      draft = optional(object({
        edit_mode_enabled = optional(bool)
        content_link = optional(object({
          uri     = string
          version = optional(string)
          hash = optional(object({
            algorithm = string
            value     = string
          }))
        }))
        output_types = optional(list(string))
        parameters = optional(list(object({
          key           = string
          type          = string
          mandatory     = optional(bool)
          position      = optional(number)
          default_value = optional(string)
        })), [])
      }))
      tags = optional(map(any)) # If not provided, inherited in module from parent resource

      # automation job schedule
      job_schedule = optional(list(object({
        resource_group_name     = optional(string) # If not provided, inherited in module from parent resource
        automation_account_name = optional(string) # Inherited in module from parent resource
        runbook_name            = optional(string) # Inherited in module from parent resource
        schedule_name           = string
        parameters              = optional(map(any))
        run_on                  = optional(string)
      })), [])
    })), [])

    # automation schedule
    schedule = optional(list(object({
      name                    = string
      resource_group_name     = optional(string) # If not provided, inherited in module from parent resource
      automation_account_name = optional(string) # Inherited in module from parent resource
      frequency               = string
      description             = optional(string)
      interval                = optional(number)
      start_time              = optional(string)
      expiry_time             = optional(string)
      timezone                = optional(string)
      week_days               = optional(list(string))
      month_days              = optional(list(number))
      monthly_occurrence = optional(object({
        day        = string
        occurrence = number
      }))
    })), [])

    # private endpoint
    private_endpoint = optional(list(object({
      name                = string
      resource_group_name = optional(string) # If not provided, inherited in module from parent resource
      location            = optional(string) # If not provided, inherited in module from parent resource
      subnet_id           = string
      private_service_connection = list(object({
        name                              = string
        is_manual_connection              = bool
        private_connection_resource_id    = optional(string)
        private_connection_resource_alias = optional(string)
        subresource_names                 = optional(list(string))
        request_message                   = optional(string)
      }))
      custom_network_interface_name = optional(string)
      private_dns_zone_group = optional(object({
        name                 = string
        private_dns_zone_ids = list(string)
      }))
      ip_configuration = optional(list(object({
        name               = string
        private_ip_address = string
        subresource_name   = string
        member_name        = optional(string)
      })), [])
      tags = optional(map(any)) # If not provided, inherited in module from parent resource
    })), [])

    # monitoring
    monitoring = optional(list(object({                 # Custom object for enabling diagnostic settings
      diag_name                      = optional(string) # Name of the diagnostic setting
      log_analytics_workspace_id     = optional(string)
      eventhub_name                  = optional(string)
      eventhub_authorization_rule_id = optional(string)
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
|sku_name | string | Required |  |  |
|local_authentication_enabled | bool | Optional |  |  |
|public_network_access_enabled | bool | Optional |  false |  |
|identity | object | Optional |  |  |
|&nbsp;type | string | Required |  |  |
|&nbsp;identity_ids | list(string) | Optional |  |  |
|encryption | object | Optional |  |  |
|&nbsp;key_vault_key_id | string | Required |  |  |
|&nbsp;user_assigned_identity_id | string | Optional |  |  |
|tags | map(any) | Optional |  |  |
|runbook | list(object) | Optional | [] |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;resource_group_name | string | Optional |  |  If not provided, inherited in module from parent resource |
|&nbsp;location | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;automation_account_name | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;runbook_type | string | Required |  |  |
|&nbsp;log_progress | bool | Required |  |  |
|&nbsp;log_verbose | bool | Required |  |  |
|&nbsp;publish_content_link | object | Optional |  |  |
|&nbsp;&nbsp;uri | string | Required |  |  |
|&nbsp;&nbsp;version | string | Optional |  |  |
|&nbsp;&nbsp;hash | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;algorithm | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;value | string | Required |  |  |
|&nbsp;description | string | Optional |  |  |
|&nbsp;content | string | Optional |  |  |
|&nbsp;log_activity_trace_level | number | Optional |  |  |
|&nbsp;draft | object | Optional |  |  |
|&nbsp;&nbsp;edit_mode_enabled | bool | Optional |  |  |
|&nbsp;&nbsp;content_link | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;uri | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;version | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;hash | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;algorithm | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;value | string | Required |  |  |
|&nbsp;&nbsp;output_types | list(string) | Optional |  |  |
|&nbsp;&nbsp;parameters | list(object) | Optional | [] |  |
|&nbsp;&nbsp;&nbsp;key | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;type | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;mandatory | bool | Optional |  |  |
|&nbsp;&nbsp;&nbsp;position | number | Optional |  |  |
|&nbsp;&nbsp;&nbsp;default_value | string | Optional |  |  |
|&nbsp;tags | map(any) | Optional |  |  If not provided, inherited in module from parent resource |
|&nbsp;job_schedule | list(object) | Optional | [] |  |
|&nbsp;&nbsp;resource_group_name | string | Optional |  |  If not provided, inherited in module from parent resource |
|&nbsp;&nbsp;automation_account_name | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;&nbsp;runbook_name | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;&nbsp;schedule_name | string | Required |  |  |
|&nbsp;&nbsp;parameters | map(any) | Optional |  |  |
|&nbsp;&nbsp;run_on | string | Optional |  |  |
|schedule | list(object) | Optional | [] |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;resource_group_name | string | Optional |  |  If not provided, inherited in module from parent resource |
|&nbsp;automation_account_name | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;frequency | string | Required |  |  |
|&nbsp;description | string | Optional |  |  |
|&nbsp;interval | number | Optional |  |  |
|&nbsp;start_time | string | Optional |  |  |
|&nbsp;expiry_time | string | Optional |  |  |
|&nbsp;timezone | string | Optional |  |  |
|&nbsp;week_days | list(string) | Optional |  |  |
|&nbsp;month_days | list(number) | Optional |  |  |
|&nbsp;monthly_occurrence | object | Optional |  |  |
|&nbsp;&nbsp;day | string | Required |  |  |
|&nbsp;&nbsp;occurrence | number | Required |  |  |
|private_endpoint | list(object) | Optional | [] |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;resource_group_name | string | Optional |  |  If not provided, inherited in module from parent resource |
|&nbsp;location | string | Optional |  |  If not provided, inherited in module from parent resource |
|&nbsp;subnet_id | string | Required |  |  |
|&nbsp;private_service_connection | list(object) | Required |  |  |
|&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;is_manual_connection | bool | Required |  |  |
|&nbsp;&nbsp;private_connection_resource_id | string | Optional |  |  |
|&nbsp;&nbsp;private_connection_resource_alias | string | Optional |  |  |
|&nbsp;&nbsp;subresource_names | list(string) | Optional |  |  |
|&nbsp;&nbsp;request_message | string | Optional |  |  |
|&nbsp;custom_network_interface_name | string | Optional |  |  |
|&nbsp;private_dns_zone_group | object | Optional |  |  |
|&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;private_dns_zone_ids | list(string) | Required |  |  |
|&nbsp;ip_configuration | list(object) | Optional | [] |  |
|&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;private_ip_address | string | Required |  |  |
|&nbsp;&nbsp;subresource_name | string | Required |  |  |
|&nbsp;&nbsp;member_name | string | Optional |  |  |
|&nbsp;tags | map(any) | Optional |  |  If not provided, inherited in module from parent resource |
|monitoring | list(object) | Optional | [] |  Custom object for enabling diagnostic settings |
|&nbsp;diag_name | string | Optional |  |  Name of the diagnostic setting |
|&nbsp;log_analytics_workspace_id | string | Optional |  |  |
|&nbsp;eventhub_name | string | Optional |  |  |
|&nbsp;eventhub_authorization_rule_id | string | Optional |  |  |


