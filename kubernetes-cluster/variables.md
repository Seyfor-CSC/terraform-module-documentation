# Variables

```
variable "config" {  type = list(object({
    # kubernetes cluster
    name                = string
    resource_group_name = string
    location            = string
    default_node_pool = object({
      vm_size                      = string
      name                         = optional(string, "systemnp")
      enable_auto_scaling          = optional(bool)
      enable_host_encryption       = optional(bool)
      enable_node_public_ip        = optional(bool)
      max_pods                     = optional(number)
      node_public_ip_prefix_id     = optional(string)
      node_labels                  = optional(map(any))
      node_taints                  = optional(list(string))
      only_critical_addons_enabled = optional(bool)
      os_disk_size_gb              = optional(string)
      os_disk_type                 = optional(string)
      pod_subnet_id                = optional(string)
      temporary_name_for_rotation  = optional(string)
      type                         = optional(string)
      ultra_ssd_enabled            = optional(string)
      vnet_subnet_id               = optional(string)
      zones                        = optional(list(string))
      max_count                    = optional(number)
      min_count                    = optional(number)
      node_count                   = optional(number)
      tags                         = optional(map(any))
    })
    dns_prefix                 = optional(string)
    dns_prefix_private_cluster = optional(string)
    automatic_channel_upgrade  = optional(string)
    azure_active_directory_role_based_access_control = optional(object({
      managed                = optional(bool)
      admin_group_object_ids = optional(list(string))
      azure_rbac_enabled     = optional(bool)
    }))
    azure_policy_enabled = optional(bool)
    identity = optional(object({
      type         = string
      identity_ids = optional(list(string))
    }))
    image_cleaner_enabled = optional(string)
    key_vault_secrets_provider = optional(object({
      secret_rotation_enabled = optional(bool)
    }))
    kubernetes_version = optional(string)
    linux_profile = optional(object({
      admin_username = string
      ssh_key = optional(object({
        key_data = string
      }))
    }))
    local_account_disabled = optional(bool)
    network_profile = optional(object({
      network_plugin      = string
      network_policy      = optional(string)
      dns_service_ip      = optional(string)
      docker_bridge_cidr  = optional(string)
      network_plugin_mode = optional(string)
      outbound_type       = optional(string)
      pod_cidr            = optional(string)
      service_cidr        = optional(string)
      load_balancer_sku   = optional(string)
    }))
    node_resource_group = optional(string)
    oidc_issuer_enabled = optional(bool)
    oms_agent = optional(object({
      log_analytics_workspace_id = string
    }))
    private_cluster_enabled             = optional(bool)
    private_dns_zone_id                 = optional(string)
    private_cluster_public_fqdn_enabled = optional(string)
    workload_autoscaler_profile = optional(object({
      keda_enabled = optional(bool)
    }))
    workload_identity_enabled         = optional(bool)
    public_network_access_enabled     = optional(bool)
    role_based_access_control_enabled = optional(bool)
    sku_tier                          = optional(string)
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
      name                     = string
      kubernetes_cluster_id    = optional(string) # Inherited in module from parent resource
      vm_size                  = string
      enable_auto_scaling      = optional(bool)
      enable_host_encryption   = optional(bool)
      enable_node_public_ip    = optional(bool)
      max_pods                 = optional(number)
      node_labels              = optional(map(any))
      node_public_ip_prefix_id = optional(string)
      node_taints              = optional(list(string))
      os_disk_size_gb          = optional(string)
      os_disk_type             = optional(string)
      pod_subnet_id            = optional(string)
      ultra_ssd_enabled        = optional(string)
      vnet_subnet_id           = optional(string)
      zones                    = optional(list(string))
      max_count                = optional(number)
      min_count                = optional(number)
      node_count               = optional(number)
      tags                     = optional(map(any))
    })), [])

    # monitoring
    monitoring = optional(list(object({                 # Custom object for enabling diagnostic settings
      diag_name                      = optional(string) # Name of the diagnostic setting
      log_analytics_workspace_id     = optional(string)
      eventhub_name                  = optional(string)
      eventhub_authorization_rule_id = optional(string)
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
|&nbsp;vm_size | string | Required |  |  |
|&nbsp;name | string | Optional |  "systemnp" |  |
|&nbsp;enable_auto_scaling | bool | Optional |  |  |
|&nbsp;enable_host_encryption | bool | Optional |  |  |
|&nbsp;enable_node_public_ip | bool | Optional |  |  |
|&nbsp;max_pods | number | Optional |  |  |
|&nbsp;node_public_ip_prefix_id | string | Optional |  |  |
|&nbsp;node_labels | map(any) | Optional |  |  |
|&nbsp;node_taints | list(string) | Optional |  |  |
|&nbsp;only_critical_addons_enabled | bool | Optional |  |  |
|&nbsp;os_disk_size_gb | string | Optional |  |  |
|&nbsp;os_disk_type | string | Optional |  |  |
|&nbsp;pod_subnet_id | string | Optional |  |  |
|&nbsp;temporary_name_for_rotation | string | Optional |  |  |
|&nbsp;type | string | Optional |  |  |
|&nbsp;ultra_ssd_enabled | string | Optional |  |  |
|&nbsp;vnet_subnet_id | string | Optional |  |  |
|&nbsp;zones | list(string) | Optional |  |  |
|&nbsp;max_count | number | Optional |  |  |
|&nbsp;min_count | number | Optional |  |  |
|&nbsp;node_count | number | Optional |  |  |
|&nbsp;tags | map(any) | Optional |  |  |
|dns_prefix | string | Optional |  |  |
|dns_prefix_private_cluster | string | Optional |  |  |
|automatic_channel_upgrade | string | Optional |  |  |
|azure_active_directory_role_based_access_control | object | Optional |  |  |
|&nbsp;managed | bool | Optional |  |  |
|&nbsp;admin_group_object_ids | list(string) | Optional |  |  |
|&nbsp;&nbsp;azure_rbac_enabled | bool | Optional |  |  |
|&nbsp;azure_policy_enabled | bool | Optional |  |  |
|&nbsp;identity | object | Optional |  |  |
|&nbsp;&nbsp;type | string | Required |  |  |
|&nbsp;&nbsp;identity_ids | list(string) | Optional |  |  |
|&nbsp;image_cleaner_enabled | string | Optional |  |  |
|&nbsp;key_vault_secrets_provider | object | Optional |  |  |
|&nbsp;&nbsp;secret_rotation_enabled | bool | Optional |  |  |
|&nbsp;kubernetes_version | string | Optional |  |  |
|&nbsp;linux_profile | object | Optional |  |  |
|&nbsp;&nbsp;admin_username | string | Required |  |  |
|&nbsp;&nbsp;ssh_key | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;key_data | string | Required |  |  |
|&nbsp;local_account_disabled | bool | Optional |  |  |
|&nbsp;network_profile | object | Optional |  |  |
|&nbsp;&nbsp;network_plugin | string | Required |  |  |
|&nbsp;&nbsp;network_policy | string | Optional |  |  |
|&nbsp;&nbsp;dns_service_ip | string | Optional |  |  |
|&nbsp;&nbsp;docker_bridge_cidr | string | Optional |  |  |
|&nbsp;&nbsp;network_plugin_mode | string | Optional |  |  |
|&nbsp;&nbsp;outbound_type | string | Optional |  |  |
|&nbsp;&nbsp;pod_cidr | string | Optional |  |  |
|&nbsp;&nbsp;service_cidr | string | Optional |  |  |
|&nbsp;&nbsp;load_balancer_sku | string | Optional |  |  |
|&nbsp;node_resource_group | string | Optional |  |  |
|&nbsp;oidc_issuer_enabled | bool | Optional |  |  |
|&nbsp;oms_agent | object | Optional |  |  |
|&nbsp;&nbsp;log_analytics_workspace_id | string | Required |  |  |
|&nbsp;private_cluster_enabled | bool | Optional |  |  |
|&nbsp;private_dns_zone_id | string | Optional |  |  |
|&nbsp;private_cluster_public_fqdn_enabled | string | Optional |  |  |
|&nbsp;workload_autoscaler_profile | object | Optional |  |  |
|&nbsp;&nbsp;keda_enabled | bool | Optional |  |  |
|&nbsp;workload_identity_enabled | bool | Optional |  |  |
|&nbsp;public_network_access_enabled | bool | Optional |  |  |
|&nbsp;role_based_access_control_enabled | bool | Optional |  |  |
|&nbsp;sku_tier | string | Optional |  |  |
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
|&nbsp;&nbsp;vm_size | string | Required |  |  |
|&nbsp;&nbsp;enable_auto_scaling | bool | Optional |  |  |
|&nbsp;&nbsp;enable_host_encryption | bool | Optional |  |  |
|&nbsp;&nbsp;enable_node_public_ip | bool | Optional |  |  |
|&nbsp;&nbsp;max_pods | number | Optional |  |  |
|&nbsp;&nbsp;node_labels | map(any) | Optional |  |  |
|&nbsp;&nbsp;node_public_ip_prefix_id | string | Optional |  |  |
|&nbsp;&nbsp;node_taints | list(string) | Optional |  |  |
|&nbsp;&nbsp;os_disk_size_gb | string | Optional |  |  |
|&nbsp;&nbsp;os_disk_type | string | Optional |  |  |
|&nbsp;&nbsp;pod_subnet_id | string | Optional |  |  |
|&nbsp;&nbsp;ultra_ssd_enabled | string | Optional |  |  |
|&nbsp;&nbsp;vnet_subnet_id | string | Optional |  |  |
|&nbsp;&nbsp;zones | list(string) | Optional |  |  |
|&nbsp;&nbsp;max_count | number | Optional |  |  |
|&nbsp;&nbsp;min_count | number | Optional |  |  |
|&nbsp;&nbsp;node_count | number | Optional |  |  |
|&nbsp;&nbsp;tags | map(any) | Optional |  |  |
|&nbsp;monitoring | list(object) | Optional | [] |  Custom object for enabling diagnostic settings |
|&nbsp;&nbsp;diag_name | string | Optional |  |  Name of the diagnostic setting |
|&nbsp;&nbsp;log_analytics_workspace_id | string | Optional |  |  |
|&nbsp;&nbsp;eventhub_name | string | Optional |  |  |
|&nbsp;&nbsp;eventhub_authorization_rule_id | string | Optional |  |  |


