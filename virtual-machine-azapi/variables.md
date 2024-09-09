# Variables

```
variable "config" {  type = list(object({
    # virtual machine (AzAPI)
    name                = string
    location            = string
    resource_group_name = string # Custom parameter used for AzureRM provider resources
    parent_id           = string
    tags                = optional(map(any))
    identity = optional(object({
      type         = optional(string)
      identity_ids = optional(list(string))
    }))
    properties = object({
      additionalCapabilities = optional(object({
        hibernationEnabled = optional(bool)
        ultraSSDEnabled    = optional(bool)
      }))
      applicationProfile = optional(object({
        galleryApplications = optional(list(object({
          configurationReference          = optional(string)
          enableAutomaticUpgrade          = optional(bool)
          order                           = optional(number)
          packageReferenceId              = optional(string)
          tags                            = optional(string)
          treatFailureAsDeploymentFailure = optional(bool)
        })))
      }))
      availabilitySet = optional(object({
        id = optional(string)
      }))
      billingProfile = optional(object({
        maxPrice = optional(string)
      }))
      capacityReservation = optional(object({
        capacityReservationGroup = optional(object({
          id = optional(string)
        }))
      }))
      diagnosticsProfile = optional(object({
        bootDiagnostics = optional(object({
          enabled    = optional(bool)
          storageUri = optional(string)
        }))
      }))
      evictionPolicy       = optional(string)
      extensionsTimeBudget = optional(string)
      hardwareProfile = object({
        vmSize = string
        vmSizeProperties = optional(object({
          vCPUsAvailable = optional(number)
          vCPUsPerCore   = optional(number)
        }))
      })
      host = optional(object({
        id = optional(string)
      }))
      hostGroup = optional(object({
        id = optional(string)
      }))
      licenseType = optional(string)
      osProfile = optional(object({
        adminPassword            = optional(string)
        adminUsername            = optional(string)
        computerName             = optional(string)
        allowExtensionOperations = optional(bool)
        customData               = optional(string)
        linuxConfiguration = optional(object({
          disablePasswordAuthentication = optional(bool)
          enableVMAgentPlatformUpdates  = optional(bool)
          patchSettings = optional(object({
            assessmentMode = optional(string)
            automaticByPlatformSettings = optional(object({
              bypassPlatformSafetyChecksOnUserSchedule = optional(bool)
              rebootSetting                            = optional(string)
            }))
            patchMode = optional(string)
          }))
          provisionVMAgent = optional(bool)
          ssh = optional(object({
            publicKeys = optional(list(object({
              keyData = optional(string)
              path    = optional(string)
            })))
          }))
        }))
        requireGuestProvisionSignal = optional(bool)
        secrets = optional(list(object({
          sourceVault = optional(object({
            id = optional(string)
          }))
          vaultCertificates = optional(list(object({
            certificateStore = optional(string)
            certificateUrl   = optional(string)
          })))
        })))
        windowsConfiguration = optional(object({
          additionalUnattendContent = optional(list(object({
            componentName = optional(string)
            content       = optional(string)
            passName      = optional(string)
            settingName   = optional(string)
          })))
          enableAutomaticUpdates       = optional(bool)
          enableVMAgentPlatformUpdates = optional(bool)
          patchSettings = optional(object({
            assessmentMode = optional(string)
            automaticByPlatformSettings = optional(object({
              bypassPlatformSafetyChecksOnUserSchedule = optional(bool)
              rebootSetting                            = optional(string)
            }))
            enableHotpatching = optional(bool)
            patchMode         = optional(string)
          }))
          provisionVMAgent = optional(bool)
          timeZone         = optional(string)
          winRM = optional(object({
            listeners = optional(list(object({
              certificateUrl = optional(string)
              protocol       = optional(string)
            })))
          }))
        }))
      }))
      platformFaultDomain = optional(number)
      priority            = optional(string)
      proximityPlacementGroup = optional(object({
        id = optional(string)
      }))
      scheduledEventsProfile = optional(object({
        osImageNotificationProfile = optional(object({
          enable           = optional(bool)
          notBeforeTimeout = optional(string)
        }))
        terminateNotificationProfile = optional(object({
          enable           = optional(bool)
          notBeforeTimeout = optional(string)
        }))
      }))
      securityProfile = optional(object({
        encryptionAtHost = optional(bool)
        securityType     = optional(string)
        uefiSettings = optional(object({
          secureBootEnabled = optional(bool)
          vTpmEnabled       = optional(bool)
        }))
      }))
      storageProfile = optional(object({
        diskControllerType = optional(string)
        imageReference = optional(object({
          communityGalleryImageId = optional(string)
          id                      = optional(string)
          offer                   = optional(string)
          publisher               = optional(string)
          sharedGalleryImageId    = optional(string)
          sku                     = optional(string)
          version                 = optional(string)
        }))
      }))
      userData = optional(string)
      virtualMachineScaleSet = optional(object({
        id = optional(string)
      }))
    })
    zones = optional(list(string))
    extendedLocation = optional(object({
      name = optional(string)
      type = optional(string)
    }))
    plan = optional(object({
      name          = optional(string)
      product       = optional(string)
      promotionCode = optional(string)
      publisher     = optional(string)
    }))

    # network interface (AzureRM)
    network_interfaces = list(object({
      name                = string
      resource_group_name = optional(string) # If not provided, inherited in module from parent resource
      location            = optional(string) # Inherited in module from parent resource
      ip_configuration = list(object({
        name                                               = string
        gateway_load_balancer_frontend_ip_configuration_id = optional(string)
        subnet_id                                          = optional(string)
        private_ip_address_version                         = optional(string, "IPv4")
        private_ip_address_allocation                      = optional(string, "Dynamic")
        public_ip_address_id                               = optional(string)
        primary                                            = optional(bool)
        private_ip_address                                 = optional(string)
      }))
      dns_servers                    = optional(list(string))
      edge_zone                      = optional(string)
      ip_forwarding_enabled          = optional(bool)
      accelerated_networking_enabled = optional(bool, true)
      internal_dns_name_label        = optional(string)
      tags                           = optional(map(any)) # If not provided, inherited in module form parent resource
    }))

    # managed disk  (AzureRM + AzAPI)
    managed_disks = list(object({
      os_disk              = optional(bool, false) # Custom variable that needs to be set to `true` for the OS disk
      name                 = string
      resource_group_name  = optional(string) # If not provided, inherited in module from parent resource
      location             = optional(string) # Inherited in module from parent resource
      storage_account_type = string
      create_option        = optional(string, "Restore")
      delete_option        = optional(string, "Detach") # AzAPI
      detach_option        = optional(string)           # AzAPI; data disks only
      to_be_detached       = optional(bool, false)      # AzAPI; data disks only
      diff_disk_settings = optional(object({            # AzAPI; OS disk only
        option    = string
        placement = optional(string)
      }))
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
        enabled = optional(bool) # AzAPI
        key_encryption_key = optional(object({
          key_url         = string
          source_vault_id = string
        }))
      }))
      hyper_v_generation                = optional(string)
      image_reference_id                = optional(string)
      gallery_image_reference_id        = optional(string)
      logical_sector_size               = optional(number)
      optimized_frequent_attach_enabled = optional(bool)
      performance_plus_enabled          = optional(bool)
      os_type                           = optional(string)
      source_resource_id                = optional(string)
      source_uri                        = optional(string)
      storage_account_id                = optional(string)
      image_uri                         = optional(string) # AzAPI
      tier                              = optional(string)
      max_shares                        = optional(number)
      trusted_launch_enabled            = optional(bool)
      security_type                     = optional(string)
      secure_vm_disk_encryption_set_id  = optional(string)
      on_demand_bursting_enabled        = optional(bool)
      zone                              = optional(string)
      network_access_policy             = optional(string)
      disk_access_id                    = optional(string)
      public_network_access_enabled     = optional(bool, false)
      lun                               = optional(number) # Required for data disks; data disks only
      caching                           = optional(string, "ReadWrite")
      write_accelerator_enabled         = optional(bool)
      tags                              = optional(map(any)) # If not provided, inherited in module from parent resource

      # data protection backup instance disk (AzureRM)
      disk_backup = optional(list(object({
        name                         = optional(string) # If not provided, inherited in module from parent resource
        location                     = optional(string) # Inherited in module from parent resource
        vault_id                     = string
        disk_id                      = optional(string) # Inherited in module from parent resource
        snapshot_resource_group_name = optional(string) # If not provided, inherited in module from parent resource
        backup_policy_id             = string
      })), [])
    }))

    # monitor data collection rule association (AzureRM)
    data_collection_rule_association = optional(list(object({
      target_resource_id          = optional(string) # Inherited in module from parent resource
      name                        = optional(string)
      data_collection_endpoint_id = optional(string)
      data_collection_rule_id     = optional(string)
      description                 = optional(string)
    })), [])

    # backup protected vm (AzureRM)
    vm_backup = optional(list(object({
      resource_group_name = string
      recovery_vault_name = string
      source_vm_id        = optional(string) # Inherited in module from parent resource
      backup_policy_id    = optional(string)
      exclude_disk_luns   = optional(list(number))
      include_disk_luns   = optional(list(number))
      protection_state    = optional(string)
    })), [])

    # virtual machine extension (AzureRM)
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
      provision_after_extensions = optional(list(string))
      tags                       = optional(map(any)) # If not provided, inherited in module form parent resource
    })), [])
  }))
}


```


## Table with config variables

| Name | Data Type | Requirement | Default Value | Comment |
| ------- | --------- | ----------- | ------------- | ------- |
|name | string | Required |  |  |
|location | string | Required |  |  |
|resource_group_name | string | Required |  |  Custom parameter used for AzureRM provider resources |
|parent_id | string | Required |  |  |
|tags | map(any) | Optional |  |  |
|identity | object | Optional |  |  |
|&nbsp;type | string | Optional |  |  |
|&nbsp;identity_ids | list(string) | Optional |  |  |
|properties | object | Required |  |  |
|&nbsp;additionalCapabilities | object | Optional |  |  |
|&nbsp;&nbsp;hibernationEnabled | bool | Optional |  |  |
|&nbsp;&nbsp;ultraSSDEnabled | bool | Optional |  |  |
|&nbsp;applicationProfile | object | Optional |  |  |
|&nbsp;&nbsp;galleryApplications | list(object) | Optional | [] |  |
|&nbsp;&nbsp;&nbsp;configurationReference | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;enableAutomaticUpgrade | bool | Optional |  |  |
|&nbsp;&nbsp;&nbsp;order | number | Optional |  |  |
|&nbsp;&nbsp;&nbsp;packageReferenceId | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;tags | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;treatFailureAsDeploymentFailure | bool | Optional |  |  |
|&nbsp;availabilitySet | object | Optional |  |  |
|&nbsp;&nbsp;id | string | Optional |  |  |
|&nbsp;billingProfile | object | Optional |  |  |
|&nbsp;&nbsp;maxPrice | string | Optional |  |  |
|&nbsp;capacityReservation | object | Optional |  |  |
|&nbsp;&nbsp;capacityReservationGroup | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;id | string | Optional |  |  |
|&nbsp;diagnosticsProfile | object | Optional |  |  |
|&nbsp;&nbsp;bootDiagnostics | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;enabled | bool | Optional |  |  |
|&nbsp;&nbsp;&nbsp;storageUri | string | Optional |  |  |
|&nbsp;evictionPolicy | string | Optional |  |  |
|&nbsp;extensionsTimeBudget | string | Optional |  |  |
|&nbsp;hardwareProfile | object | Required |  |  |
|&nbsp;&nbsp;vmSize | string | Required |  |  |
|&nbsp;&nbsp;vmSizeProperties | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;vCPUsAvailable | number | Optional |  |  |
|&nbsp;&nbsp;&nbsp;vCPUsPerCore | number | Optional |  |  |
|&nbsp;host | object | Optional |  |  |
|&nbsp;&nbsp;id | string | Optional |  |  |
|&nbsp;hostGroup | object | Optional |  |  |
|&nbsp;&nbsp;id | string | Optional |  |  |
|&nbsp;licenseType | string | Optional |  |  |
|&nbsp;osProfile | object | Optional |  |  |
|&nbsp;&nbsp;adminPassword | string | Optional |  |  |
|&nbsp;&nbsp;adminUsername | string | Optional |  |  |
|&nbsp;&nbsp;computerName | string | Optional |  |  |
|&nbsp;&nbsp;allowExtensionOperations | bool | Optional |  |  |
|&nbsp;&nbsp;customData | string | Optional |  |  |
|&nbsp;&nbsp;linuxConfiguration | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;disablePasswordAuthentication | bool | Optional |  |  |
|&nbsp;&nbsp;&nbsp;enableVMAgentPlatformUpdates | bool | Optional |  |  |
|&nbsp;&nbsp;&nbsp;patchSettings | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;assessmentMode | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;automaticByPlatformSettings | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;bypassPlatformSafetyChecksOnUserSchedule | bool | Optional |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rebootSetting | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;patchMode | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;provisionVMAgent | bool | Optional |  |  |
|&nbsp;&nbsp;&nbsp;ssh | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;publicKeys | list(object) | Optional | [] |  |
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;keyData | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;path | string | Optional |  |  |
|&nbsp;&nbsp;requireGuestProvisionSignal | bool | Optional |  |  |
|&nbsp;&nbsp;secrets | list(object) | Optional | [] |  |
|&nbsp;&nbsp;&nbsp;sourceVault | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;id | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;vaultCertificates | list(object) | Optional | [] |  |
|&nbsp;&nbsp;&nbsp;&nbsp;certificateStore | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;certificateUrl | string | Optional |  |  |
|&nbsp;&nbsp;windowsConfiguration | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;additionalUnattendContent | list(object) | Optional | [] |  |
|&nbsp;&nbsp;&nbsp;&nbsp;componentName | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;content | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;passName | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;settingName | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;enableAutomaticUpdates | bool | Optional |  |  |
|&nbsp;&nbsp;&nbsp;enableVMAgentPlatformUpdates | bool | Optional |  |  |
|&nbsp;&nbsp;&nbsp;patchSettings | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;assessmentMode | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;automaticByPlatformSettings | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;bypassPlatformSafetyChecksOnUserSchedule | bool | Optional |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rebootSetting | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;enableHotpatching | bool | Optional |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;patchMode | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;provisionVMAgent | bool | Optional |  |  |
|&nbsp;&nbsp;&nbsp;timeZone | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;winRM | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;listeners | list(object) | Optional | [] |  |
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;certificateUrl | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;protocol | string | Optional |  |  |
|&nbsp;platformFaultDomain | number | Optional |  |  |
|&nbsp;priority | string | Optional |  |  |
|&nbsp;proximityPlacementGroup | object | Optional |  |  |
|&nbsp;&nbsp;id | string | Optional |  |  |
|&nbsp;scheduledEventsProfile | object | Optional |  |  |
|&nbsp;&nbsp;osImageNotificationProfile | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;enable | bool | Optional |  |  |
|&nbsp;&nbsp;&nbsp;notBeforeTimeout | string | Optional |  |  |
|&nbsp;&nbsp;terminateNotificationProfile | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;enable | bool | Optional |  |  |
|&nbsp;&nbsp;&nbsp;notBeforeTimeout | string | Optional |  |  |
|&nbsp;securityProfile | object | Optional |  |  |
|&nbsp;&nbsp;encryptionAtHost | bool | Optional |  |  |
|&nbsp;&nbsp;securityType | string | Optional |  |  |
|&nbsp;&nbsp;uefiSettings | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;secureBootEnabled | bool | Optional |  |  |
|&nbsp;&nbsp;&nbsp;vTpmEnabled | bool | Optional |  |  |
|&nbsp;storageProfile | object | Optional |  |  |
|&nbsp;&nbsp;diskControllerType | string | Optional |  |  |
|&nbsp;&nbsp;imageReference | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;communityGalleryImageId | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;id | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;offer | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;publisher | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;sharedGalleryImageId | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;sku | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;version | string | Optional |  |  |
|&nbsp;userData | string | Optional |  |  |
|&nbsp;virtualMachineScaleSet | object | Optional |  |  |
|&nbsp;&nbsp;id | string | Optional |  |  |
|zones | list(string) | Optional |  |  |
|extendedLocation | object | Optional |  |  |
|&nbsp;name | string | Optional |  |  |
|&nbsp;type | string | Optional |  |  |
|plan | object | Optional |  |  |
|&nbsp;name | string | Optional |  |  |
|&nbsp;product | string | Optional |  |  |
|&nbsp;promotionCode | string | Optional |  |  |
|&nbsp;publisher | string | Optional |  |  |
|network_interfaces | list(object) | Required |  |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;resource_group_name | string | Optional |  |  If not provided, inherited in module from parent resource |
|&nbsp;location | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;ip_configuration | list(object) | Required |  |  |
|&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;gateway_load_balancer_frontend_ip_configuration_id | string | Optional |  |  |
|&nbsp;&nbsp;subnet_id | string | Optional |  |  |
|&nbsp;&nbsp;private_ip_address_version | string | Optional |  "IPv4" |  |
|&nbsp;&nbsp;private_ip_address_allocation | string | Optional |  "Dynamic" |  |
|&nbsp;&nbsp;public_ip_address_id | string | Optional |  |  |
|&nbsp;&nbsp;primary | bool | Optional |  |  |
|&nbsp;&nbsp;private_ip_address | string | Optional |  |  |
|&nbsp;dns_servers | list(string) | Optional |  |  |
|&nbsp;edge_zone | string | Optional |  |  |
|&nbsp;ip_forwarding_enabled | bool | Optional |  |  |
|&nbsp;accelerated_networking_enabled | bool | Optional |  true |  |
|&nbsp;internal_dns_name_label | string | Optional |  |  |
|&nbsp;tags | map(any) | Optional |  |  If not provided, inherited in module form parent resource |
|managed_disks | list(object) | Required |  |  |
|&nbsp;os_disk | bool | Optional |  false |  Custom variable that needs to be set to `true` for the OS disk |
|&nbsp;name | string | Required |  |  |
|&nbsp;resource_group_name | string | Optional |  |  If not provided, inherited in module from parent resource |
|&nbsp;location | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;storage_account_type | string | Required |  |  |
|&nbsp;create_option | string | Optional |  "Restore" |  |
|&nbsp;delete_option | string | Optional |  "Detach" |  AzAPI |
|&nbsp;detach_option | string | Optional |  |  AzAPI; data disks only |
|&nbsp;to_be_detached | bool | Optional |  false |  AzAPI; data disks only |
|&nbsp;diff_disk_settings | object | Optional |  |  AzAPI; OS disk only |
|&nbsp;&nbsp;option | string | Required |  |  |
|&nbsp;&nbsp;placement | string | Optional |  |  |
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
|&nbsp;&nbsp;enabled | bool | Optional |  |  AzAPI |
|&nbsp;&nbsp;key_encryption_key | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;key_url | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;source_vault_id | string | Required |  |  |
|&nbsp;hyper_v_generation | string | Optional |  |  |
|&nbsp;image_reference_id | string | Optional |  |  |
|&nbsp;gallery_image_reference_id | string | Optional |  |  |
|&nbsp;logical_sector_size | number | Optional |  |  |
|&nbsp;optimized_frequent_attach_enabled | bool | Optional |  |  |
|&nbsp;performance_plus_enabled | bool | Optional |  |  |
|&nbsp;os_type | string | Optional |  |  |
|&nbsp;source_resource_id | string | Optional |  |  |
|&nbsp;source_uri | string | Optional |  |  |
|&nbsp;storage_account_id | string | Optional |  |  |
|&nbsp;image_uri | string | Optional |  |  AzAPI |
|&nbsp;tier | string | Optional |  |  |
|&nbsp;max_shares | number | Optional |  |  |
|&nbsp;trusted_launch_enabled | bool | Optional |  |  |
|&nbsp;security_type | string | Optional |  |  |
|&nbsp;secure_vm_disk_encryption_set_id | string | Optional |  |  |
|&nbsp;on_demand_bursting_enabled | bool | Optional |  |  |
|&nbsp;zone | string | Optional |  |  |
|&nbsp;network_access_policy | string | Optional |  |  |
|&nbsp;disk_access_id | string | Optional |  |  |
|&nbsp;public_network_access_enabled | bool | Optional |  false |  |
|&nbsp;lun | number | Optional |  |  Required for data disks; data disks only |
|&nbsp;caching | string | Optional |  "ReadWrite" |  |
|&nbsp;write_accelerator_enabled | bool | Optional |  |  |
|&nbsp;tags | map(any) | Optional |  |  If not provided, inherited in module from parent resource |
|&nbsp;disk_backup | list(object) | Optional | [] |  |
|&nbsp;&nbsp;name | string | Optional |  |  If not provided, inherited in module from parent resource |
|&nbsp;&nbsp;location | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;&nbsp;vault_id | string | Required |  |  |
|&nbsp;&nbsp;disk_id | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;&nbsp;snapshot_resource_group_name | string | Optional |  |  If not provided, inherited in module from parent resource |
|&nbsp;&nbsp;backup_policy_id | string | Required |  |  |
|data_collection_rule_association | list(object) | Optional | [] |  |
|&nbsp;target_resource_id | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;name | string | Optional |  |  |
|&nbsp;data_collection_endpoint_id | string | Optional |  |  |
|&nbsp;data_collection_rule_id | string | Optional |  |  |
|&nbsp;description | string | Optional |  |  |
|vm_backup | list(object) | Optional | [] |  |
|&nbsp;resource_group_name | string | Required |  |  |
|&nbsp;recovery_vault_name | string | Required |  |  |
|&nbsp;source_vm_id | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;backup_policy_id | string | Optional |  |  |
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
|&nbsp;provision_after_extensions | list(string) | Optional |  |  |
|&nbsp;tags | map(any) | Optional |  |  If not provided, inherited in module form parent resource |


