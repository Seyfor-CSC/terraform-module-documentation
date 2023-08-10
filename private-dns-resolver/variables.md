# Variables

```
variable "config" {  type = list(object({
    # private dns resolver
    name                = string
    resource_group_name = string
    location            = string
    virtual_network_id  = string
    tags                = optional(map(any))

    # private dns resolver inbound endpoint
    inbound_endpoints = optional(list(object({
      name                    = string
      private_dns_resolver_id = optional(string) # Inherited in module from parent resource
      ip_configurations = list(object({
        private_ip_allocation_method = optional(string)
        subnet_id                    = string
      }))
      location = optional(string) # Inherited in module from parent resource
      tags     = optional(map(any))
    })), [])

    # private dns resolver outbound endpoint
    outbound_endpoints = optional(list(object({
      name                    = string
      private_dns_resolver_id = optional(string) # Inherited in module from parent resource
      location                = optional(string) # Inherited in module from parent resource
      subnet_id               = string
      tags                    = optional(map(any))
    })), [])

    # private dns resolver dns forwarding ruleset
    private_dns_resolver_dns_forwarding_rulesets = optional(list(object({
      name                                         = string
      resource_group_name                          = optional(string)       # If not provided, inherited in module from private dns resolver resource
      private_dns_resolver_outbound_endpoint_ids   = optional(list(string)) # Do not use, is replaced by private_dns_resolver_outbound_endpoint_names parameter
      private_dns_resolver_outbound_endpoint_names = list(string)           # Custom variable replacing private_dns_resolver_outbound_endpoint_ids parameter. Outbound Endpoint names, which are being created in this private dns resolver, are required
      location                                     = optional(string)       # Inherited in module from parent resource
      tags                                         = optional(map(any))

      # private dns resolver forwarding rule
      private_dns_resolver_forwarding_rules = optional(list(object({
        name                      = string
        dns_forwarding_ruleset_id = optional(string) # Inherited in module from parent resource
        domain_name               = string
        target_dns_servers = list(object({
          ip_address = string
          port       = optional(number)
        }))
        enabled  = optional(bool)
        metadata = optional(map(any))
      })), [])

      # private dns resolver virtual network link
      private_dns_resolver_virtual_network_links = optional(list(object({
        name                      = string
        dns_forwarding_ruleset_id = optional(string) # Inherited in module from parent resource
        virtual_network_id        = string
        metadata                  = optional(map(any))
      })), [])
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
|virtual_network_id | string | Required |  |  |
|tags | map(any) | Optional |  |  |
|inbound_endpoints | list(object) | Optional | [] |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;private_dns_resolver_id | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;ip_configurations | list(object) | Required |  |  |
|&nbsp;&nbsp;private_ip_allocation_method | string | Optional |  |  |
|&nbsp;&nbsp;subnet_id | string | Required |  |  |
|&nbsp;location | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;tags | map(any) | Optional |  |  |
|outbound_endpoints | list(object) | Optional | [] |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;private_dns_resolver_id | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;location | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;subnet_id | string | Required |  |  |
|&nbsp;tags | map(any) | Optional |  |  |
|private_dns_resolver_dns_forwarding_rulesets | list(object) | Optional | [] |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;resource_group_name | string | Optional |  |  If not provided, inherited in module from private dns resolver resource |
|&nbsp;private_dns_resolver_outbound_endpoint_ids | list(string) | Optional |  |  Do not use, is replaced by private_dns_resolver_outbound_endpoint_names parameter |
|&nbsp;private_dns_resolver_outbound_endpoint_names | list(string) | Required |  |  Custom variable replacing private_dns_resolver_outbound_endpoint_ids parameter. Outbound Endpoint names, which are being created in this private dns resolver, are required |
|&nbsp;location | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;tags | map(any) | Optional |  |  |
|&nbsp;private_dns_resolver_forwarding_rules | list(object) | Optional | [] |  |
|&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;dns_forwarding_ruleset_id | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;&nbsp;domain_name | string | Required |  |  |
|&nbsp;&nbsp;target_dns_servers | list(object) | Required |  |  |
|&nbsp;&nbsp;&nbsp;ip_address | string | Required |  |  |
|&nbsp;&nbsp;&nbsp;port | number | Optional |  |  |
|&nbsp;&nbsp;enabled | bool | Optional |  |  |
|&nbsp;&nbsp;metadata | map(any) | Optional |  |  |
|&nbsp;private_dns_resolver_virtual_network_links | list(object) | Optional | [] |  |
|&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;dns_forwarding_ruleset_id | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;&nbsp;virtual_network_id | string | Required |  |  |
|&nbsp;&nbsp;metadata | map(any) | Optional |  |  |


