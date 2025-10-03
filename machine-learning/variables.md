# Variables

```
variable "config" {  type = list(object({
    # machine learning workspace
    name                    = string
    resource_group_name     = string
    location                = string
    application_insights_id = string
    key_vault_id            = string
    storage_account_id      = string
    identity = object({
      type         = string
      identity_ids = optional(list(string))
    })
    kind                          = optional(string)
    container_registry_id         = optional(string)
    public_network_access_enabled = optional(bool, false)
    image_build_compute_name      = optional(string)
    description                   = optional(string)
    encryption = optional(object({
      key_vault_id              = string
      key_id                    = string
      user_assigned_identity_id = optional(string)
    }))
    managed_network = optional(object({
      isolation_mode                = optional(string)
      provision_on_creation_enabled = optional(bool)
    }))
    feature_store = optional(object({
      computer_spark_runtime_version = optional(string)
      offline_connection_name        = optional(string)
      online_connection_name         = optional(string)
    }))
    friendly_name                  = optional(string)
    high_business_impact           = optional(bool)
    primary_user_assigned_identity = optional(string)
    v1_legacy_mode_enabled         = optional(bool)
    sku_name                       = optional(string)
    serverless_compute = optional(object({
      subnet_id         = optional(string)
      public_ip_enabled = optional(bool)
    }))
    tags = optional(map(any))

    # private endpoint
    private_endpoint = optional(list(object({
      name                = string
      resource_group_name = optional(string) # If not provided, inherited in module from parent resource
      location            = optional(string) # If not provided, inherited in module from parent resource
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
      private_dns_zone_group = optional(object({
        name                 = string
        private_dns_zone_ids = list(string)
      }))
      ip_configuration = optional(list(object({
        name               = string
        private_ip_address = string
        subresource_name   = string
        member_name        = optional(string)
      })), [])
      tags = optional(map(any)) # If not provided, inherited in module from parent resource
    })), [])

    # monitoring
    monitoring = optional(list(object({                 # Custom object for enabling diagnostic settings
      diag_name                      = optional(string) # Name of the diagnostic setting
      log_analytics_workspace_id     = optional(string)
      eventhub_name                  = optional(string)
      eventhub_authorization_rule_id = optional(string)
      storage_account_id             = optional(string)
      categories = optional(object({
        aml_compute_cluster_event       = optional(bool, true)
        aml_compute_cluster_node_event  = optional(bool, true)
        aml_compute_job_event           = optional(bool, true)
        aml_compute_cpu_gpu_utilization = optional(bool, true)
        aml_run_status_changed_event    = optional(bool, true)
        models_change_event             = optional(bool, true)
        models_read_event               = optional(bool, true)
        models_action_event             = optional(bool, true)
        deployment_read_event           = optional(bool, true)
        deployment_event_aci            = optional(bool, true)
        deployment_event_aks            = optional(bool, true)
        inferencing_operation_aks       = optional(bool, true)
        inferencing_operation_aci       = optional(bool, true)
        environment_change_event        = optional(bool, true)
        environment_read_event          = optional(bool, true)
        data_label_change_event         = optional(bool, true)
        data_label_read_event           = optional(bool, true)
        compute_instance_event          = optional(bool, true)
        data_store_echange_event        = optional(bool, true)
        data_store_read_event           = optional(bool, true)
        data_set_change_event           = optional(bool, true)
        data_set_read_event             = optional(bool, true)
        pipeline_change_event           = optional(bool, true)
        pipeline_read_event             = optional(bool, true)
        run_event                       = optional(bool, true)
        run_read_event                  = optional(bool, true)
        all_metrics                     = optional(bool, true)
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
|application_insights_id | string | Required |  |  |
|key_vault_id | string | Required |  |  |
|storage_account_id | string | Required |  |  |
|identity | object | Required |  |  |
|&nbsp;type | string | Required |  |  |
|&nbsp;identity_ids | list(string) | Optional |  |  |
|kind | string | Optional |  |  |
|container_registry_id | string | Optional |  |  |
|public_network_access_enabled | bool | Optional |  false |  |
|image_build_compute_name | string | Optional |  |  |
|description | string | Optional |  |  |
|encryption | object | Optional |  |  |
|&nbsp;key_vault_id | string | Required |  |  |
|&nbsp;key_id | string | Required |  |  |
|&nbsp;user_assigned_identity_id | string | Optional |  |  |
|managed_network | object | Optional |  |  |
|&nbsp;isolation_mode | string | Optional |  |  |
|&nbsp;provision_on_creation_enabled | bool | Optional |  |  |
|feature_store | object | Optional |  |  |
|&nbsp;computer_spark_runtime_version | string | Optional |  |  |
|&nbsp;offline_connection_name | string | Optional |  |  |
|&nbsp;online_connection_name | string | Optional |  |  |
|friendly_name | string | Optional |  |  |
|high_business_impact | bool | Optional |  |  |
|primary_user_assigned_identity | string | Optional |  |  |
|v1_legacy_mode_enabled | bool | Optional |  |  |
|sku_name | string | Optional |  |  |
|serverless_compute | object | Optional |  |  |
|&nbsp;subnet_id | string | Optional |  |  |
|&nbsp;public_ip_enabled | bool | Optional |  |  |
|tags | map(any) | Optional |  |  |
|private_endpoint | list(object) | Optional | [] |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;resource_group_name | string | Optional |  |  If not provided, inherited in module from parent resource |
|&nbsp;location | string | Optional |  |  If not provided, inherited in module from parent resource |
|&nbsp;subnet_id | string | Required |  |  |
|&nbsp;private_service_connection | list(object) | Required |  |  |
|&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;is_manual_connection | bool | Required |  |  |
|&nbsp;&nbsp;private_connection_resource_id | string | Optional |  |  |
|&nbsp;&nbsp;private_connection_resource_alias | string | Optional |  |  |
|&nbsp;&nbsp;subresource_names | list(string) | Optional |  |  |
|&nbsp;&nbsp;request_message | string | Optional |  |  |
|&nbsp;custom_network_interface_name | string | Optional |  |  |
|&nbsp;private_dns_zone_group | object | Optional |  |  |
|&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;private_dns_zone_ids | list(string) | Required |  |  |
|&nbsp;ip_configuration | list(object) | Optional | [] |  |
|&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;private_ip_address | string | Required |  |  |
|&nbsp;&nbsp;subresource_name | string | Required |  |  |
|&nbsp;&nbsp;member_name | string | Optional |  |  |
|&nbsp;tags | map(any) | Optional |  |  If not provided, inherited in module from parent resource |
|monitoring | list(object) | Optional | [] |  Custom object for enabling diagnostic settings |
|&nbsp;diag_name | string | Optional |  |  Name of the diagnostic setting |
|&nbsp;log_analytics_workspace_id | string | Optional |  |  |
|&nbsp;eventhub_name | string | Optional |  |  |
|&nbsp;eventhub_authorization_rule_id | string | Optional |  |  |
|&nbsp;storage_account_id | string | Optional |  |  |
|&nbsp;categories | object | Optional |  |  |
|&nbsp;&nbsp;aml_compute_cluster_event | bool | Optional |  true |  |
|&nbsp;&nbsp;aml_compute_cluster_node_event | bool | Optional |  true |  |
|&nbsp;&nbsp;aml_compute_job_event | bool | Optional |  true |  |
|&nbsp;&nbsp;aml_compute_cpu_gpu_utilization | bool | Optional |  true |  |
|&nbsp;&nbsp;aml_run_status_changed_event | bool | Optional |  true |  |
|&nbsp;&nbsp;models_change_event | bool | Optional |  true |  |
|&nbsp;&nbsp;models_read_event | bool | Optional |  true |  |
|&nbsp;&nbsp;models_action_event | bool | Optional |  true |  |
|&nbsp;&nbsp;deployment_read_event | bool | Optional |  true |  |
|&nbsp;&nbsp;deployment_event_aci | bool | Optional |  true |  |
|&nbsp;&nbsp;deployment_event_aks | bool | Optional |  true |  |
|&nbsp;&nbsp;inferencing_operation_aks | bool | Optional |  true |  |
|&nbsp;&nbsp;inferencing_operation_aci | bool | Optional |  true |  |
|&nbsp;&nbsp;environment_change_event | bool | Optional |  true |  |
|&nbsp;&nbsp;environment_read_event | bool | Optional |  true |  |
|&nbsp;&nbsp;data_label_change_event | bool | Optional |  true |  |
|&nbsp;&nbsp;data_label_read_event | bool | Optional |  true |  |
|&nbsp;&nbsp;compute_instance_event | bool | Optional |  true |  |
|&nbsp;&nbsp;data_store_echange_event | bool | Optional |  true |  |
|&nbsp;&nbsp;data_store_read_event | bool | Optional |  true |  |
|&nbsp;&nbsp;data_set_change_event | bool | Optional |  true |  |
|&nbsp;&nbsp;data_set_read_event | bool | Optional |  true |  |
|&nbsp;&nbsp;pipeline_change_event | bool | Optional |  true |  |
|&nbsp;&nbsp;pipeline_read_event | bool | Optional |  true |  |
|&nbsp;&nbsp;run_event | bool | Optional |  true |  |
|&nbsp;&nbsp;run_read_event | bool | Optional |  true |  |
|&nbsp;&nbsp;all_metrics | bool | Optional |  true |  |


