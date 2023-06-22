# Variable Structure

```
variable "config" {
  type = list(object({
    name                = string
    location            = string
    resource_group_name = string
    sku                 = string
    identity = optional(object({
      type         = string
      identity_ids = optional(list(string))
    }))
    public_network_access_enabled = optional(string)
    immutability                  = optional(string)
    storage_mode_type             = optional(string)
    cross_region_restore_enabled  = optional(string)
    soft_delete_enabled           = optional(string)
    encryption = optional(object({
      key_id                            = string
      infrastructure_encryption_enabled = bool
      user_assigned_identity_id         = optional(string)
      use_system_assigned_identity      = optional(bool)
    }))
    classic_vmware_replication_enabled = optional(bool)

    # backup policy vm
    backup_policy = optional(list(object({
      name                = string
      resource_group_name = optional(string) # If not provided, inherited from parent resource
      recovery_vault_name = optional(string) # Inherited from parent resource
      backup = object({
        frequency     = string
        time          = string
        hour_interval = optional(number)
        hour_duration = optional(number)
        weekdays      = optional(list(string))
      })
      timezone                       = optional(string)
      policy_type                    = optional(string)
      instant_restore_retention_days = optional(number)
      instant_restore_resource_group = optional(object({
        prefix = string
        suffix = optional(string)
      }))
      retention_daily = optional(object({
        count = number
      }))
      retention_weekly = optional(object({
        count    = number
        weekdays = list(string)
      }))
      retention_monthly = optional(object({
        count    = number
        weekdays = list(string)
        weeks    = list(string)
      }))
      retention_yearly = optional(object({
        count    = number
        weekdays = list(string)
        weeks    = list(string)
        months   = list(string)
      }))

      # backup protected vm
      protected_vm = optional(list(object({
        resource_group_name = optional(string) # If not provided, inherited from parent resource
        recovery_vault_name = optional(string) # Inherited from parent resource
        backup_policy_id    = optional(string) # Inherited from parent resource
        source_vm_id        = optional(string)
        exclude_disk_luns   = optional(list(number))
        include_disk_luns   = optional(list(number))
      })), [])
    })), [])

    # private endpoint
    private_endpoint = optional(list(object({
      name                = string
      resource_group_name = optional(string) # If not provided, inherited from parent resource
      location            = optional(string) # If not provided, inherited from parent resource
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
      private_dns_zone_group = optional(list(object({
        name                 = string
        private_dns_zone_ids = list(string)
      })), [])
      ip_configuration = optional(list(object({
        name               = string
        private_ip_address = string
        subresource_name   = string
        member_name        = optional(string)
      })), [])
      tags = optional(map(any))
    })), [])

    # monitoring
    monitoring = optional(list(object({ # Custom object for enabling diagnostic settings
      diag_name                      = optional(string) # Name of the diagnostic setting
      log_analytics_workspace_id     = optional(string)
      eventhub_name                  = optional(string)
      eventhub_authorization_rule_id = optional(string) # Event Hub namespace authorization rule
    })), [])

    tags = optional(map(any))
  }))
}
```

# Table
 

| Parameter name                                | Data type    | Requirement | Default value | Comment                                         |
| --------------------------------------------- | ------------ | ----------- | ------------- | ----------------------------------------------- |
| name                                          | string       | Required    |               |                                                 |
| location                                      | string       | Required    |               |                                                 |
| resource_group_name                           | string       | Required    |               |                                                 |
| sku                                           | string       | Required    |               |                                                 |
| identity                                      | object       | Optional    |               |                                                 |
| &emsp;type                                    | string       | Required    |               |                                                 |
| &emsp;identity_ids                            | list(string) | Optional    |               |                                                 |
| public_network_access_enabled                 | string       | Optional    |               |                                                 |
| immutability                                  | string       | Optional    |               |                                                 |
| storage_mode_type                             | string       | Optional    |               |                                                 |
| cross_region_restore_enabled                  | string       | Optional    |               |                                                 |
| soft_delete_enabled                           | string       | Optional    |               |                                                 |
| encryption                                    | object       | Optional    |               |                                                 |
| &emsp;key_id                                  | string       | Required    |               |                                                 |
| &emsp;infrastructure_encryption_enabled       | bool         | Required    |               |                                                 |
| &emsp;user_assigned_identity_id               | string       | Optional    |               |                                                 |
| &emsp;use_system_assigned_identity            | bool         | Optional    |               |                                                 |
| classic_vmware_replication_enabled            | bool         | Optional    |               |                                                 |
| backup_policy                                 | list(object) | Optional    | []            |                                                 |
| &emsp;name                                    | string       | Required    |               |                                                 |
| &emsp;resource_group_name                     | string       | Optional    |               | If not provided, inherited from parent resource |
| &emsp;recovery_vault_name                     | string       | Optional    |               | Inherited from parent resource                  |
| &emsp;backup                                  | object       | Required    |               |                                                 |
| &emsp;&emsp;frequency                         | string       | Required    |               |                                                 |
| &emsp;&emsp;time                              | string       | Required    |               |                                                 |
| &emsp;&emsp;hour_interval                     | number       | Optional    |               |                                                 |
| &emsp;&emsp;hour_duration                     | number       | Optional    |               |                                                 |
| &emsp;&emsp;weekdays                          | list(string) | Optional    |               |                                                 |
| &emsp;timezone                                | string       | Optional    |               |                                                 |
| &emsp;policy_type                             | string       | Optional    |               |                                                 |
| &emsp;instant_restore_retention_days          | number       | Optional    |               |                                                 |
| &emsp;instant_restore_resource_group          | object       | Optional    |               |                                                 |
| &emsp;&emsp;prefix                            | string       | Required    |               |                                                 |
| &emsp;&emsp;suffix                            | string       | Optional    |               |                                                 |
| &emsp;retention_daily                         | object       | Optional    |               |                                                 |
| &emsp;&emsp;count                             | number       | Required    |               |                                                 |
| &emsp;retention_weekly                        | object       | Optional    |               |                                                 |
| &emsp;&emsp;count                             | number       | Required    |               |                                                 |
| &emsp;&emsp;weekdays                          | list(string) | Required    |               |                                                 |
| &emsp;retention_monthly                       | object       | Optional    |               |                                                 |
| &emsp;&emsp;count                             | number       | Required    |               |                                                 |
| &emsp;&emsp;weekdays                          | list(string) | Required    |               |                                                 |
| &emsp;&emsp;weeks                             | list(string) | Required    |               |                                                 |
| &emsp;retention_yearly                        | object       | Optional    |               |                                                 |
| &emsp;&emsp;count                             | number       | Required    |               |                                                 |
| &emsp;&emsp;weekdays                          | list(string) | Required    |               |                                                 |
| &emsp;&emsp;weeks                             | list(string) | Required    |               |                                                 |
| &emsp;&emsp;months                            | list(string) | Required    |               |                                                 |
| protected_vm                                  | list(object) | Optional    | []            |                                                 |
| &emsp;resource_group_name                     | string       | Optional    |               | If not provided, inherited from parent resource |
| &emsp;recovery_vault_name                     | string       | Optional    |               | Inherited from parent resource                  |
| &emsp;backup_policy_id                        | string       | Optional    |               | Inherited from parent resource                  |
| &emsp;source_vm_id                            | string       | Optional    |               |                                                 |
| &emsp;exclude_disk_luns                       | list(number) | Optional    |               |                                                 |
| &emsp;include_disk_luns                       | list(number) | Optional    |               |                                                 |
| private_endpoint                              | list(object) | Optional    | []            |                                                 |
| &emsp;name                                    | string       | Required    |               |                                                 |
| &emsp;resource_group_name                     | string       | Optional    |               | If not provided, inherited from parent resource |
| &emsp;location                                | string       | Optional    |               | If not provided, inherited from parent resource |
| &emsp;subnet_id                               | string       | Required    |               |                                                 |
| &emsp;private_service_connection              | list(object) | Required    | []            |                                                 |
| &emsp;&emsp;name                              | string       | Required    |               |                                                 |
| &emsp;&emsp;is_manual_connection              | bool         | Required    |               |                                                 |
| &emsp;&emsp;private_connection_resource_id    | string       | Optional    |               |                                                 |
| &emsp;&emsp;private_connection_resource_alias | string       | Optional    |               |                                                 |
| &emsp;&emsp;subresource_names                 | list(string) | Optional    |               |                                                 |
| &emsp;&emsp;request_message                   | string       | Optional    |               |                                                 |
| &emsp;custom_network_interface_name           | string       | Optional    |               |                                                 |
| &emsp;private_dns_zone_group                  | list(object) | Optional    | []            |                                                 |
| &emsp;&emsp;name                              | string       | Required    |               |                                                 |
| &emsp;&emsp;private_dns_zone_ids              | list(string) | Required    |               |                                                 |
| &emsp;ip_configuration                        | list(object) | Optional    | []            |                                                 |
| &emsp;&emsp;name                              | string       | Required    |               |                                                 |
| &emsp;&emsp;private_ip_address                | string       | Required    |               |                                                 |
| &emsp;&emsp;subresource_name                  | string       | Required    |               |                                                 |
| &emsp;&emsp;member_name                       | string       | Optional    |               |                                                 |
| &emsp;tags                                    | map(any)     | Optional    |               |                                                 |
| monitoring                                    | list(object) | Optional    | []            | Custom object for enabling diagnostic settings  |
| &emsp;diag_name                               | string       | Optional    |               | Name of the diagnostic setting                  |
| &emsp;log_analytics_workspace_id              | string       | Optional    |               |                                                 |
| &emsp;eventhub_name                           | string       | Optional    |               |                                                 |
| &emsp;eventhub_authorization_rule_id          | string       | Optional    |               | Event Hub namespace authorization rule          |
| tags                                          | map(any)     | Optional    |               |                                                 |
