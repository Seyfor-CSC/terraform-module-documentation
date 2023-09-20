# Variables

```
variable "config" {  type = list(object({
    # virtual machine
    os_type               = string # posible values: Linux, Windows
    name                  = string
    resource_group_name   = string
    location              = string
    admin_username        = string
    admin_password        = optional(string)
    network_interface_ids = optional(list(string)) # Inherited in module from network interface resource
    size                  = string
    os_disk = object({
      caching              = optional(string, "ReadWrite")
      storage_account_type = string
      diff_disk_settings = optional(object({
        option    = string
        placement = optional(string)
      }))
      disk_encryption_set_id           = optional(string)
      disk_size_gb                     = optional(number)
      name                             = optional(string) # If not provided, value is generated in the format of '<vm_name>-osdisk'
      secure_vm_disk_encryption_set_id = optional(string)
      security_encryption_type         = optional(string)
      write_accelerator_enabled        = optional(bool)

      # data protection backup instance disk
      disk_backup = optional(list(object({
        name                         = optional(string) # If not provided, inherited in module from parent resource
        location                     = optional(string) # Inherited in module from parent resource
        vault_id                     = string
        disk_id                      = optional(string) # Inherited in module from parent resource
        snapshot_resource_group_name = optional(string) # If not provided, inherited in module from parent resource
        backup_policy_id             = string
      })), [])
    })
    license_type = optional(string) # linux specific
    additional_capabilities = optional(object({
      ultra_ssd_enabled = optional(bool)
    }))
    admin_ssh_key = optional(list(object({ # linux specific
      public_key = string
      username   = string
    })), [])
    additional_unattend_content = optional(list(object({ # windows specific
      content = string
      setting = string
    })), [])
    allow_extension_operations = optional(bool)
    availability_set_id        = optional(string)
    boot_diagnostics = optional(object({
      storage_account_uri = optional(string)
    }))
    bypass_platform_safety_checks_on_user_schedule_enabled = optional(bool)
    capacity_reservation_group_id                          = optional(string)
    computer_name                                          = optional(string)
    custom_data                                            = optional(string)
    dedicated_host_id                                      = optional(string)
    dedicated_host_group_id                                = optional(string)
    disable_password_authentication                        = optional(bool) # linux specific
    edge_zone                                              = optional(string)
    enable_automatic_updates                               = optional(bool) # windows specific
    encryption_at_host_enabled                             = optional(bool)
    eviction_policy                                        = optional(string)
    extensions_time_budget                                 = optional(string)
    gallery_application = optional(list(object({
      version_id             = string
      configuration_blob_uri = optional(string)
      order                  = optional(number)
      tag                    = optional(string)
    })), [])
    hotpatching_enabled = optional(bool) # windows specific
    identity = optional(object({
      type         = string
      identity_ids = optional(list(string))
    }))
    license_type          = optional(string) # windows specific
    max_bid_price         = optional(number)
    patch_assessment_mode = optional(string)
    patch_mode            = optional(string)
    plan = optional(object({
      name      = string
      product   = string
      publisher = string
    }))
    platform_fault_domain        = optional(string)
    priority                     = optional(string)
    provision_vm_agent           = optional(bool)
    proximity_placement_group_id = optional(string)
    reboot_setting               = optional(string)
    secret = optional(list(object({
      certificate = list(object({
        store = optional(string) # Is required and supported only for windows
        url   = string
      }))
      key_vault_id = string
    })), [])
    secure_boot_enabled = optional(bool)
    source_image_id     = optional(string)
    source_image_reference = optional(object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    }))
    termination_notification = optional(object({
      enabled = bool
      timeout = optional(string)
    }))
    timezone                     = optional(string) # windows specific
    user_data                    = optional(string)
    virtual_machine_scale_set_id = optional(string)
    vtpm_enabled                 = optional(bool)
    winrm_listener = optional(list(object({ # windows specific
      protocol        = optional(string, "Https")
      certificate_url = optional(string)
    })), [])
    zone = optional(string)
    tags = optional(map(any))

    # network interface
    network_interfaces = list(object({
      name                = string
      resource_group_name = optional(string) # If not provided, inherited in module from parent resource
      location            = optional(string) # Inherited in module from parent resource
      ip_configuration = list(object({
        name                                               = string
        private_ip_address_allocation                      = optional(string, "Dynamic")
        gateway_load_balancer_frontend_ip_configuration_id = optional(string)
        subnet_id                                          = optional(string)
        private_ip_address_version                         = optional(string, "IPv4")
        public_ip_address_id                               = optional(string)
        primary                                            = optional(bool)
        private_ip_address                                 = optional(string)
      }))
      dns_servers                   = optional(list(string))
      edge_zone                     = optional(string)
      enable_ip_forwarding          = optional(bool)
      enable_accelerated_networking = optional(bool)
      internal_dns_name_label       = optional(string)
      tags                          = optional(map(any)) # Inherited in module from parent resource
    }))

    # managed disk
    managed_disks = optional(list(object({
      name                   = string
      resource_group_name    = optional(string) # If not provided, inherited in module from parent resource
      location               = optional(string) # Inherited in module from parent resource
      storage_account_type   = optional(string) # If not provided, inherited in module from parent resource
      create_option          = optional(string, "Empty")
      disk_encryption_set_id = optional(string)
      disk_iops_read_write   = optional(number)
      disk_mbps_read_write   = optional(number)
      disk_iops_read_only    = optional(number)
      disk_mbps_read_only    = optional(number)
      upload_size_bytes      = optional(number)
      disk_size_gb           = optional(number)
      edge_zone              = optional(string)
      encryption_settings = optional(object({
        disk_encryption_key = optional(object({
          secret_url      = string
          source_vault_id = string
        }))
        key_encryption_key = optional(object({
          key_url         = string
          source_vault_id = string
        }))
      }))
      hyper_v_generation               = optional(string)
      image_reference_id               = optional(string)
      gallery_image_reference_id       = optional(string)
      logical_sector_size              = optional(number)
      os_type                          = optional(string)
      source_resource_id               = optional(string)
      source_uri                       = optional(string)
      storage_account_id               = optional(string)
      tier                             = optional(string)
      max_shares                       = optional(number)
      trusted_launch_enabled           = optional(bool)
      security_type                    = optional(string)
      secure_vm_disk_encryption_set_id = optional(string)
      on_demand_bursting_enabled       = optional(bool)
      zone                             = optional(string) # Inherited in module from parent resource
      network_access_policy            = optional(string)
      disk_access_id                   = optional(string)
      public_network_access_enabled    = optional(bool, false)

      # data protection backup instance disk
      disk_backup = optional(list(object({
        name                         = optional(string) # If not provided, inherited in module from parent resource
        location                     = optional(string) # Inherited in module from parent resource
        vault_id                     = string
        disk_id                      = optional(string) # Inherited in module from parent resource
        snapshot_resource_group_name = optional(string) # If not provided, inherited in module from parent resource
        backup_policy_id             = string
      })), [])
      tags = optional(map(any)) # Inherited in module from parent resource

      # virtual machine data disk attachment
      disk_attachment = optional(list(object({
        virtual_machine_id        = optional(string) # Inherited in module from parent resource
        managed_disk_id           = optional(string) # Inherited in module from parent resource
        lun                       = number
        caching                   = optional(string, "ReadWrite")
        create_option             = optional(string, "Attach")
        write_accelerator_enabled = optional(bool)
      })), [])
    })), [])

    # monitor data collection rule association
    data_collection_rule_association = optional(list(object({
      target_resource_id          = optional(string) # Inherited in module from parent resource
      name                        = optional(string)
      data_collection_endpoint_id = optional(string)
      data_collection_rule_id     = optional(string)
      description                 = optional(string)
    })), [])

    # backup protected vm
    vm_backup = optional(list(object({
      resource_group_name = string
      recovery_vault_name = string
      backup_policy_id    = optional(string)
      source_vm_id        = optional(string) # Inherited in module from parent resource
      exclude_disk_luns   = optional(list(number))
      include_disk_luns   = optional(list(number))
      protection_state    = optional(string)
    })), [])

    # virtual machine extension
    vm_extensions = optional(list(object({
      name                        = string
      virtual_machine_id          = optional(string) # Inherited in module from parent resource
      publisher                   = string
      type                        = string
      type_handler_version        = string
      auto_upgrade_minor_version  = optional(bool)
      automatic_upgrade_enabled   = optional(bool)
      settings                    = optional(string)
      failure_suppression_enabled = optional(bool)
      protected_settings          = optional(string)
      protected_settings_from_key_vault = optional(object({
        secret_url      = string
        source_vault_id = string
      }))
      tags = optional(map(any)) # Inherited in module from parent resource
    })), [])
  }))
}


```


## Table with config variables

| Name | Data Type | Requirement | Default Value | Comment |
| ------- | --------- | ----------- | ------------- | ------- |
|os_type | string | Required |  |  posible values: Linux, Windows |
|name | string | Required |  |  |
|resource_group_name | string | Required |  |  |
|location | string | Required |  |  |
|admin_username | string | Required |  |  |
|admin_password | string | Optional |  |  |
|network_interface_ids | list(string) | Optional |  |  Inherited in module from network interface resource |
|size | string | Required |  |  |
|os_disk | object | Required |  |  |
|&nbsp;caching | string | Optional |  "ReadWrite" |  |
|&nbsp;storage_account_type | string | Required |  |  |
|&nbsp;diff_disk_settings | object | Optional |  |  |
|&nbsp;&nbsp;option | string | Required |  |  |
|&nbsp;&nbsp;placement | string | Optional |  |  |
|&nbsp;disk_encryption_set_id | string | Optional |  |  |
|&nbsp;disk_size_gb | number | Optional |  |  |
|&nbsp;name | string | Optional |  |  If not provided, value is generated in the format of '<vm_name>-osdisk' |
|&nbsp;secure_vm_disk_encryption_set_id | string | Optional |  |  |
|&nbsp;security_encryption_type | string | Optional |  |  |
|&nbsp;write_accelerator_enabled | bool | Optional |  |  |
|&nbsp;disk_backup | list(object) | Optional | [] |  |
|&nbsp;&nbsp;name | string | Optional |  |  If not provided, inherited in module from parent resource |
|&nbsp;&nbsp;location | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;&nbsp;vault_id | string | Required |  |  |
|&nbsp;&nbsp;disk_id | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;&nbsp;snapshot_resource_group_name | string | Optional |  |  If not provided, inherited in module from parent resource |
|&nbsp;&nbsp;backup_policy_id | string | Required |  |  |
|license_type | string | Optional |  |  linux specific |
|additional_capabilities | object | Optional |  |  |
|&nbsp;ultra_ssd_enabled | bool | Optional |  |  |
|admin_ssh_key | list(object) | Optional | [] |  linux specific |
|&nbsp;public_key | string | Required |  |  |
|&nbsp;username | string | Required |  |  |
|additional_unattend_content | list(object) | Optional | [] |  windows specific |
|&nbsp;content | string | Required |  |  |
|&nbsp;setting | string | Required |  |  |
|allow_extension_operations | bool | Optional |  |  |
|availability_set_id | string | Optional |  |  |
|boot_diagnostics | object | Optional |  |  |
|&nbsp;storage_account_uri | string | Optional |  |  |
|bypass_platform_safety_checks_on_user_schedule_enabled | bool | Optional |  |  |
|capacity_reservation_group_id | string | Optional |  |  |
|computer_name | string | Optional |  |  |
|custom_data | string | Optional |  |  |
|dedicated_host_id | string | Optional |  |  |
|dedicated_host_group_id | string | Optional |  |  |
|disable_password_authentication | bool | Optional |  |  linux specific |
|edge_zone | string | Optional |  |  |
|enable_automatic_updates | bool | Optional |  |  windows specific |
|encryption_at_host_enabled | bool | Optional |  |  |
|eviction_policy | string | Optional |  |  |
|extensions_time_budget | string | Optional |  |  |
|gallery_application | list(object) | Optional | [] |  |
|&nbsp;version_id | string | Required |  |  |
|&nbsp;configuration_blob_uri | string | Optional |  |  |
|&nbsp;order | number | Optional |  |  |
|&nbsp;tag | string | Optional |  |  |
|hotpatching_enabled | bool | Optional |  |  windows specific |
|identity | object | Optional |  |  |
|&nbsp;type | string | Required |  |  |
|&nbsp;identity_ids | list(string) | Optional |  |  |
|license_type | string | Optional |  |  windows specific |
|max_bid_price | number | Optional |  |  |
|patch_assessment_mode | string | Optional |  |  |
|patch_mode | string | Optional |  |  |
|plan | object | Optional |  |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;product | string | Required |  |  |
|&nbsp;publisher | string | Required |  |  |
|platform_fault_domain | string | Optional |  |  |
|priority | string | Optional |  |  |
|provision_vm_agent | bool | Optional |  |  |
|proximity_placement_group_id | string | Optional |  |  |
|reboot_setting | string | Optional |  |  |
|secret | list(object) | Optional | [] |  |
|&nbsp;certificate | list(object) | Required |  |  |
|&nbsp;&nbsp;store | string | Optional |  |  Is required and supported only for windows |
|&nbsp;&nbsp;url | string | Required |  |  |
|&nbsp;key_vault_id | string | Required |  |  |
|secure_boot_enabled | bool | Optional |  |  |
|source_image_id | string | Optional |  |  |
|source_image_reference | object | Optional |  |  |
|&nbsp;publisher | string | Required |  |  |
|&nbsp;offer | string | Required |  |  |
|&nbsp;sku | string | Required |  |  |
|&nbsp;version | string | Required |  |  |
|termination_notification | object | Optional |  |  |
|&nbsp;enabled | bool | Required |  |  |
|&nbsp;timeout | string | Optional |  |  |
|timezone | string | Optional |  |  windows specific |
|user_data | string | Optional |  |  |
|virtual_machine_scale_set_id | string | Optional |  |  |
|vtpm_enabled | bool | Optional |  |  |
|winrm_listener | list(object) | Optional | [] |  windows specific |
|&nbsp;protocol | string | Optional |  "Https" |  |
|&nbsp;certificate_url | string | Optional |  |  |
|zone | string | Optional |  |  |
|tags | map(any) | Optional |  |  |
|network_interfaces | list(object) | Required |  |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;resource_group_name | string | Optional |  |  If not provided, inherited in module from parent resource |
|&nbsp;location | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;ip_configuration | list(object) | Required |  |  |
|&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;private_ip_address_allocation | string | Optional |  "Dynamic" |  |
|&nbsp;&nbsp;gateway_load_balancer_frontend_ip_configuration_id | string | Optional |  |  |
|&nbsp;&nbsp;subnet_id | string | Optional |  |  |
|&nbsp;&nbsp;private_ip_address_version | string | Optional |  "IPv4" |  |
|&nbsp;&nbsp;public_ip_address_id | string | Optional |  |  |
|&nbsp;&nbsp;primary | bool | Optional |  |  |
|&nbsp;&nbsp;private_ip_address | string | Optional |  |  |
|&nbsp;dns_servers | list(string) | Optional |  |  |
|&nbsp;edge_zone | string | Optional |  |  |
|&nbsp;enable_ip_forwarding | bool | Optional |  |  |
|&nbsp;enable_accelerated_networking | bool | Optional |  |  |
|&nbsp;internal_dns_name_label | string | Optional |  |  |
|&nbsp;tags | map(any) | Optional |  |  Inherited in module from parent resource |
|managed_disks | list(object) | Optional | [] |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;resource_group_name | string | Optional |  |  If not provided, inherited in module from parent resource |
|&nbsp;location | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;storage_account_type | string | Optional |  |  If not provided, inherited in module from parent resource |
|&nbsp;create_option | string | Optional |  "Empty" |  |
|&nbsp;disk_encryption_set_id | string | Optional |  |  |
|&nbsp;disk_iops_read_write | number | Optional |  |  |
|&nbsp;disk_mbps_read_write | number | Optional |  |  |
|&nbsp;disk_iops_read_only | number | Optional |  |  |
|&nbsp;disk_mbps_read_only | number | Optional |  |  |
|&nbsp;upload_size_bytes | number | Optional |  |  |
|&nbsp;disk_size_gb | number | Optional |  |  |
|&nbsp;edge_zone | string | Optional |  |  |
|&nbsp;encryption_settings | object | Optional |  |  |
|&nbsp;&nbsp;disk_encryption_key | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;secret_url | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;source_vault_id | string | Required |  |  |
|&nbsp;&nbsp;key_encryption_key | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;key_url | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;source_vault_id | string | Required |  |  |
|&nbsp;hyper_v_generation | string | Optional |  |  |
|&nbsp;image_reference_id | string | Optional |  |  |
|&nbsp;gallery_image_reference_id | string | Optional |  |  |
|&nbsp;logical_sector_size | number | Optional |  |  |
|&nbsp;os_type | string | Optional |  |  |
|&nbsp;source_resource_id | string | Optional |  |  |
|&nbsp;source_uri | string | Optional |  |  |
|&nbsp;storage_account_id | string | Optional |  |  |
|&nbsp;tier | string | Optional |  |  |
|&nbsp;max_shares | number | Optional |  |  |
|&nbsp;trusted_launch_enabled | bool | Optional |  |  |
|&nbsp;security_type | string | Optional |  |  |
|&nbsp;secure_vm_disk_encryption_set_id | string | Optional |  |  |
|&nbsp;on_demand_bursting_enabled | bool | Optional |  |  |
|&nbsp;zone | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;network_access_policy | string | Optional |  |  |
|&nbsp;disk_access_id | string | Optional |  |  |
|&nbsp;public_network_access_enabled | bool | Optional |  false |  |
|&nbsp;disk_backup | list(object) | Optional | [] |  |
|&nbsp;&nbsp;name | string | Optional |  |  If not provided, inherited in module from parent resource |
|&nbsp;&nbsp;location | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;&nbsp;vault_id | string | Required |  |  |
|&nbsp;&nbsp;disk_id | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;&nbsp;snapshot_resource_group_name | string | Optional |  |  If not provided, inherited in module from parent resource |
|&nbsp;&nbsp;backup_policy_id | string | Required |  |  |
|&nbsp;tags | map(any) | Optional |  |  Inherited in module from parent resource |
|&nbsp;disk_attachment | list(object) | Optional | [] |  |
|&nbsp;&nbsp;virtual_machine_id | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;&nbsp;managed_disk_id | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;&nbsp;lun | number | Required |  |  |
|&nbsp;&nbsp;caching | string | Optional |  "ReadWrite" |  |
|&nbsp;&nbsp;create_option | string | Optional |  "Attach" |  |
|&nbsp;&nbsp;write_accelerator_enabled | bool | Optional |  |  |
|data_collection_rule_association | list(object) | Optional | [] |  |
|&nbsp;target_resource_id | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;name | string | Optional |  |  |
|&nbsp;data_collection_endpoint_id | string | Optional |  |  |
|&nbsp;data_collection_rule_id | string | Optional |  |  |
|&nbsp;description | string | Optional |  |  |
|vm_backup | list(object) | Optional | [] |  |
|&nbsp;resource_group_name | string | Required |  |  |
|&nbsp;recovery_vault_name | string | Required |  |  |
|&nbsp;backup_policy_id | string | Optional |  |  |
|&nbsp;source_vm_id | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;exclude_disk_luns | list(number) | Optional |  |  |
|&nbsp;include_disk_luns | list(number) | Optional |  |  |
|&nbsp;protection_state | string | Optional |  |  |
|vm_extensions | list(object) | Optional | [] |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;virtual_machine_id | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;publisher | string | Required |  |  |
|&nbsp;type | string | Required |  |  |
|&nbsp;type_handler_version | string | Required |  |  |
|&nbsp;auto_upgrade_minor_version | bool | Optional |  |  |
|&nbsp;automatic_upgrade_enabled | bool | Optional |  |  |
|&nbsp;settings | string | Optional |  |  |
|&nbsp;failure_suppression_enabled | bool | Optional |  |  |
|&nbsp;protected_settings | string | Optional |  |  |
|&nbsp;protected_settings_from_key_vault | object | Optional |  |  |
|&nbsp;&nbsp;secret_url | string | Required |  |  |
|&nbsp;&nbsp;source_vault_id | string | Required |  |  |
|&nbsp;tags | map(any) | Optional |  |  Inherited in module from parent resource |

