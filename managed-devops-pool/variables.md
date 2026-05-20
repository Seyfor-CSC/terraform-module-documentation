# Variables

```
variable "config" {  type = list(object({
    # managed devops pool
    name                = string
    resource_group_name = string
    location            = string
    azure_devops_organization = object({
      organization = list(object({
        parallelism = number
        url         = string
        projects    = optional(list(string))
      }))
      permission = optional(object({
        kind = string
        administrator_account = optional(object({
          groups = optional(list(string))
          users  = optional(list(string))
        }))
      }))
    })
    dev_center_project_id = string
    maximum_concurrency   = number
    virtual_machine_scale_set_fabric = object({
      image = list(object({
        aliases               = optional(list(string))
        buffer                = optional(string)
        id                    = optional(string)
        well_known_image_name = optional(string)
      }))
      sku_name                     = string
      os_disk_storage_account_type = optional(string)
      security = optional(object({
        interactive_logon_enabled = optional(bool)
        key_vault_management = optional(object({
          key_vault_certificate_ids  = list(string)
          certificate_store_location = optional(string)
          certificate_store_name     = optional(string)
          key_export_enabled         = optional(bool)
        }))
      }))
      storage = optional(object({
        disk_size_in_gb      = number
        caching              = optional(string)
        drive_letter         = optional(string)
        storage_account_type = optional(string)
      }))
      subnet_id = optional(string)
    })
    identity = optional(object({
      type         = string
      identity_ids = list(string)
    }))
    stateful_agent = optional(object({
      automatic_resource_prediction = optional(object({
        prediction_preference = optional(string)
      }))
      grace_period_time_span = optional(string)
      manual_resource_prediction = optional(object({
        all_week_schedule = optional(number)
        time_zone_name    = optional(string)
        monday_schedule = optional(list(object({
          count = number
          time  = string
        })), [])
        tuesday_schedule = optional(list(object({
          count = number
          time  = string
        })), [])
        wednesday_schedule = optional(list(object({
          count = number
          time  = string
        })), [])
        thursday_schedule = optional(list(object({
          count = number
          time  = string
        })), [])
        friday_schedule = optional(list(object({
          count = number
          time  = string
        })), [])
        saturday_schedule = optional(list(object({
          count = number
          time  = string
        })), [])
        sunday_schedule = optional(list(object({
          count = number
          time  = string
        })), [])
      }))
      maximum_agent_lifetime = optional(string)
    }))
    stateless_agent = optional(object({
      automatic_resource_prediction = optional(object({
        prediction_preference = optional(string)
      }))
      manual_resource_prediction = optional(object({
        all_week_schedule = optional(number)
        time_zone_name    = optional(string)
        monday_schedule = optional(list(object({
          count = number
          time  = string
        })), [])
        tuesday_schedule = optional(list(object({
          count = number
          time  = string
        })), [])
        wednesday_schedule = optional(list(object({
          count = number
          time  = string
        })), [])
        thursday_schedule = optional(list(object({
          count = number
          time  = string
        })), [])
        friday_schedule = optional(list(object({
          count = number
          time  = string
        })), [])
        saturday_schedule = optional(list(object({
          count = number
          time  = string
        })), [])
        sunday_schedule = optional(list(object({
          count = number
          time  = string
        })), [])
      }))
    }))
    work_folder = optional(string)
    tags        = optional(map(any))

    # monitoring
    monitoring = optional(list(object({
      diag_name                      = optional(string)
      log_analytics_workspace_id     = optional(string)
      eventhub_name                  = optional(string)
      eventhub_authorization_rule_id = optional(string)
      storage_account_id             = optional(string)
      categories = optional(object({
        all_metrics = optional(bool, true)
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
|azure_devops_organization | object | Required |  |  |
|&nbsp;organization | list(object) | Required |  |  |
|&nbsp;&nbsp;parallelism | number | Required |  |  |
|&nbsp;&nbsp;url | string | Required |  |  |
|&nbsp;&nbsp;projects | list(string) | Optional |  |  |
|&nbsp;permission | object | Optional |  |  |
|&nbsp;&nbsp;kind | string | Required |  |  |
|&nbsp;&nbsp;administrator_account | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;groups | list(string) | Optional |  |  |
|&nbsp;&nbsp;&nbsp;users | list(string) | Optional |  |  |
|dev_center_project_id | string | Required |  |  |
|maximum_concurrency | number | Required |  |  |
|virtual_machine_scale_set_fabric | object | Required |  |  |
|&nbsp;image | list(object) | Required |  |  |
|&nbsp;&nbsp;aliases | list(string) | Optional |  |  |
|&nbsp;&nbsp;buffer | string | Optional |  |  |
|&nbsp;&nbsp;id | string | Optional |  |  |
|&nbsp;&nbsp;well_known_image_name | string | Optional |  |  |
|&nbsp;sku_name | string | Required |  |  |
|&nbsp;os_disk_storage_account_type | string | Optional |  |  |
|&nbsp;security | object | Optional |  |  |
|&nbsp;&nbsp;interactive_logon_enabled | bool | Optional |  |  |
|&nbsp;&nbsp;key_vault_management | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;key_vault_certificate_ids | list(string) | Required |  |  |
|&nbsp;&nbsp;&nbsp;certificate_store_location | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;certificate_store_name | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;key_export_enabled | bool | Optional |  |  |
|&nbsp;storage | object | Optional |  |  |
|&nbsp;&nbsp;disk_size_in_gb | number | Required |  |  |
|&nbsp;&nbsp;caching | string | Optional |  |  |
|&nbsp;&nbsp;drive_letter | string | Optional |  |  |
|&nbsp;&nbsp;storage_account_type | string | Optional |  |  |
|&nbsp;subnet_id | string | Optional |  |  |
|identity | object | Optional |  |  |
|&nbsp;type | string | Required |  |  |
|&nbsp;identity_ids | list(string) | Required |  |  |
|stateful_agent | object | Optional |  |  |
|&nbsp;automatic_resource_prediction | object | Optional |  |  |
|&nbsp;&nbsp;prediction_preference | string | Optional |  |  |
|&nbsp;grace_period_time_span | string | Optional |  |  |
|&nbsp;manual_resource_prediction | object | Optional |  |  |
|&nbsp;&nbsp;all_week_schedule | number | Optional |  |  |
|&nbsp;&nbsp;time_zone_name | string | Optional |  |  |
|&nbsp;&nbsp;monday_schedule | list(object) | Optional | [] |  |
|&nbsp;&nbsp;&nbsp;count | number | Required |  |  |
|&nbsp;&nbsp;&nbsp;time | string | Required |  |  |
|&nbsp;&nbsp;tuesday_schedule | list(object) | Optional | [] |  |
|&nbsp;&nbsp;&nbsp;count | number | Required |  |  |
|&nbsp;&nbsp;&nbsp;time | string | Required |  |  |
|&nbsp;&nbsp;wednesday_schedule | list(object) | Optional | [] |  |
|&nbsp;&nbsp;&nbsp;count | number | Required |  |  |
|&nbsp;&nbsp;&nbsp;time | string | Required |  |  |
|&nbsp;&nbsp;thursday_schedule | list(object) | Optional | [] |  |
|&nbsp;&nbsp;&nbsp;count | number | Required |  |  |
|&nbsp;&nbsp;&nbsp;time | string | Required |  |  |
|&nbsp;&nbsp;friday_schedule | list(object) | Optional | [] |  |
|&nbsp;&nbsp;&nbsp;count | number | Required |  |  |
|&nbsp;&nbsp;&nbsp;time | string | Required |  |  |
|&nbsp;&nbsp;saturday_schedule | list(object) | Optional | [] |  |
|&nbsp;&nbsp;&nbsp;count | number | Required |  |  |
|&nbsp;&nbsp;&nbsp;time | string | Required |  |  |
|&nbsp;&nbsp;sunday_schedule | list(object) | Optional | [] |  |
|&nbsp;&nbsp;&nbsp;count | number | Required |  |  |
|&nbsp;&nbsp;&nbsp;time | string | Required |  |  |
|&nbsp;maximum_agent_lifetime | string | Optional |  |  |
|stateless_agent | object | Optional |  |  |
|&nbsp;automatic_resource_prediction | object | Optional |  |  |
|&nbsp;&nbsp;prediction_preference | string | Optional |  |  |
|&nbsp;manual_resource_prediction | object | Optional |  |  |
|&nbsp;&nbsp;all_week_schedule | number | Optional |  |  |
|&nbsp;&nbsp;time_zone_name | string | Optional |  |  |
|&nbsp;&nbsp;monday_schedule | list(object) | Optional | [] |  |
|&nbsp;&nbsp;&nbsp;count | number | Required |  |  |
|&nbsp;&nbsp;&nbsp;time | string | Required |  |  |
|&nbsp;&nbsp;tuesday_schedule | list(object) | Optional | [] |  |
|&nbsp;&nbsp;&nbsp;count | number | Required |  |  |
|&nbsp;&nbsp;&nbsp;time | string | Required |  |  |
|&nbsp;&nbsp;wednesday_schedule | list(object) | Optional | [] |  |
|&nbsp;&nbsp;&nbsp;count | number | Required |  |  |
|&nbsp;&nbsp;&nbsp;time | string | Required |  |  |
|&nbsp;&nbsp;thursday_schedule | list(object) | Optional | [] |  |
|&nbsp;&nbsp;&nbsp;count | number | Required |  |  |
|&nbsp;&nbsp;&nbsp;time | string | Required |  |  |
|&nbsp;&nbsp;friday_schedule | list(object) | Optional | [] |  |
|&nbsp;&nbsp;&nbsp;count | number | Required |  |  |
|&nbsp;&nbsp;&nbsp;time | string | Required |  |  |
|&nbsp;&nbsp;saturday_schedule | list(object) | Optional | [] |  |
|&nbsp;&nbsp;&nbsp;count | number | Required |  |  |
|&nbsp;&nbsp;&nbsp;time | string | Required |  |  |
|&nbsp;&nbsp;sunday_schedule | list(object) | Optional | [] |  |
|&nbsp;&nbsp;&nbsp;count | number | Required |  |  |
|&nbsp;&nbsp;&nbsp;time | string | Required |  |  |
|work_folder | string | Optional |  |  |
|tags | map(any) | Optional |  |  |
|monitoring | list(object) | Optional | [] |  |
|&nbsp;diag_name | string | Optional |  |  |
|&nbsp;log_analytics_workspace_id | string | Optional |  |  |
|&nbsp;eventhub_name | string | Optional |  |  |
|&nbsp;eventhub_authorization_rule_id | string | Optional |  |  |
|&nbsp;storage_account_id | string | Optional |  |  |
|&nbsp;categories | object | Optional |  |  |
|&nbsp;&nbsp;all_metrics | bool | Optional |  true |  |


