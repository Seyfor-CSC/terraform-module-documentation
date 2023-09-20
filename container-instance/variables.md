# Variables

```
variable "config" {  type = list(object({
    # container group
    name                = string
    resource_group_name = string
    location            = string
    container = list(object({
      name   = string
      image  = string
      cpu    = number
      memory = number
      gpu = optional(object({
        count = optional(number)
        sku   = optional(string)
      }))
      cpu_limit    = optional(number)
      memory_limit = optional(number)
      gpu_limit = optional(object({
        count = optional(number)
        sku   = optional(string)
      }))
      ports = optional(list(object({
        port     = optional(number)
        protocol = optional(string)
      })), [])
      environment_variables        = optional(map(string))
      secure_environment_variables = optional(map(string))
      readiness_probe = optional(object({
        exec = optional(list(string))
        http_get = optional(object({
          path         = optional(string)
          port         = optional(number)
          scheme       = optional(string, "Https")
          http_headers = optional(map(string))
        }))
        initial_delay_seconds = optional(number)
        period_seconds        = optional(number)
        failure_threshold     = optional(number)
        success_threshold     = optional(number)
        timeout_seconds       = optional(number)
      }))
      liveness_probe = optional(object({
        exec = optional(list(string))
        http_get = optional(object({
          path         = optional(string)
          port         = optional(number)
          scheme       = optional(string, "Https")
          http_headers = optional(map(string))
        }))
        initial_delay_seconds = optional(number)
        period_seconds        = optional(number)
        failure_threshold     = optional(number)
        success_threshold     = optional(number)
        timeout_seconds       = optional(number)
      }))
      commands = optional(list(string))
      volume = optional(object({
        name                 = string
        mount_path           = string
        read_only            = optional(bool)
        empty_dir            = optional(bool)
        storage_account_name = optional(string)
        storage_account_key  = optional(string)
        share_name           = optional(string)
        git_repo = optional(object({
          url       = string
          directory = optional(string)
          revision  = optional(string)
        }))
        secret = optional(map(string))
      }))
    }))
    os_type = string
    sku     = optional(string)
    identity = optional(object({
      type         = string
      identity_ids = optional(list(string))
    }))
    init_container = optional(object({
      name                         = string
      image                        = string
      environment_variables        = optional(map(string))
      secure_environment_variables = optional(map(string))
      commands                     = optional(list(string))
      volume = optional(object({
        name                 = string
        mount_path           = string
        read_only            = optional(bool)
        empty_dir            = optional(bool)
        storage_account_name = optional(string)
        storage_account_key  = optional(string)
        share_name           = optional(string)
        git_repo = optional(object({
          url       = string
          directory = optional(string)
          revision  = optional(string)
        }))
        secret = optional(map(string))
      }))
      security = optional(object({
        privilege_enabled = bool
      }))
      })
    )
    dns_config = optional(object({
      nameservers    = list(string)
      search_domains = optional(list(string))
      options        = optional(list(string))
    }))
    diagnostics = optional(object({
      log_analytics = object({
        workspace_id  = string
        workspace_key = string
        log_type      = optional(string)
        metadata      = optional(string)
      })
    }))
    dns_name_label              = optional(string)
    dns_name_label_reuse_policy = optional(string)
    exposed_port = optional(list(object({
      port     = optional(number)
      protocol = optional(string)
    })), [])
    ip_address_type  = optional(string)
    key_vault_key_id = optional(string)
    subnet_ids       = optional(set(string))
    image_registry_credential = optional(object({
      server                    = string
      user_assigned_identity_id = optional(string)
      username                  = optional(string)
      password                  = optional(string)
    }))
    restart_policy = optional(string)
    zones          = optional(list(string))
    tags           = optional(map(any))
  }))
}


```


## Table with config variables

| Name | Data Type | Requirement | Default Value | Comment |
| ------- | --------- | ----------- | ------------- | ------- |
|name | string | Required |  |  |
|resource_group_name | string | Required |  |  |
|location | string | Required |  |  |
|container | list(object) | Required |  |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;image | string | Required |  |  |
|&nbsp;cpu | number | Required |  |  |
|&nbsp;memory | number | Required |  |  |
|&nbsp;gpu | object | Optional |  |  |
|&nbsp;&nbsp;count | number | Optional |  |  |
|&nbsp;&nbsp;sku | string | Optional |  |  |
|&nbsp;cpu_limit | number | Optional |  |  |
|&nbsp;memory_limit | number | Optional |  |  |
|&nbsp;gpu_limit | object | Optional |  |  |
|&nbsp;&nbsp;count | number | Optional |  |  |
|&nbsp;&nbsp;sku | string | Optional |  |  |
|&nbsp;ports | list(object) | Optional | [] |  |
|&nbsp;&nbsp;port | number | Optional |  |  |
|&nbsp;&nbsp;protocol | string | Optional |  |  |
|&nbsp;environment_variables | map(string) | Optional |  |  |
|&nbsp;secure_environment_variables | map(string) | Optional |  |  |
|&nbsp;readiness_probe | object | Optional |  |  |
|&nbsp;&nbsp;exec | list(string) | Optional |  |  |
|&nbsp;&nbsp;http_get | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;path | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;port | number | Optional |  |  |
|&nbsp;&nbsp;&nbsp;scheme | string | Optional |  "Https" |  |
|&nbsp;&nbsp;&nbsp;http_headers | map(string) | Optional |  |  |
|&nbsp;&nbsp;initial_delay_seconds | number | Optional |  |  |
|&nbsp;&nbsp;period_seconds | number | Optional |  |  |
|&nbsp;&nbsp;failure_threshold | number | Optional |  |  |
|&nbsp;&nbsp;success_threshold | number | Optional |  |  |
|&nbsp;&nbsp;timeout_seconds | number | Optional |  |  |
|&nbsp;liveness_probe | object | Optional |  |  |
|&nbsp;&nbsp;exec | list(string) | Optional |  |  |
|&nbsp;&nbsp;http_get | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;path | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;port | number | Optional |  |  |
|&nbsp;&nbsp;&nbsp;scheme | string | Optional |  "Https" |  |
|&nbsp;&nbsp;&nbsp;http_headers | map(string) | Optional |  |  |
|&nbsp;&nbsp;initial_delay_seconds | number | Optional |  |  |
|&nbsp;&nbsp;period_seconds | number | Optional |  |  |
|&nbsp;&nbsp;failure_threshold | number | Optional |  |  |
|&nbsp;&nbsp;success_threshold | number | Optional |  |  |
|&nbsp;&nbsp;timeout_seconds | number | Optional |  |  |
|&nbsp;commands | list(string) | Optional |  |  |
|&nbsp;volume | object | Optional |  |  |
|&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;mount_path | string | Required |  |  |
|&nbsp;&nbsp;read_only | bool | Optional |  |  |
|&nbsp;&nbsp;empty_dir | bool | Optional |  |  |
|&nbsp;&nbsp;storage_account_name | string | Optional |  |  |
|&nbsp;&nbsp;storage_account_key | string | Optional |  |  |
|&nbsp;&nbsp;share_name | string | Optional |  |  |
|&nbsp;&nbsp;git_repo | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;url | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;directory | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;revision | string | Optional |  |  |
|&nbsp;&nbsp;secret | map(string) | Optional |  |  |
|os_type | string | Required |  |  |
|sku | string | Optional |  |  |
|identity | object | Optional |  |  |
|&nbsp;type | string | Required |  |  |
|&nbsp;identity_ids | list(string) | Optional |  |  |
|init_container | object | Optional |  |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;image | string | Required |  |  |
|&nbsp;environment_variables | map(string) | Optional |  |  |
|&nbsp;secure_environment_variables | map(string) | Optional |  |  |
|&nbsp;commands | list(string) | Optional |  |  |
|&nbsp;volume | object | Optional |  |  |
|&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;mount_path | string | Required |  |  |
|&nbsp;&nbsp;read_only | bool | Optional |  |  |
|&nbsp;&nbsp;empty_dir | bool | Optional |  |  |
|&nbsp;&nbsp;storage_account_name | string | Optional |  |  |
|&nbsp;&nbsp;storage_account_key | string | Optional |  |  |
|&nbsp;&nbsp;share_name | string | Optional |  |  |
|&nbsp;&nbsp;git_repo | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;url | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;directory | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;revision | string | Optional |  |  |
|&nbsp;&nbsp;secret | map(string) | Optional |  |  |
|&nbsp;security | object | Optional |  |  |
|&nbsp;&nbsp;privilege_enabled | bool | Required |  |  |
|dns_config | object | Optional |  |  |
|&nbsp;nameservers | list(string) | Required |  |  |
|&nbsp;search_domains | list(string) | Optional |  |  |
|&nbsp;options | list(string) | Optional |  |  |
|diagnostics | object | Optional |  |  |
|&nbsp;log_analytics | object | Required |  |  |
|&nbsp;&nbsp;workspace_id | string | Required |  |  |
|&nbsp;&nbsp;workspace_key | string | Required |  |  |
|&nbsp;&nbsp;log_type | string | Optional |  |  |
|&nbsp;&nbsp;metadata | string | Optional |  |  |
|dns_name_label | string | Optional |  |  |
|dns_name_label_reuse_policy | string | Optional |  |  |
|exposed_port | list(object) | Optional | [] |  |
|&nbsp;port | number | Optional |  |  |
|&nbsp;protocol | string | Optional |  |  |
|ip_address_type | string | Optional |  |  |
|key_vault_key_id | string | Optional |  |  |
|subnet_ids | set(string) | Optional |  |  |
|image_registry_credential | object | Optional |  |  |
|&nbsp;server | string | Required |  |  |
|&nbsp;user_assigned_identity_id | string | Optional |  |  |
|&nbsp;username | string | Optional |  |  |
|&nbsp;password | string | Optional |  |  |
|restart_policy | string | Optional |  |  |
|zones | list(string) | Optional |  |  |
|tags | map(any) | Optional |  |  |


