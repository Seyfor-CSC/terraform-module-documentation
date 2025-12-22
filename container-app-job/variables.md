# Variables

```
variable "config" {  type = list(object({
    # Container App Job
    name                         = string
    resource_group_name          = string
    location                     = string
    container_app_environment_id = string
    template = object({
      container = object({
        name    = string
        cpu     = number
        memory  = string
        image   = string
        args    = optional(list(string))
        command = optional(list(string))
        env = optional(list(object({
          name        = string
          value       = optional(string)
          secret_name = optional(string)
        })), [])
        ephemeral_storage = optional(string) # Is currently in preview and not configurable at this time.
        liveness_probe = optional(object({
          port                    = number
          transport               = string
          failure_count_threshold = optional(number)
          header = optional(object({
            name  = string
            value = string
          }))
          host             = optional(string)
          initial_delay    = optional(number)
          interval_seconds = optional(number)
          path             = optional(string)
          timeout          = optional(number)
        }))
        readiness_probe = optional(object({
          port                    = number
          transport               = string
          failure_count_threshold = optional(number)
          header = optional(object({
            name  = string
            value = string
          }))
          host                    = optional(string)
          initial_delay           = optional(number)
          interval_seconds        = optional(number)
          path                    = optional(string)
          success_count_threshold = optional(number)
          timeout                 = optional(number)
        }))
        startup_probe = optional(object({
          port                    = number
          transport               = string
          failure_count_threshold = optional(number)
          header = optional(object({
            name  = string
            value = string
          }))
          host             = optional(string)
          initial_delay    = optional(number)
          interval_seconds = optional(number)
          path             = optional(string)
          timeout          = optional(number)
        }))
        volume_mounts = optional(object({
          name = string
          path = string
        }))
      })
      init_container = optional(object({
        name    = string
        cpu     = optional(number)
        memory  = optional(string)
        image   = string
        args    = optional(list(string))
        command = optional(list(string))
        env = optional(list(object({
          name        = string
          value       = optional(string)
          secret_name = optional(string)
        })), [])
        ephemeral_storage = optional(string) # Is currently in preview and not configurable at this time.
        volume_mounts = optional(object({
          name = string
          path = string
        }))
      }))
      volume = optional(object({
        name          = string
        storage_type  = optional(string)
        storage_name  = optional(string)
        mount_options = optional(string)
      }))
    })
    replica_timeout_in_seconds = number
    workload_profile_name      = optional(string)
    replica_retry_limit        = optional(number)
    secret = optional(list(object({
      name                = string
      identity            = optional(string)
      key_vault_secret_id = optional(string)
      value               = string
    })), [])
    registry = optional(list(object({
      identity             = optional(string)
      username             = optional(string)
      password_secret_name = optional(string)
      server               = string
    })), [])
    manual_trigger_config = optional(object({
      parallelism              = optional(number)
      replica_completion_count = optional(number)
    }))
    event_trigger_config = optional(object({
      parallelism              = optional(number)
      replica_completion_count = optional(number)
      scale = optional(object({
        max_executions              = optional(number)
        min_executions              = optional(number)
        polling_interval_in_seconds = optional(number)
        rules = optional(object({
          name             = string
          custom_rule_type = string
          metadata         = map(any)
          authentication = optional(object({
            secret_name       = string
            trigger_parameter = string
          }))
        }))
      }))
    }))
    schedule_trigger_config = optional(object({
      cron_expression          = string
      parallelism              = optional(number)
      replica_completion_count = optional(number)
    }))
    identity = optional(object({
      type         = string
      identity_ids = optional(list(string))
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
|container_app_environment_id | string | Required |  |  |
|template | object | Required |  |  |
|&nbsp;container | object | Required |  |  |
|&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;cpu | number | Required |  |  |
|&nbsp;&nbsp;memory | string | Required |  |  |
|&nbsp;&nbsp;image | string | Required |  |  |
|&nbsp;&nbsp;args | list(string) | Optional |  |  |
|&nbsp;&nbsp;command | list(string) | Optional |  |  |
|&nbsp;&nbsp;env | list(object) | Optional | [] |  |
|&nbsp;&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;value | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;secret_name | string | Optional |  |  |
|&nbsp;&nbsp;ephemeral_storage | string | Optional |  |  Is currently in preview and not configurable at this time. |
|&nbsp;&nbsp;liveness_probe | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;port | number | Required |  |  |
|&nbsp;&nbsp;&nbsp;transport | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;failure_count_threshold | number | Optional |  |  |
|&nbsp;&nbsp;&nbsp;header | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;value | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;host | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;initial_delay | number | Optional |  |  |
|&nbsp;&nbsp;&nbsp;interval_seconds | number | Optional |  |  |
|&nbsp;&nbsp;&nbsp;path | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;timeout | number | Optional |  |  |
|&nbsp;&nbsp;readiness_probe | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;port | number | Required |  |  |
|&nbsp;&nbsp;&nbsp;transport | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;failure_count_threshold | number | Optional |  |  |
|&nbsp;&nbsp;&nbsp;header | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;value | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;host | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;initial_delay | number | Optional |  |  |
|&nbsp;&nbsp;&nbsp;interval_seconds | number | Optional |  |  |
|&nbsp;&nbsp;&nbsp;path | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;success_count_threshold | number | Optional |  |  |
|&nbsp;&nbsp;&nbsp;timeout | number | Optional |  |  |
|&nbsp;&nbsp;startup_probe | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;port | number | Required |  |  |
|&nbsp;&nbsp;&nbsp;transport | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;failure_count_threshold | number | Optional |  |  |
|&nbsp;&nbsp;&nbsp;header | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;value | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;host | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;initial_delay | number | Optional |  |  |
|&nbsp;&nbsp;&nbsp;interval_seconds | number | Optional |  |  |
|&nbsp;&nbsp;&nbsp;path | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;timeout | number | Optional |  |  |
|&nbsp;&nbsp;volume_mounts | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;path | string | Required |  |  |
|&nbsp;init_container | object | Optional |  |  |
|&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;cpu | number | Optional |  |  |
|&nbsp;&nbsp;memory | string | Optional |  |  |
|&nbsp;&nbsp;image | string | Required |  |  |
|&nbsp;&nbsp;args | list(string) | Optional |  |  |
|&nbsp;&nbsp;command | list(string) | Optional |  |  |
|&nbsp;&nbsp;env | list(object) | Optional | [] |  |
|&nbsp;&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;value | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;secret_name | string | Optional |  |  |
|&nbsp;&nbsp;ephemeral_storage | string | Optional |  |  Is currently in preview and not configurable at this time. |
|&nbsp;&nbsp;volume_mounts | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;path | string | Required |  |  |
|&nbsp;volume | object | Optional |  |  |
|&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;storage_type | string | Optional |  |  |
|&nbsp;&nbsp;storage_name | string | Optional |  |  |
|&nbsp;&nbsp;mount_options | string | Optional |  |  |
|replica_timeout_in_seconds | number | Required |  |  |
|workload_profile_name | string | Optional |  |  |
|replica_retry_limit | number | Optional |  |  |
|secret | list(object) | Optional | [] |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;identity | string | Optional |  |  |
|&nbsp;key_vault_secret_id | string | Optional |  |  |
|&nbsp;value | string | Required |  |  |
|registry | list(object) | Optional | [] |  |
|&nbsp;identity | string | Optional |  |  |
|&nbsp;username | string | Optional |  |  |
|&nbsp;password_secret_name | string | Optional |  |  |
|&nbsp;server | string | Required |  |  |
|manual_trigger_config | object | Optional |  |  |
|&nbsp;parallelism | number | Optional |  |  |
|&nbsp;replica_completion_count | number | Optional |  |  |
|event_trigger_config | object | Optional |  |  |
|&nbsp;parallelism | number | Optional |  |  |
|&nbsp;replica_completion_count | number | Optional |  |  |
|&nbsp;scale | object | Optional |  |  |
|&nbsp;&nbsp;max_executions | number | Optional |  |  |
|&nbsp;&nbsp;min_executions | number | Optional |  |  |
|&nbsp;&nbsp;polling_interval_in_seconds | number | Optional |  |  |
|&nbsp;&nbsp;rules | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;custom_rule_type | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;metadata | map(any) | Required |  |  |
|&nbsp;&nbsp;&nbsp;authentication | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;secret_name | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;trigger_parameter | string | Required |  |  |
|schedule_trigger_config | object | Optional |  |  |
|&nbsp;cron_expression | string | Required |  |  |
|&nbsp;parallelism | number | Optional |  |  |
|&nbsp;replica_completion_count | number | Optional |  |  |
|identity | object | Optional |  |  |
|&nbsp;type | string | Required |  |  |
|&nbsp;identity_ids | list(string) | Optional |  |  |
|tags | map(any) | Optional |  |  |


