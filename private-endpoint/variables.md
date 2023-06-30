# Variables

```
variable "config" {  type = list(object({
    # private endpoint
    name                = string
    resource_group_name = string
    location            = string
    subnet_id           = string
    resource_id         = string
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
  }))
}


```


## Table with config variables

| Name | Data Type | Requirement | Default Value | Comment |
| ------- | --------- | ----------- | ------------- | ------- |
|name | string | Required |  |  |
|resource_group_name | string | Required |  |  |
|location | string | Required |  |  |
|subnet_id | string | Required |  |  |
|resource_id | string | Required |  |  |
|private_service_connection | list(object) | Required |  |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;is_manual_connection | bool | Required |  |  |
|&nbsp;private_connection_resource_id | string | Optional |  |  |
|&nbsp;private_connection_resource_alias | string | Optional |  |  |
|&nbsp;subresource_names | list(string) | Optional |  |  |
|&nbsp;request_message | string | Optional |  |  |
|custom_network_interface_name | string | Optional |  |  |
|private_dns_zone_group | list(object) | Optional | [] |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;private_dns_zone_ids | list(string) | Required |  |  |
|ip_configuration | list(object) | Optional | [] |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;private_ip_address | string | Required |  |  |
|&nbsp;subresource_name | string | Required |  |  |
|&nbsp;member_name | string | Optional |  |  |
|tags | map(any) | Optional |  |  |


