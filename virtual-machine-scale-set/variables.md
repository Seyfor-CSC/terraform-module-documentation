# Variables

```
variable "config" {  type = list(object({
    # virtual machine scale set
    name                = string
    resource_group_name = string
    location            = string
    autoscale           = optional(bool, false) # Custom variable to enable autoscaling
    os_type             = string                # "Linux" or "Windows"
    admin_password      = optional(string)      # Required for windows
    admin_username      = string
    instances           = optional(number, 0)
    sku                 = string
    network_interface = list(object({
      name = string
      ip_configuration = list(object({
        name                                         = string
        application_gateway_backend_address_pool_ids = optional(list(string))
        application_security_group_ids               = optional(list(string))
        load_balancer_backend_address_pool_ids       = optional(list(string))
        load_balancer_inbound_nat_rules_ids          = optional(list(string))
        primary                                      = optional(bool)
        public_ip_address = optional(object({
          name                    = string
          domain_name_label       = optional(string)
          idle_timeout_in_minutes = optional(number)
          ip_tag = optional(list(object({
            tag  = string
            type = string
          })), [])
          public_ip_prefix_id = optional(string)
          version             = optional(string)
        }))
        subnet_id = optional(string)
        version   = optional(string)
      }))
      auxiliary_mode                = optional(string)
      auxiliary_sku                 = optional(string)
      dns_servers                   = optional(list(string))
      enable_accelerated_networking = optional(bool)
      enable_ip_forwarding          = optional(bool)
      network_security_group_id     = optional(string)
      primary                       = optional(bool)
    }))
    os_disk = object({
      caching              = string
      storage_account_type = string
      diff_disk_settings = optional(object({
        option    = string
        placement = optional(string)
      }))
      disk_encryption_set_id           = optional(string)
      disk_size_gb                     = optional(number)
      secure_vm_disk_encryption_set_id = optional(string)
      security_encryption_type         = optional(string)
      write_accelerator_enabled        = optional(bool)
    })
    additional_capabilities = optional(object({
      ultra_ssd_enabled = optional(bool)
    }))
    admin_ssh_key = optional(list(object({ # linux only
      public_key = string
      username   = string
    })), [])
    additional_unattend_content = optional(list(object({ # windows only
      content = string
      setting = string
    })), [])
    automatic_os_upgrade_policy = optional(object({
      disable_automatic_rollback  = bool
      enable_automatic_os_upgrade = bool
    }))
    automatic_instance_repair = optional(object({
      enabled      = bool
      grace_period = optional(string)
      action       = optional(string)
    }))
    boot_diagnostics = optional(object({
      storage_account_uri = optional(string)
    }))
    capacity_reservation_group_id = optional(string)
    computer_name_prefix          = optional(string)
    custom_data                   = optional(string)
    data_disk = optional(list(object({
      name                           = optional(string)
      caching                        = string
      create_option                  = optional(string)
      disk_size_gb                   = number
      lun                            = number
      storage_account_type           = string
      disk_encryption_set_id         = optional(string)
      ultra_ssd_disk_iops_read_write = optional(number)
      ultra_ssd_disk_mbps_read_write = optional(number)
      write_accelerator_enabled      = optional(bool)
    })), [])
    disable_password_authentication                   = optional(bool) # linux only
    do_not_run_extensions_on_overprovisioned_machines = optional(bool)
    edge_zone                                         = optional(string)
    enable_automatic_updates                          = optional(bool) # windows only
    encryption_at_host_enabled                        = optional(bool)
    extension = optional(list(object({
      name                       = string
      publisher                  = string
      type                       = string
      type_handler_version       = string
      auto_upgrade_minor_version = optional(bool)
      automatic_upgrade_enabled  = optional(bool)
      force_update_tag           = optional(string)
      protected_settings         = optional(string)
      protected_settings_from_key_vault = optional(object({
        secret_url      = string
        source_vault_id = string
      }))
      provision_after_extensions = optional(list(string))
      settings                   = optional(string)
    })), [])
    extension_operations_enabled = optional(bool)
    extensions_time_budget       = optional(string)
    eviction_policy              = optional(string)
    gallery_application = optional(list(object({
      version_id             = string
      configuration_blob_uri = optional(string)
      order                  = optional(number)
      tag                    = optional(string)
    })), [])
    health_probe_id = optional(string)
    host_group_id   = optional(string)
    identity = optional(object({
      type         = string
      identity_ids = optional(list(string))
    }))
    license_type  = optional(string) # windows only
    max_bid_price = optional(number)
    overprovision = optional(bool)
    plan = optional(object({
      name      = string
      publisher = string
      product   = string
    }))
    platform_fault_domain_count  = optional(number)
    priority                     = optional(string)
    provision_vm_agent           = optional(bool)
    proximity_placement_group_id = optional(string)
    rolling_upgrade_policy = optional(object({
      cross_zone_upgrades_enabled             = optional(bool)
      max_batch_instance_percent              = number
      max_unhealthy_instance_percent          = number
      max_unhealthy_upgraded_instance_percent = number
      pause_time_between_batches              = string
      prioritize_unhealthy_instances_enabled  = optional(bool)
      maximum_surge_instances_enabled         = optional(bool)
    }))
    scale_in = optional(object({
      rule                   = optional(string)
      force_deletion_enabled = optional(bool)
    }))
    secret = optional(list(object({
      certificate = list(object({
        store = optional(string) # Is required and supported only for windows
        url   = string
      }))
      key_vault_id = string
    })), [])
    secure_boot_enabled    = optional(bool)
    single_placement_group = optional(bool)
    source_image_id        = optional(string)
    source_image_reference = optional(object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    }))
    spot_restore = optional(object({
      enabled = optional(bool)
      timeout = optional(string)
    }))
    termination_notification = optional(object({
      enabled = bool
      timeout = optional(string)
    }))
    resilient_vm_creation_enabled = optional(bool)
    resilient_vm_deletion_enabled = optional(bool)
    timezone                      = optional(string) # windows only
    upgrade_mode                  = optional(string)
    user_data                     = optional(string)
    vtpm_enabled                  = optional(bool)
    winrm_listener = optional(list(object({ # windows only
      certificate_url = optional(string)
      protocol        = string
    })), [])
    zone_balance = optional(bool)
    zones        = optional(list(number))
    tags         = optional(map(any))

    # monitor autoscale setting
    autoscale_settings = optional(object({
      name                = string
      resource_group_name = optional(string) # If not provided, inherited in module from parent resource
      location            = optional(string) # Inherited in module from parent resource
      target_resource_id  = optional(string) # Inherited in module from parent resource
      profile = list(object({
        name = string
        capacity = object({
          default = number
          maximum = number
          minimum = number
        })
        rule = optional(list(object({
          metric_trigger = object({
            metric_name        = string
            metric_resource_id = optional(string) # If not provided, inherited in module from parent resource
            operator           = string
            statistic          = string
            time_aggregation   = string
            time_grain         = string
            time_window        = string
            threshold          = number
            metric_namespace   = optional(string)
            dimensions = optional(list(object({
              name     = string
              operator = string
              values   = list(string)
            })), [])
            divide_by_instance_count = optional(bool)
          })
          scale_action = object({
            cooldown  = string
            direction = string
            type      = string
            value     = string
          })
        })), [])
        fixed_date = optional(object({
          end       = string
          start     = string
          time_zone = optional(string)
        }))
        recurrence = optional(object({
          timezone = optional(string)
          days     = list(string)
          hours    = list(number)
          minutes  = list(number)
        }))
      }))
      enabled = optional(bool)
      notification = optional(object({
        email = optional(object({
          send_to_subscription_administrator    = optional(bool)
          send_to_subscription_co_administrator = optional(bool)
          custom_emails                         = optional(list(string))
        }))
        webhook = optional(list(object({
          service_uri = string
          properties  = optional(map(string))
        })), [])
      }))
      predictive = optional(object({
        scale_mode      = string
        look_ahead_time = optional(string)
      }))
      tags = optional(map(any))

      # monitoring
      monitoring = optional(list(object({                 # Custom object for enabling diagnostic settings. Available only for scale sets with azurerm_monitor_autoscale_setting configured
        diag_name                      = optional(string) # Name of the diagnostic setting
        log_analytics_workspace_id     = optional(string)
        eventhub_name                  = optional(string)
        eventhub_authorization_rule_id = optional(string)
        storage_account_id             = optional(string)
        categories = optional(object({
          autoscale_evaluations   = optional(bool, true)
          autoscale_scale_actions = optional(bool, true)
          all_metrics             = optional(bool, true)
        }))
      })), [])
    }))
  }))
}


```


## Table with config variables

| Name | Data Type | Requirement | Default Value | Comment |
| ------- | --------- | ----------- | ------------- | ------- |
|name | string | Required |  |  |
|resource_group_name | string | Required |  |  |
|location | string | Required |  |  |
|autoscale | bool | Optional |  false |  Custom variable to enable autoscaling |
|os_type | string | Required |  |  "Linux" or "Windows" |
|admin_password | string | Optional |  |  Required for windows |
|admin_username | string | Required |  |  |
|instances | number | Optional |  0 |  |
|sku | string | Required |  |  |
|network_interface | list(object) | Required |  |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;ip_configuration | list(object) | Required |  |  |
|&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;application_gateway_backend_address_pool_ids | list(string) | Optional |  |  |
|&nbsp;&nbsp;application_security_group_ids | list(string) | Optional |  |  |
|&nbsp;&nbsp;load_balancer_backend_address_pool_ids | list(string) | Optional |  |  |
|&nbsp;&nbsp;load_balancer_inbound_nat_rules_ids | list(string) | Optional |  |  |
|&nbsp;&nbsp;primary | bool | Optional |  |  |
|&nbsp;&nbsp;public_ip_address | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;domain_name_label | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;idle_timeout_in_minutes | number | Optional |  |  |
|&nbsp;&nbsp;&nbsp;ip_tag | list(object) | Optional | [] |  |
|&nbsp;&nbsp;&nbsp;&nbsp;tag | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;type | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;public_ip_prefix_id | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;version | string | Optional |  |  |
|&nbsp;&nbsp;subnet_id | string | Optional |  |  |
|&nbsp;&nbsp;version | string | Optional |  |  |
|&nbsp;auxiliary_mode | string | Optional |  |  |
|&nbsp;auxiliary_sku | string | Optional |  |  |
|&nbsp;dns_servers | list(string) | Optional |  |  |
|&nbsp;enable_accelerated_networking | bool | Optional |  |  |
|&nbsp;enable_ip_forwarding | bool | Optional |  |  |
|&nbsp;network_security_group_id | string | Optional |  |  |
|&nbsp;primary | bool | Optional |  |  |
|os_disk | object | Required |  |  |
|&nbsp;caching | string | Required |  |  |
|&nbsp;storage_account_type | string | Required |  |  |
|&nbsp;diff_disk_settings | object | Optional |  |  |
|&nbsp;&nbsp;option | string | Required |  |  |
|&nbsp;&nbsp;placement | string | Optional |  |  |
|&nbsp;disk_encryption_set_id | string | Optional |  |  |
|&nbsp;disk_size_gb | number | Optional |  |  |
|&nbsp;secure_vm_disk_encryption_set_id | string | Optional |  |  |
|&nbsp;security_encryption_type | string | Optional |  |  |
|&nbsp;write_accelerator_enabled | bool | Optional |  |  |
|additional_capabilities | object | Optional |  |  |
|&nbsp;ultra_ssd_enabled | bool | Optional |  |  |
|admin_ssh_key | list(object) | Optional | [] |  linux only |
|&nbsp;public_key | string | Required |  |  |
|&nbsp;username | string | Required |  |  |
|additional_unattend_content | list(object) | Optional | [] |  windows only |
|&nbsp;content | string | Required |  |  |
|&nbsp;setting | string | Required |  |  |
|automatic_os_upgrade_policy | object | Optional |  |  |
|&nbsp;disable_automatic_rollback | bool | Required |  |  |
|&nbsp;enable_automatic_os_upgrade | bool | Required |  |  |
|automatic_instance_repair | object | Optional |  |  |
|&nbsp;enabled | bool | Required |  |  |
|&nbsp;grace_period | string | Optional |  |  |
|&nbsp;action | string | Optional |  |  |
|boot_diagnostics | object | Optional |  |  |
|&nbsp;storage_account_uri | string | Optional |  |  |
|capacity_reservation_group_id | string | Optional |  |  |
|computer_name_prefix | string | Optional |  |  |
|custom_data | string | Optional |  |  |
|data_disk | list(object) | Optional | [] |  |
|&nbsp;name | string | Optional |  |  |
|&nbsp;caching | string | Required |  |  |
|&nbsp;create_option | string | Optional |  |  |
|&nbsp;disk_size_gb | number | Required |  |  |
|&nbsp;lun | number | Required |  |  |
|&nbsp;storage_account_type | string | Required |  |  |
|&nbsp;disk_encryption_set_id | string | Optional |  |  |
|&nbsp;ultra_ssd_disk_iops_read_write | number | Optional |  |  |
|&nbsp;ultra_ssd_disk_mbps_read_write | number | Optional |  |  |
|&nbsp;write_accelerator_enabled | bool | Optional |  |  |
|disable_password_authentication | bool | Optional |  |  linux only |
|do_not_run_extensions_on_overprovisioned_machines | bool | Optional |  |  |
|edge_zone | string | Optional |  |  |
|enable_automatic_updates | bool | Optional |  |  windows only |
|encryption_at_host_enabled | bool | Optional |  |  |
|extension | list(object) | Optional | [] |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;publisher | string | Required |  |  |
|&nbsp;type | string | Required |  |  |
|&nbsp;type_handler_version | string | Required |  |  |
|&nbsp;auto_upgrade_minor_version | bool | Optional |  |  |
|&nbsp;automatic_upgrade_enabled | bool | Optional |  |  |
|&nbsp;force_update_tag | string | Optional |  |  |
|&nbsp;protected_settings | string | Optional |  |  |
|&nbsp;protected_settings_from_key_vault | object | Optional |  |  |
|&nbsp;&nbsp;secret_url | string | Required |  |  |
|&nbsp;&nbsp;source_vault_id | string | Required |  |  |
|&nbsp;provision_after_extensions | list(string) | Optional |  |  |
|&nbsp;settings | string | Optional |  |  |
|extension_operations_enabled | bool | Optional |  |  |
|extensions_time_budget | string | Optional |  |  |
|eviction_policy | string | Optional |  |  |
|gallery_application | list(object) | Optional | [] |  |
|&nbsp;version_id | string | Required |  |  |
|&nbsp;configuration_blob_uri | string | Optional |  |  |
|&nbsp;order | number | Optional |  |  |
|&nbsp;tag | string | Optional |  |  |
|health_probe_id | string | Optional |  |  |
|host_group_id | string | Optional |  |  |
|identity | object | Optional |  |  |
|&nbsp;type | string | Required |  |  |
|&nbsp;identity_ids | list(string) | Optional |  |  |
|license_type | string | Optional |  |  windows only |
|max_bid_price | number | Optional |  |  |
|overprovision | bool | Optional |  |  |
|plan | object | Optional |  |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;publisher | string | Required |  |  |
|&nbsp;product | string | Required |  |  |
|platform_fault_domain_count | number | Optional |  |  |
|priority | string | Optional |  |  |
|provision_vm_agent | bool | Optional |  |  |
|proximity_placement_group_id | string | Optional |  |  |
|rolling_upgrade_policy | object | Optional |  |  |
|&nbsp;cross_zone_upgrades_enabled | bool | Optional |  |  |
|&nbsp;max_batch_instance_percent | number | Required |  |  |
|&nbsp;max_unhealthy_instance_percent | number | Required |  |  |
|&nbsp;max_unhealthy_upgraded_instance_percent | number | Required |  |  |
|&nbsp;pause_time_between_batches | string | Required |  |  |
|&nbsp;prioritize_unhealthy_instances_enabled | bool | Optional |  |  |
|&nbsp;maximum_surge_instances_enabled | bool | Optional |  |  |
|scale_in | object | Optional |  |  |
|&nbsp;rule | string | Optional |  |  |
|&nbsp;force_deletion_enabled | bool | Optional |  |  |
|secret | list(object) | Optional | [] |  |
|&nbsp;certificate | list(object) | Required |  |  |
|&nbsp;&nbsp;store | string | Optional |  |  Is required and supported only for windows |
|&nbsp;&nbsp;url | string | Required |  |  |
|&nbsp;key_vault_id | string | Required |  |  |
|secure_boot_enabled | bool | Optional |  |  |
|single_placement_group | bool | Optional |  |  |
|source_image_id | string | Optional |  |  |
|source_image_reference | object | Optional |  |  |
|&nbsp;publisher | string | Required |  |  |
|&nbsp;offer | string | Required |  |  |
|&nbsp;sku | string | Required |  |  |
|&nbsp;version | string | Required |  |  |
|spot_restore | object | Optional |  |  |
|&nbsp;enabled | bool | Optional |  |  |
|&nbsp;timeout | string | Optional |  |  |
|termination_notification | object | Optional |  |  |
|&nbsp;enabled | bool | Required |  |  |
|&nbsp;timeout | string | Optional |  |  |
|resilient_vm_creation_enabled | bool | Optional |  |  |
|resilient_vm_deletion_enabled | bool | Optional |  |  |
|timezone | string | Optional |  |  windows only |
|upgrade_mode | string | Optional |  |  |
|user_data | string | Optional |  |  |
|vtpm_enabled | bool | Optional |  |  |
|winrm_listener | list(object) | Optional | [] |  windows only |
|&nbsp;certificate_url | string | Optional |  |  |
|&nbsp;protocol | string | Required |  |  |
|zone_balance | bool | Optional |  |  |
|zones | list(number) | Optional |  |  |
|tags | map(any) | Optional |  |  |
|autoscale_settings | object | Optional |  |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;resource_group_name | string | Optional |  |  If not provided, inherited in module from parent resource |
|&nbsp;location | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;target_resource_id | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;profile | list(object) | Required |  |  |
|&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;capacity | object | Required |  |  |
|&nbsp;&nbsp;&nbsp;default | number | Required |  |  |
|&nbsp;&nbsp;&nbsp;maximum | number | Required |  |  |
|&nbsp;&nbsp;&nbsp;minimum | number | Required |  |  |
|&nbsp;&nbsp;rule | list(object) | Optional | [] |  |
|&nbsp;&nbsp;&nbsp;metric_trigger | object | Required |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;metric_name | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;metric_resource_id | string | Optional |  |  If not provided, inherited in module from parent resource |
|&nbsp;&nbsp;&nbsp;&nbsp;operator | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;statistic | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;time_aggregation | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;time_grain | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;time_window | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;threshold | number | Required |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;metric_namespace | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;dimensions | list(object) | Optional | [] |  |
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;operator | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;values | list(string) | Required |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;divide_by_instance_count | bool | Optional |  |  |
|&nbsp;&nbsp;&nbsp;scale_action | object | Required |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;cooldown | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;direction | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;type | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;value | string | Required |  |  |
|&nbsp;&nbsp;fixed_date | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;end | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;start | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;time_zone | string | Optional |  |  |
|&nbsp;&nbsp;recurrence | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;timezone | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;days | list(string) | Required |  |  |
|&nbsp;&nbsp;&nbsp;hours | list(number) | Required |  |  |
|&nbsp;&nbsp;&nbsp;minutes | list(number) | Required |  |  |
|&nbsp;enabled | bool | Optional |  |  |
|&nbsp;notification | object | Optional |  |  |
|&nbsp;&nbsp;email | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;send_to_subscription_administrator | bool | Optional |  |  |
|&nbsp;&nbsp;&nbsp;send_to_subscription_co_administrator | bool | Optional |  |  |
|&nbsp;&nbsp;&nbsp;custom_emails | list(string) | Optional |  |  |
|&nbsp;&nbsp;webhook | list(object) | Optional | [] |  |
|&nbsp;&nbsp;&nbsp;service_uri | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;properties | map(string) | Optional |  |  |
|&nbsp;predictive | object | Optional |  |  |
|&nbsp;&nbsp;scale_mode | string | Required |  |  |
|&nbsp;&nbsp;look_ahead_time | string | Optional |  |  |
|&nbsp;tags | map(any) | Optional |  |  |
|&nbsp;monitoring | list(object) | Optional | [] |  Custom object for enabling diagnostic settings. Available only for scale sets with azurerm_monitor_autoscale_setting configured |
|&nbsp;&nbsp;diag_name | string | Optional |  |  Name of the diagnostic setting |
|&nbsp;&nbsp;log_analytics_workspace_id | string | Optional |  |  |
|&nbsp;&nbsp;eventhub_name | string | Optional |  |  |
|&nbsp;&nbsp;eventhub_authorization_rule_id | string | Optional |  |  |
|&nbsp;&nbsp;storage_account_id | string | Optional |  |  |
|&nbsp;&nbsp;categories | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;autoscale_evaluations | bool | Optional |  true |  |
|&nbsp;&nbsp;&nbsp;autoscale_scale_actions | bool | Optional |  true |  |
|&nbsp;&nbsp;&nbsp;all_metrics | bool | Optional |  true |  |


