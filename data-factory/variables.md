# Variables

```
variable "config" {  type = list(object({
    # data factory
    name                = string
    resource_group_name = string
    location            = string
    github_configuration = optional(object({
      account_name       = string
      branch_name        = string
      git_url            = optional(string)
      repository_name    = string
      root_folder        = string
      publishing_enabled = optional(bool)
    }))
    global_parameter = optional(list(object({
      name  = string
      type  = string
      value = string
    })), [])
    identity = optional(object({
      type         = string
      identity_ids = optional(list(string))
    }))
    vsts_configuration = optional(object({
      account_name       = string
      branch_name        = string
      project_name       = string
      repository_name    = string
      root_folder        = string
      tenant_id          = string
      publishing_enabled = optional(bool)
    }))
    managed_virtual_network_enabled  = optional(bool)
    public_network_enabled           = optional(bool, false)
    customer_managed_key_id          = optional(string)
    customer_managed_key_identity_id = optional(string)
    purview_id                       = optional(string)
    tags                             = optional(map(any))

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
        activity_runs                           = optional(bool, true)
        pipeline_runs                           = optional(bool, true)
        trigger_runs                            = optional(bool, true)
        sandbox_pipeline_runs                   = optional(bool, true)
        sandbox_activity_runs                   = optional(bool, true)
        ssis_package_event_messages             = optional(bool, true)
        ssis_package_executable_statistics      = optional(bool, true)
        ssis_package_event_message_context      = optional(bool, true)
        ssis_package_execution_component_phases = optional(bool, true)
        ssis_package_execution_data_statistics  = optional(bool, true)
        ssis_integration_runtime_logs           = optional(bool, true)
        airflow_task_logs                       = optional(bool, true)
        airflow_worker_logs                     = optional(bool, true)
        air_flow_dag_processing_logs            = optional(bool, true)
        air_flow_scheduler_logs                 = optional(bool, true)
        air_flow_web_logs                       = optional(bool, true)
        all_metrics                             = optional(bool, true)
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
|github_configuration | object | Optional |  |  |
|&nbsp;account_name | string | Required |  |  |
|&nbsp;branch_name | string | Required |  |  |
|&nbsp;git_url | string | Optional |  |  |
|&nbsp;repository_name | string | Required |  |  |
|&nbsp;root_folder | string | Required |  |  |
|&nbsp;publishing_enabled | bool | Optional |  |  |
|global_parameter | list(object) | Optional | [] |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;type | string | Required |  |  |
|&nbsp;value | string | Required |  |  |
|identity | object | Optional |  |  |
|&nbsp;type | string | Required |  |  |
|&nbsp;identity_ids | list(string) | Optional |  |  |
|vsts_configuration | object | Optional |  |  |
|&nbsp;account_name | string | Required |  |  |
|&nbsp;branch_name | string | Required |  |  |
|&nbsp;project_name | string | Required |  |  |
|&nbsp;repository_name | string | Required |  |  |
|&nbsp;root_folder | string | Required |  |  |
|&nbsp;tenant_id | string | Required |  |  |
|&nbsp;publishing_enabled | bool | Optional |  |  |
|managed_virtual_network_enabled | bool | Optional |  |  |
|public_network_enabled | bool | Optional |  false |  |
|customer_managed_key_id | string | Optional |  |  |
|customer_managed_key_identity_id | string | Optional |  |  |
|purview_id | string | Optional |  |  |
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
|&nbsp;&nbsp;activity_runs | bool | Optional |  true |  |
|&nbsp;&nbsp;pipeline_runs | bool | Optional |  true |  |
|&nbsp;&nbsp;trigger_runs | bool | Optional |  true |  |
|&nbsp;&nbsp;sandbox_pipeline_runs | bool | Optional |  true |  |
|&nbsp;&nbsp;sandbox_activity_runs | bool | Optional |  true |  |
|&nbsp;&nbsp;ssis_package_event_messages | bool | Optional |  true |  |
|&nbsp;&nbsp;ssis_package_executable_statistics | bool | Optional |  true |  |
|&nbsp;&nbsp;ssis_package_event_message_context | bool | Optional |  true |  |
|&nbsp;&nbsp;ssis_package_execution_component_phases | bool | Optional |  true |  |
|&nbsp;&nbsp;ssis_package_execution_data_statistics | bool | Optional |  true |  |
|&nbsp;&nbsp;ssis_integration_runtime_logs | bool | Optional |  true |  |
|&nbsp;&nbsp;airflow_task_logs | bool | Optional |  true |  |
|&nbsp;&nbsp;airflow_worker_logs | bool | Optional |  true |  |
|&nbsp;&nbsp;air_flow_dag_processing_logs | bool | Optional |  true |  |
|&nbsp;&nbsp;air_flow_scheduler_logs | bool | Optional |  true |  |
|&nbsp;&nbsp;air_flow_web_logs | bool | Optional |  true |  |
|&nbsp;&nbsp;all_metrics | bool | Optional |  true |  |


