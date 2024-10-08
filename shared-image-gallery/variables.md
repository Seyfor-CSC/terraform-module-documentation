# Variables

```
variable "config" {  type = list(object({
    # shared image gallery
    name                = string
    resource_group_name = string
    location            = string
    description         = optional(string)
    sharing = optional(object({
      permission = string
      community_gallery = optional(object({
        eula            = string
        prefix          = string
        publisher_email = string
        publisher_uri   = string
      }))
    }))
    tags = optional(map(any))

    # shared image
    image = optional(list(object({
      name                = string
      resource_group_name = optional(string) # If not provided, inherited in module from parent resource
      location            = optional(string) # Inherited in module from parent resource
      gallery_name        = optional(string) # Inherited in module from parent resource
      identifier = object({
        offer     = string
        publisher = string
        sku       = string
      })
      os_type = string
      purchase_plan = optional(object({
        name      = string
        publisher = optional(string)
        product   = optional(string)
      }))
      description                         = optional(string)
      disk_types_not_allowed              = optional(list(string))
      end_of_life_date                    = optional(string)
      eula                                = optional(string)
      specialized                         = optional(bool)
      architecture                        = optional(string)
      hyper_v_generation                  = optional(string)
      max_recommended_vcpu_count          = optional(number)
      min_recommended_vcpu_count          = optional(number)
      max_recommended_memory_in_gb        = optional(number)
      min_recommended_memory_in_gb        = optional(number)
      privacy_statement_uri               = optional(string)
      release_note_uri                    = optional(string)
      trusted_launch_supported            = optional(bool)
      trusted_launch_enabled              = optional(bool)
      confidential_vm_supported           = optional(bool)
      confidential_vm_enabled             = optional(bool)
      hibernation_enabled                 = optional(bool)
      accelerated_network_support_enabled = optional(bool)
      tags                                = optional(map(any)) # If not provided, inherited in module from parent resource

      # shared image version
      image_version = optional(list(object({
        name                = string
        resource_group_name = optional(string) # If not provided, inherited in module from parent resource
        location            = optional(string) # Inherited in module from parent resource
        gallery_name        = optional(string) # Inherited in module from parent resource
        image_name          = optional(string) # Inherited in module from parent resource
        target_region = list(object({
          name                        = string
          regional_replica_count      = number
          disk_encryption_set_id      = optional(string)
          exclude_from_latest_enabled = optional(bool)
          storage_account_type        = optional(string)
        }))
        blob_uri                                 = optional(string)
        end_of_life_date                         = optional(string)
        exclude_from_latest                      = optional(bool)
        managed_image_id                         = optional(string)
        os_disk_snapshot_id                      = optional(string)
        deletion_of_replicated_locations_enabled = optional(bool)
        replication_mode                         = optional(string)
        storage_account_id                       = optional(string)
        tags                                     = optional(map(any)) # If not provided, inherited in module from parent resource
      })))
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
|description | string | Optional |  |  |
|sharing | object | Optional |  |  |
|&nbsp;permission | string | Required |  |  |
|&nbsp;community_gallery | object | Optional |  |  |
|&nbsp;&nbsp;eula | string | Required |  |  |
|&nbsp;&nbsp;prefix | string | Required |  |  |
|&nbsp;&nbsp;publisher_email | string | Required |  |  |
|&nbsp;&nbsp;publisher_uri | string | Required |  |  |
|tags | map(any) | Optional |  |  |
|image | list(object) | Optional | [] |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;resource_group_name | string | Optional |  |  If not provided, inherited in module from parent resource |
|&nbsp;location | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;gallery_name | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;identifier | object | Required |  |  |
|&nbsp;&nbsp;offer | string | Required |  |  |
|&nbsp;&nbsp;publisher | string | Required |  |  |
|&nbsp;&nbsp;sku | string | Required |  |  |
|&nbsp;os_type | string | Required |  |  |
|&nbsp;purchase_plan | object | Optional |  |  |
|&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;publisher | string | Optional |  |  |
|&nbsp;&nbsp;product | string | Optional |  |  |
|&nbsp;description | string | Optional |  |  |
|&nbsp;disk_types_not_allowed | list(string) | Optional |  |  |
|&nbsp;end_of_life_date | string | Optional |  |  |
|&nbsp;eula | string | Optional |  |  |
|&nbsp;specialized | bool | Optional |  |  |
|&nbsp;architecture | string | Optional |  |  |
|&nbsp;hyper_v_generation | string | Optional |  |  |
|&nbsp;max_recommended_vcpu_count | number | Optional |  |  |
|&nbsp;min_recommended_vcpu_count | number | Optional |  |  |
|&nbsp;max_recommended_memory_in_gb | number | Optional |  |  |
|&nbsp;min_recommended_memory_in_gb | number | Optional |  |  |
|&nbsp;privacy_statement_uri | string | Optional |  |  |
|&nbsp;release_note_uri | string | Optional |  |  |
|&nbsp;trusted_launch_supported | bool | Optional |  |  |
|&nbsp;trusted_launch_enabled | bool | Optional |  |  |
|&nbsp;confidential_vm_supported | bool | Optional |  |  |
|&nbsp;confidential_vm_enabled | bool | Optional |  |  |
|&nbsp;hibernation_enabled | bool | Optional |  |  |
|&nbsp;accelerated_network_support_enabled | bool | Optional |  |  |
|&nbsp;tags | map(any) | Optional |  |  If not provided, inherited in module from parent resource |
|&nbsp;image_version | list(object) | Optional | [] |  |
|&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;resource_group_name | string | Optional |  |  If not provided, inherited in module from parent resource |
|&nbsp;&nbsp;location | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;&nbsp;gallery_name | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;&nbsp;image_name | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;&nbsp;target_region | list(object) | Required |  |  |
|&nbsp;&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;regional_replica_count | number | Required |  |  |
|&nbsp;&nbsp;&nbsp;disk_encryption_set_id | string | Optional |  |  |
|&nbsp;&nbsp;&nbsp;exclude_from_latest_enabled | bool | Optional |  |  |
|&nbsp;&nbsp;&nbsp;storage_account_type | string | Optional |  |  |
|&nbsp;&nbsp;blob_uri | string | Optional |  |  |
|&nbsp;&nbsp;end_of_life_date | string | Optional |  |  |
|&nbsp;&nbsp;exclude_from_latest | bool | Optional |  |  |
|&nbsp;&nbsp;managed_image_id | string | Optional |  |  |
|&nbsp;&nbsp;os_disk_snapshot_id | string | Optional |  |  |
|&nbsp;&nbsp;deletion_of_replicated_locations_enabled | bool | Optional |  |  |
|&nbsp;&nbsp;replication_mode | string | Optional |  |  |
|&nbsp;&nbsp;storage_account_id | string | Optional |  |  |
|&nbsp;&nbsp;tags | map(any) | Optional |  |  If not provided, inherited in module from parent resource |


