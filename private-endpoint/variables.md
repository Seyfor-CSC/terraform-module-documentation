# Variable Structure

```
variable "config" {
  type = list(object({
    name                = string
    resource_group_name = string
    location            = string
    subnet_id           = string
    resource_id         = string
    private_service_connection = list(object({
      name                              = string
      is_manual_connection              = bool
      private_connection_resource_id    = optional(string) # Inherited in module from resource_id
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
  }))
}
```

# Table
 

| Name                                                | Data Type    | Requirement | Default Value | Comment                              |
| --------------------------------------------------- | ------------ | ----------- | ------------- | ------------------------------------ |
| &nbsp;name                                          | string       | Required    |               |                                      |
| &nbsp;resource_group_name                           | string       | Required    |               |                                      |
| &nbsp;location                                      | string       | Required    |               |                                      |
| &nbsp;subnet_id                                     | string       | Required    |               |                                      |
| &nbsp;private_service_connection                    | list(object) | Required    |               |                                      |
| &nbsp;&nbsp;&nbsp;name                              | string       | Required    |               |                                      |
| &nbsp;&nbsp;&nbsp;is_manual_connection              | bool         | Required    |               |                                      |
| &nbsp;&nbsp;&nbsp;private_connection_resource_id    | string       | Optional    |               | Inherited in module from resource_id |
| &nbsp;&nbsp;&nbsp;private_connection_resource_alias | string       | Optional    |               |                                      |
| &nbsp;&nbsp;&nbsp;subresource_names                 | list(string) | Optional    |               |                                      |
| &nbsp;&nbsp;&nbsp;request_message                   | string       | Optional    |               |                                      |
| &nbsp;custom_network_interface_name                 | string       | Optional    |               |                                      |
| &nbsp;private_dns_zone_group                        | list(object) | Optional    | []            |                                      |
| &nbsp;&nbsp;&nbsp;name                              | string       | Required    |               |                                      |
| &nbsp;&nbsp;&nbsp;private_dns_zone_ids              | list(string) | Required    |               |                                      |
| &nbsp;ip_configuration                              | list(object) | Optional    | []            |                                      |
| &nbsp;&nbsp;&nbsp;name                              | string       | Required    |               |                                      |
| &nbsp;&nbsp;&nbsp;private_ip_address                | string       | Required    |               |                                      |
| &nbsp;&nbsp;&nbsp;subresource_name                  | string       | Required    |               |                                      |
| &nbsp;&nbsp;&nbsp;member_name                       | string       | Optional    |               |                                      |
| &nbsp;tags                                          | map(any)     | Optional    |               |                                      |
