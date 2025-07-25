# Variables

```
variable "config" {  type = list(object({
    # web app
    os_type             = string # Custom variable. Possible values are "Windows" or "Linux"
    name                = string
    resource_group_name = string
    location            = string
    service_plan_id     = string
    site_config = object({
      application_stack = optional(object({
        current_stack                = optional(string) # Windows Web App only
        docker_image_name            = optional(string)
        docker_registry_url          = optional(string)
        docker_registry_username     = optional(string)
        docker_registry_password     = optional(string)
        dotnet_version               = optional(string)
        dotnet_core_version          = optional(string) # Windows Web App only
        go_version                   = optional(string) # Linux Web App only
        tomcat_version               = optional(string) # Windows Web App only
        java_embedded_server_enabled = optional(bool)   # Windows Web App only
        java_version                 = optional(string) # Windows Web App only
        java_server                  = optional(string) # Linux Web App only
        java_server_version          = optional(string) # Linux Web App only
        node_version                 = optional(string)
        php_version                  = optional(string)
        python                       = optional(bool)   # Windows Web App only
        python_version               = optional(string) # Linux Web App only
        ruby_version                 = optional(string) # Linux Web App only
      }))
      cors = optional(object({
        allowed_origins     = list(string)
        support_credentials = optional(bool)
      }))
      ftps_state = optional(string)
      http2_enabled = optional(bool)
      ip_restriction = optional(list(object({
        name   = optional(string)
        action = optional(string)
        headers = optional(object({
          x_azure_fdid      = optional(list(string))
          x_fd_health_probe = optional(number)
          x_forwarded_for   = optional(list(string))
          x_forwarded_host  = optional(list(string))
        }))
        ip_address                = optional(string)
        priority                  = optional(number)
        service_tag               = optional(string)
        virtual_network_subnet_id = optional(string)
        description               = optional(string)
      })), [])
      ip_restriction_default_action = optional(string)
      scm_ip_restriction = optional(list(object({
        action = optional(string)
        headers = optional(object({
          x_azure_fdid      = optional(list(string))
          x_fd_health_probe = optional(number)
          x_forwarded_for   = optional(list(string))
          x_forwarded_host  = optional(list(string))
        }))
        ip_address                = optional(string)
        name                      = optional(string)
        priority                  = optional(number)
        service_tag               = optional(string)
        virtual_network_subnet_id = optional(string)
        description               = optional(string)
      })), [])
      scm_ip_restriction_default_action = optional(string)
      scm_minimum_tls_version           = optional(string)
      scm_use_main_ip_restriction       = optional(bool)
      use_32_bit_worker                 = optional(bool)
      vnet_route_all_enabled = optional(bool)
    })
    app_settings = optional(map(any))
    auth_settings_v2 = optional(object({
      auth_enabled                            = optional(bool)
      runtime_version                         = optional(string)
      config_file_path                        = optional(string)
      require_authentication                  = optional(bool)
      unauthenticated_action                  = optional(string)
      default_provider                        = optional(string)
      excluded_paths                          = optional(list(string))
      require_https                           = optional(bool)
      http_route_api_prefix                   = optional(string)
      forward_proxy_convention                = optional(string)
      forward_proxy_custom_host_header_name   = optional(string)
      forward_proxy_custom_scheme_header_name = optional(string)
      apple_v2 = optional(object({
        client_id                  = string
        client_secret_setting_name = string
        login_scopes               = optional(list(string))
      }))
      active_directory_v2 = optional(object({
        client_id                            = string
        tenant_auth_endpoint                 = string
        client_secret_setting_name           = optional(string)
        client_secret_certificate_thumbprint = optional(string)
        jwt_allowed_groups                   = optional(list(string))
        jwt_allowed_client_applications      = optional(list(string))
        www_authentication_disabled          = optional(bool)
        allowed_groups                       = optional(list(string))
        allowed_identities                   = optional(list(string))
        allowed_applications                 = optional(list(string))
        login_parameters                     = optional(map(string))
        allowed_audiences                    = optional(list(string))
      }))
      azure_static_web_app_v2 = optional(object({
        client_id = string
      }))
      custom_oidc_v2 = optional(list(object({
        name                          = string
        client_id                     = string
        openid_configuration_endpoint = string
        name_claim_type               = optional(string)
        scopes                        = optional(list(string))
        client_credential_method      = optional(string)
        client_secret_setting_name    = optional(string)
        authorisation_endpoint        = optional(string)
        token_endpoint                = optional(string)
        issuer_endpoint               = optional(string)
        certification_uri             = optional(string)
      })), [])
      facebook_v2 = optional(object({
        app_id                  = string
        app_secret_setting_name = string
        graph_api_version       = optional(string)
        login_scopes            = optional(list(string))
      }))
      github_v2 = optional(object({
        client_id                  = string
        client_secret_setting_name = string
        login_scopes               = optional(list(string))
      }))
      google_v2 = optional(object({
        client_id                  = string
        client_secret_setting_name = string
        allowed_audiences          = optional(list(string))
        login_scopes               = optional(list(string))
      }))
      microsoft_v2 = optional(object({
        client_id                  = string
        client_secret_setting_name = string
        allowed_audiences          = optional(list(string))
        login_scopes               = optional(list(string))
      }))
      twitter_v2 = optional(object({
        consumer_key                 = string
        consumer_secret_setting_name = string
      }))
      login = optional(object({
        logout_endpoint                   = optional(string)
        token_store_enabled               = optional(bool)
        token_refresh_extension_time      = optional(number)
        token_store_path                  = optional(string)
        token_store_sas_setting_name      = optional(string)
        preserve_url_fragments_for_logins = optional(bool)
        allowed_external_redirect_urls    = optional(list(string))
        cookie_expiration_convention      = optional(string)
        cookie_expiration_time            = optional(string)
        validate_nonce                    = optional(bool)
        nonce_expiration_time             = optional(string)
      }))
    }))
    backup = optional(object({
      name = string
      schedule = object({
        frequency_interval       = number
        frequency_unit           = string
        keep_at_least_one_backup = optional(bool)
        retention_period_days    = optional(number)
        start_time               = optional(string)
      })
      storage_account_url = string
      enabled             = optional(bool)
    }))
    client_affinity_enabled = optional(bool)
    connection_string = optional(list(object({
      name  = string
      type  = string
      value = string
    })), [])
    https_only                    = optional(bool)
    public_network_access_enabled = optional(bool, false)
    identity = optional(object({
      type         = string
      identity_ids = optional(list(string))
    }))
    key_vault_reference_identity_id = optional(string)
    logs = optional(object({
      application_logs = optional(object({
        azure_blob_storage = optional(object({
          level             = string
          retention_in_days = number
          sas_url           = string
        }))
        file_system_level = string
      }))
      detailed_error_messages = optional(bool)
      failed_request_tracing  = optional(bool)
      http_logs = optional(object({
        azure_blob_storage = optional(object({
          retention_in_days = optional(number)
          sas_url           = string
        }))
        file_system = optional(object({
          retention_in_days = number
          retention_in_mb   = number
        }))
      }))
    }))
    sticky_settings = optional(object({
      app_setting_names       = optional(list(string))
      connection_string_names = optional(list(string))
    }))
    virtual_network_backup_restore_enabled = optional(bool)
    virtual_network_subnet_id              = optional(string)
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
        app_service_http_logs                 = optional(bool, true)
        app_service_console_logs              = optional(bool, true)
        app_service_app_logs                  = optional(bool, true)
        app_service_audit_logs                = optional(bool, true)
        app_service_ip_sec_audit_logs         = optional(bool, true)
        app_service_platform_logs             = optional(bool, true)
        app_service_antivirus_scan_audit_logs = optional(bool, true)
        app_service_file_audit_logs           = optional(bool, true)
        app_service_authentication_logs       = optional(bool, false)
        all_metrics                           = optional(bool, true)
      }))
    })), [])
    })
  )
}


```


## Table with config variables

| Name | Data Type | Requirement | Default Value | Comment |
| ------- | --------- | ----------- | ------------- | ------- |
|os_type | string | Required |  |  Custom variable. Possible values are "Windows" or "Linux" |
|name | string | Required |  |  |
|resource_group_name | string | Required |  |  |
|location | string | Required |  |  |
|service_plan_id | string | Required |  |  |
|site_config | object | Required |  |  |
|&nbsp;application_stack | object | Optional |  |  |
|&nbsp;&nbsp;current_stack | string | Optional |  |  Windows Web App only |
|&nbsp;&nbsp;docker_image_name | string | Optional |  |  |
|&nbsp;&nbsp;docker_registry_url | string | Optional |  |  |
|&nbsp;&nbsp;docker_registry_username | string | Optional |  |  |
|&nbsp;&nbsp;docker_registry_password | string | Optional |  |  |
|&nbsp;&nbsp;dotnet_version | string | Optional |  |  |
|&nbsp;&nbsp;dotnet_core_version | string | Optional |  |  Windows Web App only |
|&nbsp;&nbsp;go_version | string | Optional |  |  Linux Web App only |
|&nbsp;&nbsp;tomcat_version | string | Optional |  |  Windows Web App only |
|&nbsp;&nbsp;java_embedded_server_enabled | bool | Optional |  |  Windows Web App only |
|&nbsp;&nbsp;java_version | string | Optional |  |  Windows Web App only |
|&nbsp;&nbsp;java_server | string | Optional |  |  Linux Web App only |
|&nbsp;&nbsp;java_server_version | string | Optional |  |  Linux Web App only |
|&nbsp;&nbsp;node_version | string | Optional |  |  |
|&nbsp;&nbsp;php_version | string | Optional |  |  |
|&nbsp;&nbsp;python | bool | Optional |  |  Windows Web App only |
|&nbsp;&nbsp;python_version | string | Optional |  |  Linux Web App only |
|&nbsp;&nbsp;ruby_version | string | Optional |  |  Linux Web App only |
|&nbsp;cors | object | Optional |  |  |
|&nbsp;&nbsp;allowed_origins | list(string) | Required |  |  |
|&nbsp;&nbsp;support_credentials | bool | Optional |  |  |
|&nbsp;ftps_state | string | Optional |  |  |
|&nbsp;http2_enabled | bool | Optional |  |  |
|&nbsp;ip_restriction | list(object) | Optional | [] |  |
|&nbsp;&nbsp;name | string | Optional |  |  |
|&nbsp;&nbsp;action | string | Optional |  |  |
|&nbsp;&nbsp;headers | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;x_azure_fdid | list(string) | Optional |  |  |
|&nbsp;&nbsp;&nbsp;x_fd_health_probe | number | Optional |  |  |
|&nbsp;&nbsp;&nbsp;x_forwarded_for | list(string) | Optional |  |  |
|&nbsp;&nbsp;&nbsp;x_forwarded_host | list(string) | Optional |  |  |
|&nbsp;&nbsp;ip_address | string | Optional |  |  |
|&nbsp;&nbsp;priority | number | Optional |  |  |
|&nbsp;&nbsp;service_tag | string | Optional |  |  |
|&nbsp;&nbsp;virtual_network_subnet_id | string | Optional |  |  |
|&nbsp;&nbsp;description | string | Optional |  |  |
|&nbsp;ip_restriction_default_action | string | Optional |  |  |
|&nbsp;scm_ip_restriction | list(object) | Optional | [] |  |
|&nbsp;&nbsp;action | string | Optional |  |  |
|&nbsp;&nbsp;headers | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;x_azure_fdid | list(string) | Optional |  |  |
|&nbsp;&nbsp;&nbsp;x_fd_health_probe | number | Optional |  |  |
|&nbsp;&nbsp;&nbsp;x_forwarded_for | list(string) | Optional |  |  |
|&nbsp;&nbsp;&nbsp;x_forwarded_host | list(string) | Optional |  |  |
|&nbsp;&nbsp;ip_address | string | Optional |  |  |
|&nbsp;&nbsp;name | string | Optional |  |  |
|&nbsp;&nbsp;priority | number | Optional |  |  |
|&nbsp;&nbsp;service_tag | string | Optional |  |  |
|&nbsp;&nbsp;virtual_network_subnet_id | string | Optional |  |  |
|&nbsp;&nbsp;description | string | Optional |  |  |
|&nbsp;scm_ip_restriction_default_action | string | Optional |  |  |
|&nbsp;scm_minimum_tls_version | string | Optional |  |  |
|&nbsp;scm_use_main_ip_restriction | bool | Optional |  |  |
|&nbsp;use_32_bit_worker | bool | Optional |  |  |
|&nbsp;vnet_route_all_enabled | bool | Optional |  |  |
|app_settings | map(any) | Optional |  |  |
|auth_settings_v2 | object | Optional |  |  |
|&nbsp;auth_enabled | bool | Optional |  |  |
|&nbsp;runtime_version | string | Optional |  |  |
|&nbsp;config_file_path | string | Optional |  |  |
|&nbsp;require_authentication | bool | Optional |  |  |
|&nbsp;unauthenticated_action | string | Optional |  |  |
|&nbsp;default_provider | string | Optional |  |  |
|&nbsp;excluded_paths | list(string) | Optional |  |  |
|&nbsp;require_https | bool | Optional |  |  |
|&nbsp;http_route_api_prefix | string | Optional |  |  |
|&nbsp;forward_proxy_convention | string | Optional |  |  |
|&nbsp;forward_proxy_custom_host_header_name | string | Optional |  |  |
|&nbsp;forward_proxy_custom_scheme_header_name | string | Optional |  |  |
|&nbsp;apple_v2 | object | Optional |  |  |
|&nbsp;&nbsp;client_id | string | Required |  |  |
|&nbsp;&nbsp;client_secret_setting_name | string | Required |  |  |
|&nbsp;&nbsp;login_scopes | list(string) | Optional |  |  |
|&nbsp;active_directory_v2 | object | Optional |  |  |
|&nbsp;&nbsp;client_id | string | Required |  |  |
|&nbsp;&nbsp;tenant_auth_endpoint | string | Required |  |  |
|&nbsp;&nbsp;client_secret_setting_name | string | Optional |  |  |
|&nbsp;&nbsp;client_secret_certificate_thumbprint | string | Optional |  |  |
|&nbsp;&nbsp;jwt_allowed_groups | list(string) | Optional |  |  |
|&nbsp;&nbsp;jwt_allowed_client_applications | list(string) | Optional |  |  |
|&nbsp;&nbsp;www_authentication_disabled | bool | Optional |  |  |
|&nbsp;&nbsp;allowed_groups | list(string) | Optional |  |  |
|&nbsp;&nbsp;allowed_identities | list(string) | Optional |  |  |
|&nbsp;&nbsp;allowed_applications | list(string) | Optional |  |  |
|&nbsp;&nbsp;login_parameters | map(string) | Optional |  |  |
|&nbsp;&nbsp;allowed_audiences | list(string) | Optional |  |  |
|&nbsp;azure_static_web_app_v2 | object | Optional |  |  |
|&nbsp;&nbsp;client_id | string | Required |  |  |
|&nbsp;custom_oidc_v2 | list(object) | Optional | [] |  |
|&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;client_id | string | Required |  |  |
|&nbsp;&nbsp;openid_configuration_endpoint | string | Required |  |  |
|&nbsp;&nbsp;name_claim_type | string | Optional |  |  |
|&nbsp;&nbsp;scopes | list(string) | Optional |  |  |
|&nbsp;&nbsp;client_credential_method | string | Optional |  |  |
|&nbsp;&nbsp;client_secret_setting_name | string | Optional |  |  |
|&nbsp;&nbsp;authorisation_endpoint | string | Optional |  |  |
|&nbsp;&nbsp;token_endpoint | string | Optional |  |  |
|&nbsp;&nbsp;issuer_endpoint | string | Optional |  |  |
|&nbsp;&nbsp;certification_uri | string | Optional |  |  |
|&nbsp;facebook_v2 | object | Optional |  |  |
|&nbsp;&nbsp;app_id | string | Required |  |  |
|&nbsp;&nbsp;app_secret_setting_name | string | Required |  |  |
|&nbsp;&nbsp;graph_api_version | string | Optional |  |  |
|&nbsp;&nbsp;login_scopes | list(string) | Optional |  |  |
|&nbsp;github_v2 | object | Optional |  |  |
|&nbsp;&nbsp;client_id | string | Required |  |  |
|&nbsp;&nbsp;client_secret_setting_name | string | Required |  |  |
|&nbsp;&nbsp;login_scopes | list(string) | Optional |  |  |
|&nbsp;google_v2 | object | Optional |  |  |
|&nbsp;&nbsp;client_id | string | Required |  |  |
|&nbsp;&nbsp;client_secret_setting_name | string | Required |  |  |
|&nbsp;&nbsp;allowed_audiences | list(string) | Optional |  |  |
|&nbsp;&nbsp;login_scopes | list(string) | Optional |  |  |
|&nbsp;microsoft_v2 | object | Optional |  |  |
|&nbsp;&nbsp;client_id | string | Required |  |  |
|&nbsp;&nbsp;client_secret_setting_name | string | Required |  |  |
|&nbsp;&nbsp;allowed_audiences | list(string) | Optional |  |  |
|&nbsp;&nbsp;login_scopes | list(string) | Optional |  |  |
|&nbsp;twitter_v2 | object | Optional |  |  |
|&nbsp;&nbsp;consumer_key | string | Required |  |  |
|&nbsp;&nbsp;consumer_secret_setting_name | string | Required |  |  |
|&nbsp;login | object | Optional |  |  |
|&nbsp;&nbsp;logout_endpoint | string | Optional |  |  |
|&nbsp;&nbsp;token_store_enabled | bool | Optional |  |  |
|&nbsp;&nbsp;token_refresh_extension_time | number | Optional |  |  |
|&nbsp;&nbsp;token_store_path | string | Optional |  |  |
|&nbsp;&nbsp;token_store_sas_setting_name | string | Optional |  |  |
|&nbsp;&nbsp;preserve_url_fragments_for_logins | bool | Optional |  |  |
|&nbsp;&nbsp;allowed_external_redirect_urls | list(string) | Optional |  |  |
|&nbsp;&nbsp;cookie_expiration_convention | string | Optional |  |  |
|&nbsp;&nbsp;cookie_expiration_time | string | Optional |  |  |
|&nbsp;&nbsp;validate_nonce | bool | Optional |  |  |
|&nbsp;&nbsp;nonce_expiration_time | string | Optional |  |  |
|backup | object | Optional |  |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;schedule | object | Required |  |  |
|&nbsp;&nbsp;frequency_interval | number | Required |  |  |
|&nbsp;&nbsp;frequency_unit | string | Required |  |  |
|&nbsp;&nbsp;keep_at_least_one_backup | bool | Optional |  |  |
|&nbsp;&nbsp;retention_period_days | number | Optional |  |  |
|&nbsp;&nbsp;start_time | string | Optional |  |  |
|&nbsp;storage_account_url | string | Required |  |  |
|&nbsp;enabled | bool | Optional |  |  |
|client_affinity_enabled | bool | Optional |  |  |
|connection_string | list(object) | Optional | [] |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;type | string | Required |  |  |
|&nbsp;value | string | Required |  |  |
|https_only | bool | Optional |  |  |
|public_network_access_enabled | bool | Optional |  false |  |
|identity | object | Optional |  |  |
|&nbsp;type | string | Required |  |  |
|&nbsp;identity_ids | list(string) | Optional |  |  |
|key_vault_reference_identity_id | string | Optional |  |  |
|logs | object | Optional |  |  |
|&nbsp;application_logs | object | Optional |  |  |
|&nbsp;&nbsp;azure_blob_storage | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;level | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;retention_in_days | number | Required |  |  |
|&nbsp;&nbsp;&nbsp;sas_url | string | Required |  |  |
|&nbsp;&nbsp;file_system_level | string | Required |  |  |
|&nbsp;detailed_error_messages | bool | Optional |  |  |
|&nbsp;failed_request_tracing | bool | Optional |  |  |
|&nbsp;http_logs | object | Optional |  |  |
|&nbsp;&nbsp;azure_blob_storage | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;retention_in_days | number | Optional |  |  |
|&nbsp;&nbsp;&nbsp;sas_url | string | Required |  |  |
|&nbsp;&nbsp;file_system | object | Optional |  |  |
|&nbsp;&nbsp;&nbsp;retention_in_days | number | Required |  |  |
|&nbsp;&nbsp;&nbsp;retention_in_mb | number | Required |  |  |
|sticky_settings | object | Optional |  |  |
|&nbsp;app_setting_names | list(string) | Optional |  |  |
|&nbsp;connection_string_names | list(string) | Optional |  |  |
|virtual_network_backup_restore_enabled | bool | Optional |  |  |
|virtual_network_subnet_id | string | Optional |  |  |
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
|&nbsp;&nbsp;app_service_http_logs | bool | Optional |  true |  |
|&nbsp;&nbsp;app_service_console_logs | bool | Optional |  true |  |
|&nbsp;&nbsp;app_service_app_logs | bool | Optional |  true |  |
|&nbsp;&nbsp;app_service_audit_logs | bool | Optional |  true |  |
|&nbsp;&nbsp;app_service_ip_sec_audit_logs | bool | Optional |  true |  |
|&nbsp;&nbsp;app_service_platform_logs | bool | Optional |  true |  |
|&nbsp;&nbsp;app_service_antivirus_scan_audit_logs | bool | Optional |  true |  |
|&nbsp;&nbsp;app_service_file_audit_logs | bool | Optional |  true |  |
|&nbsp;&nbsp;app_service_authentication_logs | bool | Optional |  false |  |
|&nbsp;&nbsp;all_metrics | bool | Optional |  true |  |


