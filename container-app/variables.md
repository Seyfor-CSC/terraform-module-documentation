# Variables

```
variable "config" {  type = list(object({
    # container app
    name                         = string
    resource_group_name          = string
    container_app_environment_id = string
    revision_mode                = string
    template = object({
      init_container = optional(object({
        args    = optional(list(string))
        command = optional(list(string))
        cpu     = optional(number)
        env = optional(list(object({
          name        = string
          secret_name = optional(string)
          value       = optional(string)
        })), [])
        ephemeral_storage = optional(string) # Is currently in preview and not configurable at this time.
        image             = string
        memory            = optional(string)
        name              = string
        volume_mounts = optional(list(object({
          name = string
          path = string
        })), [])
      }))
      container = list(object({
        args    = optional(list(string))
        command = optional(list(string))
        cpu     = number
        env = optional(list(object({
          name        = string
          secret_name = optional(string)
          value       = optional(string)
        })), [])
        ephemeral_storage = optional(string) # Is currently in preview and not configurable at this time.
        image             = string
        liveness_probe = optional(object({
          failure_count_threshold = optional(number)
          header = optional(object({
            name  = string
            value = string
          }))
          host             = optional(string)
          initial_delay    = optional(number)
          interval_seconds = optional(number)
          path             = optional(string)
          port             = number
          timeout          = optional(number)
          transport        = string
        }))
        memory = string
        name   = string
        readiness_probe = optional(object({
          failure_count_threshold = optional(number)
          header = optional(object({
            name  = string
            value = string
          }))
          host                    = optional(string)
          initial_delay           = optional(number)
          interval_seconds        = optional(number)
          path                    = optional(string)
          port                    = number
          success_count_threshold = optional(number)
          timeout                 = optional(number)
          transport               = string
        }))
        startup_probe = optional(object({
          failure_count_threshold = optional(number)
          header = optional(object({
            name  = string
            value = string
          }))
          host             = optional(string)
          initial_delay    = optional(number)
          interval_seconds = optional(number)
          path             = optional(string)
          port             = number
          timeout          = optional(number)
          transport        = string
        }))
        volume_mounts = optional(list(object({
          name     = string
          path     = string
          sub_path = optional(string)
        })), [])
      }))
      max_replicas = optional(number)
      min_replicas = optional(number)
      azure_queue_scale_rule = optional(list(object({
        name         = string
        queue_name   = string
        queue_length = number
        authentication = list(object({
          secret_name       = string
          trigger_parameter = string
        }))
      })), [])
      custom_scale_rule = optional(list(object({
        name             = string
        custom_rule_type = string
        metadata         = map(any)
        authentication = optional(list(object({
          secret_name       = string
          trigger_parameter = string
        })), [])
      })), [])
      http_scale_rule = optional(list(object({
        name                = string
        concurrent_requests = number
        authentication = optional(list(object({
          secret_name       = string
          trigger_parameter = string
        })), [])
      })), [])
      tcp_scale_rule = optional(list(object({
        name                = string
        concurrent_requests = number
        authentication = optional(list(object({
          secret_name       = string
          trigger_parameter = string
        })), [])
      })), [])
      revision_suffix                  = optional(string)
      termination_grace_period_seconds = optional(number)
      volume = optional(list(object({
        name          = string
        storage_name  = optional(string)
        storage_type  = optional(string)
        mount_options = optional(string)
      })), [])
    })
    dapr = optional(object({
      app_id       = string
      app_port     = optional(number)
      app_protocol = optional(string)
    }))
    identity = optional(object({
      type         = string
      identity_ids = optional(list(string))
    }))
    ingress = optional(object({
      allow_insecure_connections = optional(bool)
      fqdn                       = optional(string)
      external_enabled           = optional(bool)
      ip_security_restriction = optional(list(object({
        action           = string
        description      = optional(string)
        ip_address_range = string
        name             = string
      })), [])
      target_port  = number
      exposed_port = optional(number)
      traffic_weight = list(object({
        label           = optional(string)
        latest_revision = optional(bool)
        revision_suffix = optional(string)
        percentage      = number
      }))
      transport               = optional(string)
      client_certificate_mode = optional(string)
    }))
    registry = optional(object({
      server               = string
      identity             = optional(string)
      password_secret_name = optional(string)
      username             = optional(string)
    }))
    secret = optional(list(object({
      name                = string
      identity            = optional(string)
      key_vault_secret_id = optional(string)
      value               = optional(string)
    })), [])
    workload_profile_name  = optional(string)
    max_inactive_revisions = optional(number)
    tags                   = optional(map(any))
  }))
}


```


## Table with config variables

| Name | Data Type | Requirement | Default Value | Comment |
| ------- | --------- | ----------- | ------------- | ------- |
|name | string | Required |  |  |
|resource_group_name | string | Required |  |  |
|container_app_environment_id | string | Required |  |  |
|revision_mode | string | Required |  |  |
|template | object | Required |  |  |
|&nbsp;init_container | object | Optional |  |  |
|&nbsp;&nbsp;args | list(string) | Optional |  |  |
|&nbsp;&nbsp;command | list(string) | Optional |  |  |
|&nbsp;&nbsp;cpu | number | Optional |  |  |
|&nbsp;&nbsp;env | list(object) | Optional | [] |  |
|&nbsp;&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;secret_name | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;value | string | Optional |  |  |
|&nbsp;&nbsp;ephemeral_storage | string | Optional |  |  Is currently in preview and not configurable at this time. |
|&nbsp;&nbsp;image | string | Required |  |  |
|&nbsp;&nbsp;memory | string | Optional |  |  |
|&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;volume_mounts | list(object) | Optional | [] |  |
|&nbsp;&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;path | string | Required |  |  |
|&nbsp;container | list(object) | Required |  |  |
|&nbsp;&nbsp;args | list(string) | Optional |  |  |
|&nbsp;&nbsp;command | list(string) | Optional |  |  |
|&nbsp;&nbsp;cpu | number | Required |  |  |
|&nbsp;&nbsp;env | list(object) | Optional | [] |  |
|&nbsp;&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;secret_name | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;value | string | Optional |  |  |
|&nbsp;&nbsp;ephemeral_storage | string | Optional |  |  Is currently in preview and not configurable at this time. |
|&nbsp;&nbsp;image | string | Required |  |  |
|&nbsp;&nbsp;liveness_probe | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;failure_count_threshold | number | Optional |  |  |
|&nbsp;&nbsp;&nbsp;header | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;value | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;host | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;initial_delay | number | Optional |  |  |
|&nbsp;&nbsp;&nbsp;interval_seconds | number | Optional |  |  |
|&nbsp;&nbsp;&nbsp;path | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;port | number | Required |  |  |
|&nbsp;&nbsp;&nbsp;timeout | number | Optional |  |  |
|&nbsp;&nbsp;&nbsp;transport | string | Required |  |  |
|&nbsp;&nbsp;memory | string | Required |  |  |
|&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;readiness_probe | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;failure_count_threshold | number | Optional |  |  |
|&nbsp;&nbsp;&nbsp;header | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;value | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;host | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;initial_delay | number | Optional |  |  |
|&nbsp;&nbsp;&nbsp;interval_seconds | number | Optional |  |  |
|&nbsp;&nbsp;&nbsp;path | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;port | number | Required |  |  |
|&nbsp;&nbsp;&nbsp;success_count_threshold | number | Optional |  |  |
|&nbsp;&nbsp;&nbsp;timeout | number | Optional |  |  |
|&nbsp;&nbsp;&nbsp;transport | string | Required |  |  |
|&nbsp;&nbsp;startup_probe | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;failure_count_threshold | number | Optional |  |  |
|&nbsp;&nbsp;&nbsp;header | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;value | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;host | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;initial_delay | number | Optional |  |  |
|&nbsp;&nbsp;&nbsp;interval_seconds | number | Optional |  |  |
|&nbsp;&nbsp;&nbsp;path | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;port | number | Required |  |  |
|&nbsp;&nbsp;&nbsp;timeout | number | Optional |  |  |
|&nbsp;&nbsp;&nbsp;transport | string | Required |  |  |
|&nbsp;&nbsp;volume_mounts | list(object) | Optional | [] |  |
|&nbsp;&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;path | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;sub_path | string | Optional |  |  |
|&nbsp;max_replicas | number | Optional |  |  |
|&nbsp;min_replicas | number | Optional |  |  |
|&nbsp;azure_queue_scale_rule | list(object) | Optional | [] |  |
|&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;queue_name | string | Required |  |  |
|&nbsp;&nbsp;queue_length | number | Required |  |  |
|&nbsp;&nbsp;authentication | list(object) | Required |  |  |
|&nbsp;&nbsp;&nbsp;secret_name | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;trigger_parameter | string | Required |  |  |
|&nbsp;custom_scale_rule | list(object) | Optional | [] |  |
|&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;custom_rule_type | string | Required |  |  |
|&nbsp;&nbsp;metadata | map(any) | Required |  |  |
|&nbsp;&nbsp;authentication | list(object) | Optional | [] |  |
|&nbsp;&nbsp;&nbsp;secret_name | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;trigger_parameter | string | Required |  |  |
|&nbsp;http_scale_rule | list(object) | Optional | [] |  |
|&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;concurrent_requests | number | Required |  |  |
|&nbsp;&nbsp;authentication | list(object) | Optional | [] |  |
|&nbsp;&nbsp;&nbsp;secret_name | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;trigger_parameter | string | Required |  |  |
|&nbsp;tcp_scale_rule | list(object) | Optional | [] |  |
|&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;concurrent_requests | number | Required |  |  |
|&nbsp;&nbsp;authentication | list(object) | Optional | [] |  |
|&nbsp;&nbsp;&nbsp;secret_name | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;trigger_parameter | string | Required |  |  |
|&nbsp;revision_suffix | string | Optional |  |  |
|&nbsp;termination_grace_period_seconds | number | Optional |  |  |
|&nbsp;volume | list(object) | Optional | [] |  |
|&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;storage_name | string | Optional |  |  |
|&nbsp;&nbsp;storage_type | string | Optional |  |  |
|&nbsp;&nbsp;mount_options | string | Optional |  |  |
|dapr | object | Optional |  |  |
|&nbsp;app_id | string | Required |  |  |
|&nbsp;app_port | number | Optional |  |  |
|&nbsp;app_protocol | string | Optional |  |  |
|identity | object | Optional |  |  |
|&nbsp;type | string | Required |  |  |
|&nbsp;identity_ids | list(string) | Optional |  |  |
|ingress | object | Optional |  |  |
|&nbsp;allow_insecure_connections | bool | Optional |  |  |
|&nbsp;fqdn | string | Optional |  |  |
|&nbsp;external_enabled | bool | Optional |  |  |
|&nbsp;ip_security_restriction | list(object) | Optional | [] |  |
|&nbsp;&nbsp;action | string | Required |  |  |
|&nbsp;&nbsp;description | string | Optional |  |  |
|&nbsp;&nbsp;ip_address_range | string | Required |  |  |
|&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;target_port | number | Required |  |  |
|&nbsp;exposed_port | number | Optional |  |  |
|&nbsp;traffic_weight | list(object) | Required |  |  |
|&nbsp;&nbsp;label | string | Optional |  |  |
|&nbsp;&nbsp;latest_revision | bool | Optional |  |  |
|&nbsp;&nbsp;revision_suffix | string | Optional |  |  |
|&nbsp;&nbsp;percentage | number | Required |  |  |
|&nbsp;transport | string | Optional |  |  |
|&nbsp;client_certificate_mode | string | Optional |  |  |
|registry | object | Optional |  |  |
|&nbsp;server | string | Required |  |  |
|&nbsp;identity | string | Optional |  |  |
|&nbsp;password_secret_name | string | Optional |  |  |
|&nbsp;username | string | Optional |  |  |
|secret | list(object) | Optional | [] |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;identity | string | Optional |  |  |
|&nbsp;key_vault_secret_id | string | Optional |  |  |
|&nbsp;value | string | Optional |  |  |
|workload_profile_name | string | Optional |  |  |
|max_inactive_revisions | number | Optional |  |  |
|tags | map(any) | Optional |  |  |


