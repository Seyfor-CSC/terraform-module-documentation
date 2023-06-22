# Variable Structure

```
variable "config" {
  type = list(object({
    name                          = string
    resource_group_name           = string
    location                      = string
    sku_name                      = string
    public_network_access_enabled = optional(bool)
    local_authentication_enabled  = optional(bool)
    identity = optional(object({
      type         = string
      identity_ids = optional(list(string))
    }))
    encryption = optional(object({
      key_vault_key_id          = string
      user_assigned_identity_id = optional(string)
    }))

    # private endpoint
    private_endpoint = optional(list(object({
      name                = string
      resource_group_name = optional(string) # If not provided, inherited from parent resource
      location            = optional(string) # If not provided, inherited from parent resource
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
      private_dns_zone_group = optional(list(object({
        name                 = string
        private_dns_zone_ids = list(string)
      })), [])
      ip_configuration = optional(list(object({
        name               = string
        private_ip_address = string
        subresource_name   = string
        member_name        = optional(string)
      })), [])
      tags = optional(map(any))
    })), [])

    # monitoring
    monitoring = optional(list(object({ # Custom object for enabling diagnostic settings
      diag_name                      = optional(string) # Name of the diagnostic setting
      log_analytics_workspace_id     = optional(string)
      eventhub_name                  = optional(string) 
      eventhub_authorization_rule_id = optional(string) # Event Hub namespace authorization rule
    })), [])

    tags = optional(map(any))
  }))
}
```

# Table
 

| Name                                                      | Data Type    | Requirement | Default Value | Comment                                         |
| --------------------------------------------------------- | ------------ | ----------- | ------------- | ----------------------------------------------- |
| name                                                      | string       | Required    |               |                                                 |
| resource_group_name                                       | string       | Required    |               |                                                 |
| location                                                  | string       | Required    |               |                                                 |
| sku_name                                                  | string       | Required    |               |                                                 |
| public_network_access_enabled                             | bool         | Optional    |               |                                                 |
| local_authentication_enabled                              | bool         | Optional    |               |                                                 |
| identity                                                  | object       | Optional    |               |                                                 |
| &nbsp;&nbsp;type                                          | string       | Required    |               |                                                 |
| &nbsp;&nbsp;identity_ids                                  | list(string) | Optional    |               |                                                 |
| encryption                                                | object       | Optional    |               |                                                 |
| &nbsp;&nbsp;key_vault_key_id                              | string       | Required    |               |                                                 |
| &nbsp;&nbsp;user_assigned_identity_id                     | string       | Optional    |               |                                                 |
| private_endpoint                                          | list(object) | Optional    | []            |                                                 |
| &nbsp;&nbsp;name                                          | string       | Required    |               |                                                 |
| &nbsp;&nbsp;resource_group_name                           | string       | Optional    |               | If not provided, inherited from parent resource |
| &nbsp;&nbsp;location                                      | string       | Optional    |               | If not provided, inherited from parent resource |
| &nbsp;&nbsp;subnet_id                                     | string       | Required    |               |                                                 |
| &nbsp;&nbsp;private_service_connection                    | list(object) | Required    |               |                                                 |
| &nbsp;&nbsp;&nbsp;&nbsp;name                              | string       | Required    |               |                                                 |
| &nbsp;&nbsp;&nbsp;&nbsp;is_manual_connection              | bool         | Required    |               |                                                 |
| &nbsp;&nbsp;&nbsp;&nbsp;private_connection_resource_id    | string       | Optional    |               |                                                 |
| &nbsp;&nbsp;&nbsp;&nbsp;private_connection_resource_alias | string       | Optional    |               |                                                 |
| &nbsp;&nbsp;&nbsp;&nbsp;subresource_names                 | list(string) | Optional    |               |                                                 |
| &nbsp;&nbsp;&nbsp;&nbsp;request_message                   | string       | Optional    |               |                                                 |
| &nbsp;&nbsp;custom_network_interface_name                 | string       | Optional    |               |                                                 |
| &nbsp;&nbsp;private_dns_zone_group                        | list(object) | Optional    | []            |                                                 |
| &nbsp;&nbsp;&nbsp;&nbsp;name                              | string       | Required    |               |                                                 |
| &nbsp;&nbsp;&nbsp;&nbsp;private_dns_zone_ids              | list(string) | Required    |               |                                                 |
| &nbsp;&nbsp;ip_configuration                              | list(object) | Optional    | []            |                                                 |
| &nbsp;&nbsp;&nbsp;&nbsp;name                              | string       | Required    |               |                                                 |
| &nbsp;&nbsp;&nbsp;&nbsp;private_ip_address                | string       | Required    |               |                                                 |
| &nbsp;&nbsp;&nbsp;&nbsp;subresource_name                  | string       | Required    |               |                                                 |
| &nbsp;&nbsp;&nbsp;&nbsp;member_name                       | string       | Optional    |               |                                                 |
| &nbsp;&nbsp;tags                                          | map(any)     | Optional    |               |                                                 |
| monitoring                                                | list(object) | Optional    | []            | Custom block for enabling diagnostic settings   |
| &nbsp;&nbsp;diag_name                                     | string       | Optional    |               | Name of the diagnostic setting                  |
| &nbsp;&nbsp;log_analytics_workspace_id                    | string       | Optional    |               |                                                 |
| &nbsp;&nbsp;eventhub_name                                 | string       | Optional    |               |                                                 |
| &nbsp;&nbsp;eventhub_authorization_rule_id                | string       | Optional    |               | Event Hub namespace authorization rule          |
| tags                                                      | map(any)     | Optional    |               |                                                 |

