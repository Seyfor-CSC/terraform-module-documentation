# Variables

```
variable "config" {  type = list(object({
    # monitor data collection rule
    name                = string
    resource_group_name = string
    location            = string
    data_flow = list(object({
      destinations       = list(string)
      streams            = list(string)
      built_in_transform = optional(string)
      output_stream      = optional(string)
      transform_kql      = optional(string)
    }))
    destinations = object({
      azure_monitor_metrics = optional(object({
        name = string
      }))
      event_hub = optional(list(object({
        event_hub_id = string
        name         = string
      })), [])
      event_hub_direct = optional(list(object({
        event_hub_id = string
        name         = string
      })), [])
      log_analytics = optional(list(object({
        name                  = string
        workspace_resource_id = string
      })), [])
      monitor_account = optional(list(object({
        monitor_account_id = string
        name               = string
      })), [])
      storage_blob = optional(list(object({
        container_name     = string
        name               = string
        storage_account_id = string
      })), [])
      storage_blob_direct = optional(list(object({
        container_name     = string
        name               = string
        storage_account_id = string
      })), [])
      storage_table_direct = optional(list(object({
        table_name         = string
        name               = string
        storage_account_id = string
      })), [])
    })
    data_collection_endpoint_id = optional(string)
    data_sources = optional(object({
      data_import = optional(object({
        event_hub_data_source = object({
          name           = string
          stream         = string
          consumer_group = optional(string)
        })
      }))
      extension = optional(list(object({
        extension_name     = string
        name               = string
        streams            = list(string)
        extension_json     = optional(string)
        input_data_sources = optional(list(string))
      })), [])
      iis_log = optional(list(object({
        name            = string
        streams         = list(string)
        log_directories = optional(list(string))
      })), [])
      log_file = optional(list(object({
        name          = string
        streams       = list(string)
        file_patterns = list(string)
        format        = string
        settings = optional(object({
          text = object({
            record_start_timestamp_format = string
          })
        }))
      })), [])
      performance_counter = optional(list(object({
        counter_specifiers            = list(string)
        name                          = string
        sampling_frequency_in_seconds = number
        streams                       = list(string)
      })), [])
      platform_telemetry = optional(list(object({
        name    = string
        streams = list(string)
      })), [])
      prometheus_forwarder = optional(list(object({
        name    = string
        streams = list(string)
        label_include_filter = optional(list(object({
          label = string
          value = string
        })), [])
      })), [])
      syslog = optional(list(object({
        facility_names = list(string)
        log_levels     = list(string)
        name           = string
        streams        = optional(list(string))
      })), [])
      windows_event_log = optional(list(object({
        name           = string
        streams        = list(string)
        x_path_queries = list(string)
      })), [])
      windows_firewall_log = optional(list(object({
        name    = string
        streams = list(string)
      })), [])
    }))
    description = optional(string)
    identity = optional(object({
      type         = string
      identity_ids = optional(list(string))
    }))
    kind = optional(string)
    stream_declaration = optional(object({
      stream_name = string
      column = list(object({
        name = string
        type = string
      }))
    }))
    tags = optional(map(any))

    # monitoring
    monitoring = optional(list(object({                 # Custom object for enabling diagnostic settings
      diag_name                      = optional(string) # Name of the diagnostic setting
      log_analytics_workspace_id     = optional(string)
      eventhub_name                  = optional(string)
      eventhub_authorization_rule_id = optional(string)
      categories = optional(object({
        log_errors  = optional(bool, true)
        all_metrics = optional(bool, true)
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
|data_flow | list(object) | Required |  |  |
|&nbsp;destinations | list(string) | Required |  |  |
|&nbsp;streams | list(string) | Required |  |  |
|&nbsp;built_in_transform | string | Optional |  |  |
|&nbsp;output_stream | string | Optional |  |  |
|&nbsp;transform_kql | string | Optional |  |  |
|destinations | object | Required |  |  |
|&nbsp;azure_monitor_metrics | object | Optional |  |  |
|&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;event_hub | list(object) | Optional | [] |  |
|&nbsp;&nbsp;event_hub_id | string | Required |  |  |
|&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;event_hub_direct | list(object) | Optional | [] |  |
|&nbsp;&nbsp;event_hub_id | string | Required |  |  |
|&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;log_analytics | list(object) | Optional | [] |  |
|&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;workspace_resource_id | string | Required |  |  |
|&nbsp;monitor_account | list(object) | Optional | [] |  |
|&nbsp;&nbsp;monitor_account_id | string | Required |  |  |
|&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;storage_blob | list(object) | Optional | [] |  |
|&nbsp;&nbsp;container_name | string | Required |  |  |
|&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;storage_account_id | string | Required |  |  |
|&nbsp;storage_blob_direct | list(object) | Optional | [] |  |
|&nbsp;&nbsp;container_name | string | Required |  |  |
|&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;storage_account_id | string | Required |  |  |
|&nbsp;storage_table_direct | list(object) | Optional | [] |  |
|&nbsp;&nbsp;table_name | string | Required |  |  |
|&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;storage_account_id | string | Required |  |  |
|data_collection_endpoint_id | string | Optional |  |  |
|data_sources | object | Optional |  |  |
|&nbsp;data_import | object | Optional |  |  |
|&nbsp;&nbsp;event_hub_data_source | object | Required |  |  |
|&nbsp;&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;stream | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;consumer_group | string | Optional |  |  |
|&nbsp;extension | list(object) | Optional | [] |  |
|&nbsp;&nbsp;extension_name | string | Required |  |  |
|&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;streams | list(string) | Required |  |  |
|&nbsp;&nbsp;extension_json | string | Optional |  |  |
|&nbsp;&nbsp;input_data_sources | list(string) | Optional |  |  |
|&nbsp;iis_log | list(object) | Optional | [] |  |
|&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;streams | list(string) | Required |  |  |
|&nbsp;&nbsp;log_directories | list(string) | Optional |  |  |
|&nbsp;log_file | list(object) | Optional | [] |  |
|&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;streams | list(string) | Required |  |  |
|&nbsp;&nbsp;file_patterns | list(string) | Required |  |  |
|&nbsp;&nbsp;format | string | Required |  |  |
|&nbsp;&nbsp;settings | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;text | object | Required |  |  |
|&nbsp;&nbsp;&nbsp;&nbsp;record_start_timestamp_format | string | Required |  |  |
|&nbsp;performance_counter | list(object) | Optional | [] |  |
|&nbsp;&nbsp;counter_specifiers | list(string) | Required |  |  |
|&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;sampling_frequency_in_seconds | number | Required |  |  |
|&nbsp;&nbsp;streams | list(string) | Required |  |  |
|&nbsp;platform_telemetry | list(object) | Optional | [] |  |
|&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;streams | list(string) | Required |  |  |
|&nbsp;prometheus_forwarder | list(object) | Optional | [] |  |
|&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;streams | list(string) | Required |  |  |
|&nbsp;&nbsp;label_include_filter | list(object) | Optional | [] |  |
|&nbsp;&nbsp;&nbsp;label | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;value | string | Required |  |  |
|&nbsp;syslog | list(object) | Optional | [] |  |
|&nbsp;&nbsp;facility_names | list(string) | Required |  |  |
|&nbsp;&nbsp;log_levels | list(string) | Required |  |  |
|&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;streams | list(string) | Optional |  |  |
|&nbsp;windows_event_log | list(object) | Optional | [] |  |
|&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;streams | list(string) | Required |  |  |
|&nbsp;&nbsp;x_path_queries | list(string) | Required |  |  |
|&nbsp;windows_firewall_log | list(object) | Optional | [] |  |
|&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;streams | list(string) | Required |  |  |
|description | string | Optional |  |  |
|identity | object | Optional |  |  |
|&nbsp;type | string | Required |  |  |
|&nbsp;identity_ids | list(string) | Optional |  |  |
|kind | string | Optional |  |  |
|stream_declaration | object | Optional |  |  |
|&nbsp;stream_name | string | Required |  |  |
|&nbsp;column | list(object) | Required |  |  |
|&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;type | string | Required |  |  |
|tags | map(any) | Optional |  |  |
|monitoring | list(object) | Optional | [] |  Custom object for enabling diagnostic settings |
|&nbsp;diag_name | string | Optional |  |  Name of the diagnostic setting |
|&nbsp;log_analytics_workspace_id | string | Optional |  |  |
|&nbsp;eventhub_name | string | Optional |  |  |
|&nbsp;eventhub_authorization_rule_id | string | Optional |  |  |
|&nbsp;categories | object | Optional |  |  |
|&nbsp;&nbsp;log_errors | bool | Optional |  true |  |
|&nbsp;&nbsp;all_metrics | bool | Optional |  true |  |


