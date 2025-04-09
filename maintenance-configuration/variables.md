# Variables

```
variable "config" {  type = list(object({
    # maintenance configuration
    name                = string
    resource_group_name = string
    location            = string
    scope               = string
    visibility          = optional(string)
    window = optional(object({
      start_date_time      = string
      expiration_date_time = optional(string)
      duration             = optional(string)
      time_zone            = string
      recur_every          = optional(string)
    }))
    install_patches = optional(object({
      linux = optional(object({
        classifications_to_include    = optional(list(string))
        package_names_mask_to_exclude = optional(list(string))
        package_names_mask_to_include = optional(list(string))
      }))
      windows = optional(object({
        classifications_to_include = optional(list(string))
        kb_numbers_to_exclude      = optional(list(string))
        kb_numbers_to_include      = optional(list(string))
      }))
      reboot = optional(string)
    }))
    in_guest_user_patch_mode = optional(string)
    properties               = optional(map(string))
    tags                     = optional(map(any))
  }))
}


```


## Table with config variables

| Name | Data Type | Requirement | Default Value | Comment |
| ------- | --------- | ----------- | ------------- | ------- |
|name | string | Required |  |  |
|resource_group_name | string | Required |  |  |
|location | string | Required |  |  |
|scope | string | Required |  |  |
|visibility | string | Optional |  |  |
|window | object | Optional |  |  |
|&nbsp;start_date_time | string | Required |  |  |
|&nbsp;expiration_date_time | string | Optional |  |  |
|&nbsp;duration | string | Optional |  |  |
|&nbsp;time_zone | string | Required |  |  |
|&nbsp;recur_every | string | Optional |  |  |
|install_patches | object | Optional |  |  |
|&nbsp;linux | object | Optional |  |  |
|&nbsp;&nbsp;classifications_to_include | list(string) | Optional |  |  |
|&nbsp;&nbsp;package_names_mask_to_exclude | list(string) | Optional |  |  |
|&nbsp;&nbsp;package_names_mask_to_include | list(string) | Optional |  |  |
|&nbsp;windows | object | Optional |  |  |
|&nbsp;&nbsp;classifications_to_include | list(string) | Optional |  |  |
|&nbsp;&nbsp;kb_numbers_to_exclude | list(string) | Optional |  |  |
|&nbsp;&nbsp;kb_numbers_to_include | list(string) | Optional |  |  |
|&nbsp;reboot | string | Optional |  |  |
|in_guest_user_patch_mode | string | Optional |  |  |
|properties | map(string) | Optional |  |  |
|tags | map(any) | Optional |  |  |


