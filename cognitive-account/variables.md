# Variables

```
variable "config" {  type = list(object({
    # cognitive account
    name                       = string
    resource_group_name        = string
    location                   = string
    kind                       = string
    sku_name                   = string
    custom_subdomain_name      = optional(string)
    dynamic_throttling_enabled = optional(bool)
    customer_managed_key = optional(object({
      key_vault_key_id   = string
      identity_client_id = optional(string)
    }))
    fqdns = optional(list(string))
    identity = optional(object({
      type         = string
      identity_ids = optional(list(string))
    }))
    local_auth_enabled              = optional(bool)
    metrics_advisor_aad_client_id   = optional(string)
    metrics_advisor_aad_tenant_id   = optional(string)
    metrics_advisor_super_user_name = optional(string)
    metrics_advisor_website_name    = optional(string)
    network_acls = optional(object({
      default_action = string
      ip_rules       = optional(list(string))
      virtual_network_rules = optional(list(object({
        subnet_id                            = string
        ignore_missing_vnet_service_endpoint = optional(bool)
      })), [])
    }))
    outbound_network_access_restricted           = optional(bool)
    public_network_access_enabled                = optional(bool, false)
    qna_runtime_endpoint                         = optional(string)
    custom_question_answering_search_service_id  = optional(string)
    custom_question_answering_search_service_key = optional(string)
    storage = optional(object({
      storage_account_id = string
      identity_client_id = optional(string)
    }))
    tags = optional(map(any))

    # cognitive deployment
    cognitive_deployment = optional(list(object({
      name                 = string
      cognitive_account_id = optional(string) # Inherited in module from parent resource
      model = object({
        format  = string
        name    = string
        version = optional(string)
      })
      sku = object({
        name     = string
        tier     = optional(string)
        size     = optional(string)
        family   = optional(string)
        capacity = optional(number)
      })
      dynamic_throttling_enabled = optional(bool)
      rai_policy_name            = optional(string)
      version_upgrade_option     = optional(string)
    })), [])

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
        audit                      = optional(bool, true)
        request_response           = optional(bool, true)
        trace                      = optional(bool, true)
        azure_openai_request_usage = optional(bool, true)
        all_metrics                = optional(bool, true)
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
|kind | string | Required |  |  |
|sku_name | string | Required |  |  |
|custom_subdomain_name | string | Optional |  |  |
|dynamic_throttling_enabled | bool | Optional |  |  |
|customer_managed_key | object | Optional |  |  |
|&nbsp;key_vault_key_id | string | Required |  |  |
|&nbsp;identity_client_id | string | Optional |  |  |
|fqdns | list(string) | Optional |  |  |
|identity | object | Optional |  |  |
|&nbsp;type | string | Required |  |  |
|&nbsp;identity_ids | list(string) | Optional |  |  |
|local_auth_enabled | bool | Optional |  |  |
|metrics_advisor_aad_client_id | string | Optional |  |  |
|metrics_advisor_aad_tenant_id | string | Optional |  |  |
|metrics_advisor_super_user_name | string | Optional |  |  |
|metrics_advisor_website_name | string | Optional |  |  |
|network_acls | object | Optional |  |  |
|&nbsp;default_action | string | Required |  |  |
|&nbsp;ip_rules | list(string) | Optional |  |  |
|&nbsp;virtual_network_rules | list(object) | Optional | [] |  |
|&nbsp;&nbsp;subnet_id | string | Required |  |  |
|&nbsp;&nbsp;ignore_missing_vnet_service_endpoint | bool | Optional |  |  |
|outbound_network_access_restricted | bool | Optional |  |  |
|public_network_access_enabled | bool | Optional |  false |  |
|qna_runtime_endpoint | string | Optional |  |  |
|custom_question_answering_search_service_id | string | Optional |  |  |
|custom_question_answering_search_service_key | string | Optional |  |  |
|storage | object | Optional |  |  |
|&nbsp;storage_account_id | string | Required |  |  |
|&nbsp;identity_client_id | string | Optional |  |  |
|tags | map(any) | Optional |  |  |
|cognitive_deployment | list(object) | Optional | [] |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;cognitive_account_id | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;model | object | Required |  |  |
|&nbsp;&nbsp;format | string | Required |  |  |
|&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;version | string | Optional |  |  |
|&nbsp;sku | object | Required |  |  |
|&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;tier | string | Optional |  |  |
|&nbsp;&nbsp;size | string | Optional |  |  |
|&nbsp;&nbsp;family | string | Optional |  |  |
|&nbsp;&nbsp;capacity | number | Optional |  |  |
|&nbsp;dynamic_throttling_enabled | bool | Optional |  |  |
|&nbsp;rai_policy_name | string | Optional |  |  |
|&nbsp;version_upgrade_option | string | Optional |  |  |
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
|&nbsp;&nbsp;audit | bool | Optional |  true |  |
|&nbsp;&nbsp;request_response | bool | Optional |  true |  |
|&nbsp;&nbsp;trace | bool | Optional |  true |  |
|&nbsp;&nbsp;azure_openai_request_usage | bool | Optional |  true |  |
|&nbsp;&nbsp;all_metrics | bool | Optional |  true |  |


