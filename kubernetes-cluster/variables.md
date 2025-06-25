# Variables

```
variable "config" {  type = list(object({
    # kubernetes cluster
    name                = string
    resource_group_name = string
    location            = string
    default_node_pool = object({
      vm_size                       = optional(string)
      name                          = optional(string, "systemnp")
      capacity_reservation_group_id = optional(string)
      auto_scaling_enabled          = optional(bool)
      host_encryption_enabled       = optional(bool)
      node_public_ip_enabled        = optional(bool)
      max_pods                      = optional(number)
      node_public_ip_prefix_id      = optional(string)
      node_labels                   = optional(map(any))
      only_critical_addons_enabled  = optional(bool)
      os_disk_size_gb               = optional(string)
      os_disk_type                  = optional(string)
      pod_subnet_id                 = optional(string)
      temporary_name_for_rotation   = optional(string)
      type                          = optional(string)
      ultra_ssd_enabled             = optional(bool)
      upgrade_settings = optional(object({
        drain_timeout_in_minutes      = optional(number)
        node_soak_duration_in_minutes = optional(number)
        max_surge                     = string
      }))
      vnet_subnet_id = optional(string)
      zones          = optional(list(string))
      max_count      = optional(number)
      min_count      = optional(number)
      node_count     = optional(number)
      tags           = optional(map(any)) # If not provided, inherited in module from parent resource
    })
    dns_prefix                 = optional(string)
    dns_prefix_private_cluster = optional(string)
    automatic_upgrade_channel  = optional(string)
    azure_active_directory_role_based_access_control = optional(object({
      admin_group_object_ids = optional(list(string))
      azure_rbac_enabled     = optional(bool)
    }))
    azure_policy_enabled  = optional(bool)
    cost_analysis_enabled = optional(bool)
    identity = optional(object({
      type         = string
      identity_ids = optional(list(string))
    }))
    image_cleaner_enabled        = optional(string)
    image_cleaner_interval_hours = optional(number)
    ingress_application_gateway = optional(object({
      gateway_id   = optional(string)
      gateway_name = optional(string)
      subnet_cidr  = optional(string)
      subnet_id    = optional(string)
    }))
    key_vault_secrets_provider = optional(object({
      secret_rotation_enabled = optional(bool)
    }))
    kubernetes_version = optional(string)
    linux_profile = optional(object({
      admin_username = string
      ssh_key = object({
        key_data = string
      })
    }))
    local_account_disabled = optional(bool)
    maintenance_window = optional(object({
      allowed = optional(list(object({
        day   = string
        hours = list(number)
      })), [])
      not_allowed = optional(list(object({
        end   = string
        start = string
      })), [])
    }))
    maintenance_window_auto_upgrade = optional(object({
      frequency    = string
      interval     = number
      duration     = number
      day_of_week  = optional(string)
      day_of_month = optional(number)
      week_index   = optional(string)
      start_time   = optional(string)
      utc_offset   = optional(string)
      start_date   = optional(string)
      not_allowed = optional(list(object({
        end   = string
        start = string
      })), [])
    }))
    maintenance_window_node_os = optional(object({
      frequency    = string
      interval     = number
      duration     = number
      day_of_week  = optional(string)
      day_of_month = optional(number)
      week_index   = optional(string)
      start_time   = optional(string)
      utc_offset   = optional(string)
      start_date   = optional(string)
      not_allowed = optional(list(object({
        end   = string
        start = string
      })), [])
    }))
    microsoft_defender = optional(object({
      log_analytics_workspace_id = string
    }))
    monitor_metrics = optional(object({
      annotations_allowed = optional(string)
      labels_allowed      = optional(string)
    }))
    network_profile = optional(object({
      network_plugin      = string
      network_policy      = optional(string)
      dns_service_ip      = optional(string)
      network_plugin_mode = optional(string)
      outbound_type       = optional(string)
      pod_cidr            = optional(string)
      service_cidr        = optional(string)
      load_balancer_sku   = optional(string)
    }))
    node_os_upgrade_channel = optional(string)
    node_resource_group     = optional(string)
    oidc_issuer_enabled     = optional(bool)
    oms_agent = optional(object({
      log_analytics_workspace_id      = string
      msi_auth_for_monitoring_enabled = optional(bool)
    }))
    private_cluster_enabled             = optional(bool, true)
    private_dns_zone_id                 = optional(string)
    private_cluster_public_fqdn_enabled = optional(bool)
    workload_autoscaler_profile = optional(object({
      keda_enabled = optional(bool)
    }))
    workload_identity_enabled         = optional(bool)
    role_based_access_control_enabled = optional(bool)
    sku_tier                          = optional(string)
    storage_profile = optional(object({
      blob_driver_enabled         = optional(bool)
      disk_driver_enabled         = optional(bool)
      file_driver_enabled         = optional(bool)
      snapshot_controller_enabled = optional(bool)
    }))
    support_plan = optional(string)
    windows_profile = optional(object({
      admin_username = string
      admin_password = optional(string)
      license        = optional(string)
      gmsa = optional(object({
        dns_server  = string
        root_domain = string
      }))
    }))
    tags = optional(map(any))

    # kubernetes cluster node pool
    cluster_node_pool = optional(list(object({
      name                          = string
      kubernetes_cluster_id         = optional(string) # Inherited in module from parent resource
      vm_size                       = optional(string)
      capacity_reservation_group_id = optional(string)
      auto_scaling_enabled          = optional(bool)
      host_encryption_enabled       = optional(bool)
      node_public_ip_enabled        = optional(bool)
      max_pods                      = optional(number)
      node_labels                   = optional(map(any))
      node_public_ip_prefix_id      = optional(string)
      node_taints                   = optional(list(string))
      os_disk_size_gb               = optional(string)
      os_disk_type                  = optional(string)
      pod_subnet_id                 = optional(string)
      ultra_ssd_enabled             = optional(bool)
      upgrade_settings = optional(object({
        drain_timeout_in_minutes      = optional(number)
        node_soak_duration_in_minutes = optional(number)
        max_surge                     = string
      }))
      vnet_subnet_id = optional(string)
      zones          = optional(list(string))
      max_count      = optional(number)
      min_count      = optional(number)
      node_count     = optional(number)
      tags           = optional(map(any)) # If not provided, inherited in module from parent resource
    })), [])

    # monitoring
    monitoring = optional(list(object({                 # Custom object for enabling diagnostic settings
      diag_name                      = optional(string) # Name of the diagnostic setting
      log_analytics_workspace_id     = optional(string)
      eventhub_name                  = optional(string)
      eventhub_authorization_rule_id = optional(string)
      storage_account_id             = optional(string)
      categories = optional(object({
        kube_controller_manager  = optional(bool, true)
        cloud_controller_manager = optional(bool, true)
        csi_azuredisk_controller = optional(bool, true)
        csi_azurefile_controller = optional(bool, true)
        csi_snapshot_controller  = optional(bool, true)
        guard                    = optional(bool, true)
        cluster_autoscaler       = optional(bool, true)
        kube_apiserver           = optional(bool, true)
        kube_scheduler           = optional(bool, true)
        kube_audit               = optional(bool, false)
        kube_audit_admin         = optional(bool, false)
        all_metrics              = optional(bool, true)
      }))
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
|default_node_pool | object | Required |  |  |
|&nbsp;vm_size | string | Optional |  |  |
|&nbsp;name | string | Optional |  "systemnp" |  |
|&nbsp;capacity_reservation_group_id | string | Optional |  |  |
|&nbsp;auto_scaling_enabled | bool | Optional |  |  |
|&nbsp;host_encryption_enabled | bool | Optional |  |  |
|&nbsp;node_public_ip_enabled | bool | Optional |  |  |
|&nbsp;max_pods | number | Optional |  |  |
|&nbsp;node_public_ip_prefix_id | string | Optional |  |  |
|&nbsp;node_labels | map(any) | Optional |  |  |
|&nbsp;only_critical_addons_enabled | bool | Optional |  |  |
|&nbsp;os_disk_size_gb | string | Optional |  |  |
|&nbsp;os_disk_type | string | Optional |  |  |
|&nbsp;pod_subnet_id | string | Optional |  |  |
|&nbsp;temporary_name_for_rotation | string | Optional |  |  |
|&nbsp;type | string | Optional |  |  |
|&nbsp;ultra_ssd_enabled | bool | Optional |  |  |
|&nbsp;upgrade_settings | object | Optional |  |  |
|&nbsp;&nbsp;drain_timeout_in_minutes | number | Optional |  |  |
|&nbsp;&nbsp;node_soak_duration_in_minutes | number | Optional |  |  |
|&nbsp;&nbsp;max_surge | string | Required |  |  |
|&nbsp;vnet_subnet_id | string | Optional |  |  |
|&nbsp;zones | list(string) | Optional |  |  |
|&nbsp;max_count | number | Optional |  |  |
|&nbsp;min_count | number | Optional |  |  |
|&nbsp;node_count | number | Optional |  |  |
|&nbsp;tags | map(any) | Optional |  |  If not provided, inherited in module from parent resource |
|dns_prefix | string | Optional |  |  |
|dns_prefix_private_cluster | string | Optional |  |  |
|automatic_upgrade_channel | string | Optional |  |  |
|azure_active_directory_role_based_access_control | object | Optional |  |  |
|&nbsp;admin_group_object_ids | list(string) | Optional |  |  |
|&nbsp;&nbsp;azure_rbac_enabled | bool | Optional |  |  |
|&nbsp;azure_policy_enabled | bool | Optional |  |  |
|&nbsp;cost_analysis_enabled | bool | Optional |  |  |
|&nbsp;identity | object | Optional |  |  |
|&nbsp;&nbsp;type | string | Required |  |  |
|&nbsp;&nbsp;identity_ids | list(string) | Optional |  |  |
|&nbsp;image_cleaner_enabled | string | Optional |  |  |
|&nbsp;image_cleaner_interval_hours | number | Optional |  |  |
|&nbsp;ingress_application_gateway | object | Optional |  |  |
|&nbsp;&nbsp;gateway_id | string | Optional |  |  |
|&nbsp;&nbsp;gateway_name | string | Optional |  |  |
|&nbsp;&nbsp;subnet_cidr | string | Optional |  |  |
|&nbsp;&nbsp;subnet_id | string | Optional |  |  |
|&nbsp;key_vault_secrets_provider | object | Optional |  |  |
|&nbsp;&nbsp;secret_rotation_enabled | bool | Optional |  |  |
|&nbsp;kubernetes_version | string | Optional |  |  |
|&nbsp;linux_profile | object | Optional |  |  |
|&nbsp;&nbsp;admin_username | string | Required |  |  |
|&nbsp;&nbsp;ssh_key | object | Required |  |  |
|&nbsp;&nbsp;&nbsp;key_data | string | Required |  |  |
|&nbsp;local_account_disabled | bool | Optional |  |  |
|&nbsp;maintenance_window | object | Optional |  |  |
|&nbsp;&nbsp;allowed | list(object) | Optional | [] |  |
|&nbsp;&nbsp;&nbsp;day | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;hours | list(number) | Required |  |  |
|&nbsp;&nbsp;not_allowed | list(object) | Optional | [] |  |
|&nbsp;&nbsp;&nbsp;end | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;start | string | Required |  |  |
|&nbsp;maintenance_window_auto_upgrade | object | Optional |  |  |
|&nbsp;&nbsp;frequency | string | Required |  |  |
|&nbsp;&nbsp;interval | number | Required |  |  |
|&nbsp;&nbsp;duration | number | Required |  |  |
|&nbsp;&nbsp;day_of_week | string | Optional |  |  |
|&nbsp;&nbsp;day_of_month | number | Optional |  |  |
|&nbsp;&nbsp;week_index | string | Optional |  |  |
|&nbsp;&nbsp;start_time | string | Optional |  |  |
|&nbsp;&nbsp;utc_offset | string | Optional |  |  |
|&nbsp;&nbsp;start_date | string | Optional |  |  |
|&nbsp;&nbsp;not_allowed | list(object) | Optional | [] |  |
|&nbsp;&nbsp;&nbsp;end | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;start | string | Required |  |  |
|&nbsp;maintenance_window_node_os | object | Optional |  |  |
|&nbsp;&nbsp;frequency | string | Required |  |  |
|&nbsp;&nbsp;interval | number | Required |  |  |
|&nbsp;&nbsp;duration | number | Required |  |  |
|&nbsp;&nbsp;day_of_week | string | Optional |  |  |
|&nbsp;&nbsp;day_of_month | number | Optional |  |  |
|&nbsp;&nbsp;week_index | string | Optional |  |  |
|&nbsp;&nbsp;start_time | string | Optional |  |  |
|&nbsp;&nbsp;utc_offset | string | Optional |  |  |
|&nbsp;&nbsp;start_date | string | Optional |  |  |
|&nbsp;&nbsp;not_allowed | list(object) | Optional | [] |  |
|&nbsp;&nbsp;&nbsp;end | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;start | string | Required |  |  |
|&nbsp;microsoft_defender | object | Optional |  |  |
|&nbsp;&nbsp;log_analytics_workspace_id | string | Required |  |  |
|&nbsp;monitor_metrics | object | Optional |  |  |
|&nbsp;&nbsp;annotations_allowed | string | Optional |  |  |
|&nbsp;&nbsp;labels_allowed | string | Optional |  |  |
|&nbsp;network_profile | object | Optional |  |  |
|&nbsp;&nbsp;network_plugin | string | Required |  |  |
|&nbsp;&nbsp;network_policy | string | Optional |  |  |
|&nbsp;&nbsp;dns_service_ip | string | Optional |  |  |
|&nbsp;&nbsp;network_plugin_mode | string | Optional |  |  |
|&nbsp;&nbsp;outbound_type | string | Optional |  |  |
|&nbsp;&nbsp;pod_cidr | string | Optional |  |  |
|&nbsp;&nbsp;service_cidr | string | Optional |  |  |
|&nbsp;&nbsp;load_balancer_sku | string | Optional |  |  |
|&nbsp;node_os_upgrade_channel | string | Optional |  |  |
|&nbsp;node_resource_group | string | Optional |  |  |
|&nbsp;oidc_issuer_enabled | bool | Optional |  |  |
|&nbsp;oms_agent | object | Optional |  |  |
|&nbsp;&nbsp;log_analytics_workspace_id | string | Required |  |  |
|&nbsp;&nbsp;msi_auth_for_monitoring_enabled | bool | Optional |  |  |
|&nbsp;private_cluster_enabled | bool | Optional |  true |  |
|&nbsp;private_dns_zone_id | string | Optional |  |  |
|&nbsp;private_cluster_public_fqdn_enabled | bool | Optional |  |  |
|&nbsp;workload_autoscaler_profile | object | Optional |  |  |
|&nbsp;&nbsp;keda_enabled | bool | Optional |  |  |
|&nbsp;workload_identity_enabled | bool | Optional |  |  |
|&nbsp;role_based_access_control_enabled | bool | Optional |  |  |
|&nbsp;sku_tier | string | Optional |  |  |
|&nbsp;storage_profile | object | Optional |  |  |
|&nbsp;&nbsp;blob_driver_enabled | bool | Optional |  |  |
|&nbsp;&nbsp;disk_driver_enabled | bool | Optional |  |  |
|&nbsp;&nbsp;file_driver_enabled | bool | Optional |  |  |
|&nbsp;&nbsp;snapshot_controller_enabled | bool | Optional |  |  |
|&nbsp;support_plan | string | Optional |  |  |
|&nbsp;windows_profile | object | Optional |  |  |
|&nbsp;&nbsp;admin_username | string | Required |  |  |
|&nbsp;&nbsp;admin_password | string | Optional |  |  |
|&nbsp;&nbsp;license | string | Optional |  |  |
|&nbsp;&nbsp;gmsa | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;dns_server | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;root_domain | string | Required |  |  |
|&nbsp;tags | map(any) | Optional |  |  |
|&nbsp;cluster_node_pool | list(object) | Optional | [] |  |
|&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;kubernetes_cluster_id | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;&nbsp;vm_size | string | Optional |  |  |
|&nbsp;&nbsp;capacity_reservation_group_id | string | Optional |  |  |
|&nbsp;&nbsp;auto_scaling_enabled | bool | Optional |  |  |
|&nbsp;&nbsp;host_encryption_enabled | bool | Optional |  |  |
|&nbsp;&nbsp;node_public_ip_enabled | bool | Optional |  |  |
|&nbsp;&nbsp;max_pods | number | Optional |  |  |
|&nbsp;&nbsp;node_labels | map(any) | Optional |  |  |
|&nbsp;&nbsp;node_public_ip_prefix_id | string | Optional |  |  |
|&nbsp;&nbsp;node_taints | list(string) | Optional |  |  |
|&nbsp;&nbsp;os_disk_size_gb | string | Optional |  |  |
|&nbsp;&nbsp;os_disk_type | string | Optional |  |  |
|&nbsp;&nbsp;pod_subnet_id | string | Optional |  |  |
|&nbsp;&nbsp;ultra_ssd_enabled | bool | Optional |  |  |
|&nbsp;&nbsp;upgrade_settings | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;drain_timeout_in_minutes | number | Optional |  |  |
|&nbsp;&nbsp;&nbsp;node_soak_duration_in_minutes | number | Optional |  |  |
|&nbsp;&nbsp;&nbsp;max_surge | string | Required |  |  |
|&nbsp;&nbsp;vnet_subnet_id | string | Optional |  |  |
|&nbsp;&nbsp;zones | list(string) | Optional |  |  |
|&nbsp;&nbsp;max_count | number | Optional |  |  |
|&nbsp;&nbsp;min_count | number | Optional |  |  |
|&nbsp;&nbsp;node_count | number | Optional |  |  |
|&nbsp;&nbsp;tags | map(any) | Optional |  |  If not provided, inherited in module from parent resource |
|&nbsp;monitoring | list(object) | Optional | [] |  Custom object for enabling diagnostic settings |
|&nbsp;&nbsp;diag_name | string | Optional |  |  Name of the diagnostic setting |
|&nbsp;&nbsp;log_analytics_workspace_id | string | Optional |  |  |
|&nbsp;&nbsp;eventhub_name | string | Optional |  |  |
|&nbsp;&nbsp;eventhub_authorization_rule_id | string | Optional |  |  |
|&nbsp;&nbsp;storage_account_id | string | Optional |  |  |
|&nbsp;&nbsp;categories | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;kube_controller_manager | bool | Optional |  true |  |
|&nbsp;&nbsp;&nbsp;cloud_controller_manager | bool | Optional |  true |  |
|&nbsp;&nbsp;&nbsp;csi_azuredisk_controller | bool | Optional |  true |  |
|&nbsp;&nbsp;&nbsp;csi_azurefile_controller | bool | Optional |  true |  |
|&nbsp;&nbsp;&nbsp;csi_snapshot_controller | bool | Optional |  true |  |
|&nbsp;&nbsp;&nbsp;guard | bool | Optional |  true |  |
|&nbsp;&nbsp;&nbsp;cluster_autoscaler | bool | Optional |  true |  |
|&nbsp;&nbsp;&nbsp;kube_apiserver | bool | Optional |  true |  |
|&nbsp;&nbsp;&nbsp;kube_scheduler | bool | Optional |  true |  |
|&nbsp;&nbsp;&nbsp;kube_audit | bool | Optional |  false |  |
|&nbsp;&nbsp;&nbsp;kube_audit_admin | bool | Optional |  false |  |
|&nbsp;&nbsp;&nbsp;all_metrics | bool | Optional |  true |  |


