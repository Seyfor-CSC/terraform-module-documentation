# Variables

```
variable "config" {  type = list(object({
    resource_group_name = string
    location            = string

    # monitor scheduled query rules alert v2
    logv2_alerts = optional(list(object({
      name     = string
      location = optional(string) # Overrides the config.location variable
      criteria = object({
        operator                = string
        query                   = string
        threshold               = string
        time_aggregation_method = string
        dimension = optional(object({
          name     = string
          operator = string
          values   = list(string)
        }))
        failing_periods = optional(object({
          minimum_failing_periods_to_trigger_alert = number
          number_of_evaluation_periods             = number
        }))
        metric_measure_column = optional(string)
        resource_id_column    = optional(string)
      })
      evaluation_frequency = string
      scopes               = list(string)
      severity             = number
      window_duration      = string
      action = optional(object({
        action_groups     = optional(list(string))
        custom_properties = optional(map(any))
      }))
      auto_mitigation_enabled           = optional(bool)
      workspace_alerts_storage_enabled  = optional(bool)
      description                       = optional(string)
      display_name                      = optional(string)
      enabled                           = optional(bool)
      mute_actions_after_alert_duration = optional(string)
      query_time_range_override         = optional(string)
      skip_query_validation             = optional(bool)
      target_resource_types             = optional(list(string))
      identity = optional(object({
        type         = string
        identity_ids = optional(list(string))
      }))
    })), [])

    # monitor activity log alert
    activity_alerts = optional(list(object({
      name     = string
      location = optional(string) # Overrides the config.location variable
      scopes   = list(string)
      criteria = object({
        category                = string
        caller                  = optional(string)
        operation_name          = optional(string)
        resource_provider       = optional(string)
        resource_providers      = optional(list(string))
        resource_type           = optional(string)
        resource_types          = optional(list(string))
        resource_group          = optional(string)
        resource_groups         = optional(list(string))
        resource_id             = optional(string)
        resource_ids            = optional(list(string))
        level                   = optional(string)
        levels                  = optional(list(string))
        status                  = optional(string)
        statuses                = optional(list(string))
        sub_status              = optional(string)
        sub_statuses            = optional(list(string))
        recommendation_type     = optional(string)
        recommendation_category = optional(string)
        recommendation_impact   = optional(string)
        resource_health = optional(object({
          current  = optional(string)
          previous = optional(string)
          reason   = optional(string)
        }))
        service_health = optional(object({
          events    = optional(string)
          locations = optional(string)
          services  = optional(string)
        }))
      })
      action = optional(list(object({
        action_group_id    = string
        webhook_properties = optional(map(string))
      })), [])
      enabled     = optional(bool)
      description = optional(string)
    })), [])

    # monitor metric alert
    metric_alerts = optional(list(object({
      name   = string
      scopes = list(string)
      criteria = optional(list(object({
        metric_namespace = string
        metric_name      = string
        aggregation      = string
        operator         = string
        threshold        = string
        dimension = optional(list(object({
          name     = string
          operator = string
          values   = list(string)
        })), [])
        skip_metric_validation = optional(bool)
      })), [])
      dynamic_criteria = optional(object({
        metric_namespace  = string
        metric_name       = string
        aggregation       = string
        operator          = string
        alert_sensitivity = string
        dimension = optional(list(object({
          name     = string
          operator = string
          values   = list(string)
        })), [])
        evaluation_total_count   = optional(number)
        evaluation_failure_count = optional(number)
        ignore_data_before       = optional(string)
        skip_metric_validation   = optional(bool)
      }))
      application_insights_web_test_location_availability_criteria = optional(object({
        web_test_id           = string
        component_id          = string
        failed_location_count = number
      }))
      action = optional(list(object({
        action_group_id    = string
        webhook_properties = optional(map(string))
      })), [])
      enabled                  = optional(bool)
      auto_mitigate            = optional(bool)
      description              = optional(string)
      frequency                = optional(string)
      severity                 = optional(number)
      target_resource_type     = optional(string)
      target_resource_location = optional(string)
      window_size              = optional(string)
    })), [])

    tags = optional(map(any))
  }))
}


```


## Table with config variables

| Name | Data Type | Requirement | Default Value | Comment |
| ------- | --------- | ----------- | ------------- | ------- |
|resource_group_name | string | Required |  |  |
|location | string | Required |  |  |
|logv2_alerts | list(object) | Optional | [] |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;location | string | Optional |  |  Overrides the config.location variable |
|&nbsp;criteria | object | Required |  |  |
|&nbsp;&nbsp;operator | string | Required |  |  |
|&nbsp;&nbsp;query | string | Required |  |  |
|&nbsp;&nbsp;threshold | string | Required |  |  |
|&nbsp;&nbsp;time_aggregation_method | string | Required |  |  |
|&nbsp;&nbsp;dimension | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;operator | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;values | list(string) | Required |  |  |
|&nbsp;&nbsp;failing_periods | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;minimum_failing_periods_to_trigger_alert | number | Required |  |  |
|&nbsp;&nbsp;&nbsp;number_of_evaluation_periods | number | Required |  |  |
|&nbsp;&nbsp;metric_measure_column | string | Optional |  |  |
|&nbsp;&nbsp;resource_id_column | string | Optional |  |  |
|&nbsp;evaluation_frequency | string | Required |  |  |
|&nbsp;scopes | list(string) | Required |  |  |
|&nbsp;severity | number | Required |  |  |
|&nbsp;window_duration | string | Required |  |  |
|&nbsp;action | object | Optional |  |  |
|&nbsp;&nbsp;action_groups | list(string) | Optional |  |  |
|&nbsp;&nbsp;custom_properties | map(any) | Optional |  |  |
|&nbsp;auto_mitigation_enabled | bool | Optional |  |  |
|&nbsp;workspace_alerts_storage_enabled | bool | Optional |  |  |
|&nbsp;description | string | Optional |  |  |
|&nbsp;display_name | string | Optional |  |  |
|&nbsp;enabled | bool | Optional |  |  |
|&nbsp;mute_actions_after_alert_duration | string | Optional |  |  |
|&nbsp;query_time_range_override | string | Optional |  |  |
|&nbsp;skip_query_validation | bool | Optional |  |  |
|&nbsp;target_resource_types | list(string) | Optional |  |  |
|&nbsp;identity | object | Optional |  |  |
|&nbsp;&nbsp;type | string | Required |  |  |
|&nbsp;&nbsp;identity_ids | list(string) | Optional |  |  |
|activity_alerts | list(object) | Optional | [] |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;location | string | Optional |  |  Overrides the config.location variable |
|&nbsp;scopes | list(string) | Required |  |  |
|&nbsp;criteria | object | Required |  |  |
|&nbsp;&nbsp;category | string | Required |  |  |
|&nbsp;&nbsp;caller | string | Optional |  |  |
|&nbsp;&nbsp;operation_name | string | Optional |  |  |
|&nbsp;&nbsp;resource_provider | string | Optional |  |  |
|&nbsp;&nbsp;resource_providers | list(string) | Optional |  |  |
|&nbsp;&nbsp;resource_type | string | Optional |  |  |
|&nbsp;&nbsp;resource_types | list(string) | Optional |  |  |
|&nbsp;&nbsp;resource_group | string | Optional |  |  |
|&nbsp;&nbsp;resource_groups | list(string) | Optional |  |  |
|&nbsp;&nbsp;resource_id | string | Optional |  |  |
|&nbsp;&nbsp;resource_ids | list(string) | Optional |  |  |
|&nbsp;&nbsp;level | string | Optional |  |  |
|&nbsp;&nbsp;levels | list(string) | Optional |  |  |
|&nbsp;&nbsp;status | string | Optional |  |  |
|&nbsp;&nbsp;statuses | list(string) | Optional |  |  |
|&nbsp;&nbsp;sub_status | string | Optional |  |  |
|&nbsp;&nbsp;sub_statuses | list(string) | Optional |  |  |
|&nbsp;&nbsp;recommendation_type | string | Optional |  |  |
|&nbsp;&nbsp;recommendation_category | string | Optional |  |  |
|&nbsp;&nbsp;recommendation_impact | string | Optional |  |  |
|&nbsp;&nbsp;resource_health | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;current | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;previous | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;reason | string | Optional |  |  |
|&nbsp;&nbsp;service_health | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;events | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;locations | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;services | string | Optional |  |  |
|&nbsp;action | list(object) | Optional | [] |  |
|&nbsp;&nbsp;action_group_id | string | Required |  |  |
|&nbsp;&nbsp;webhook_properties | map(string) | Optional |  |  |
|&nbsp;enabled | bool | Optional |  |  |
|&nbsp;description | string | Optional |  |  |
|metric_alerts | list(object) | Optional | [] |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;scopes | list(string) | Required |  |  |
|&nbsp;criteria | list(object) | Optional | [] |  |
|&nbsp;&nbsp;metric_namespace | string | Required |  |  |
|&nbsp;&nbsp;metric_name | string | Required |  |  |
|&nbsp;&nbsp;aggregation | string | Required |  |  |
|&nbsp;&nbsp;operator | string | Required |  |  |
|&nbsp;&nbsp;threshold | string | Required |  |  |
|&nbsp;&nbsp;dimension | list(object) | Optional | [] |  |
|&nbsp;&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;operator | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;values | list(string) | Required |  |  |
|&nbsp;&nbsp;skip_metric_validation | bool | Optional |  |  |
|&nbsp;dynamic_criteria | object | Optional |  |  |
|&nbsp;&nbsp;metric_namespace | string | Required |  |  |
|&nbsp;&nbsp;metric_name | string | Required |  |  |
|&nbsp;&nbsp;aggregation | string | Required |  |  |
|&nbsp;&nbsp;operator | string | Required |  |  |
|&nbsp;&nbsp;alert_sensitivity | string | Required |  |  |
|&nbsp;&nbsp;dimension | list(object) | Optional | [] |  |
|&nbsp;&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;operator | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;values | list(string) | Required |  |  |
|&nbsp;&nbsp;evaluation_total_count | number | Optional |  |  |
|&nbsp;&nbsp;evaluation_failure_count | number | Optional |  |  |
|&nbsp;&nbsp;ignore_data_before | string | Optional |  |  |
|&nbsp;&nbsp;skip_metric_validation | bool | Optional |  |  |
|&nbsp;application_insights_web_test_location_availability_criteria | object | Optional |  |  |
|&nbsp;&nbsp;web_test_id | string | Required |  |  |
|&nbsp;&nbsp;component_id | string | Required |  |  |
|&nbsp;&nbsp;failed_location_count | number | Required |  |  |
|&nbsp;action | list(object) | Optional | [] |  |
|&nbsp;&nbsp;action_group_id | string | Required |  |  |
|&nbsp;&nbsp;webhook_properties | map(string) | Optional |  |  |
|&nbsp;enabled | bool | Optional |  |  |
|&nbsp;auto_mitigate | bool | Optional |  |  |
|&nbsp;description | string | Optional |  |  |
|&nbsp;frequency | string | Optional |  |  |
|&nbsp;severity | number | Optional |  |  |
|&nbsp;target_resource_type | string | Optional |  |  |
|&nbsp;target_resource_location | string | Optional |  |  |
|&nbsp;window_size | string | Optional |  |  |
|tags | map(any) | Optional |  |  |


