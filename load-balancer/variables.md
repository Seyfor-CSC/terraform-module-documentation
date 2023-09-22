# Variables

```
variable "config" {  type = list(object({
    # load balancer
    name                = string
    resource_group_name = string
    location            = string
    edge_zone           = optional(string)
    frontend_ip_configuration = optional(list(object({
      name                                               = string
      zones                                              = optional(list(string))
      subnet_id                                          = optional(string)
      gateway_load_balancer_frontend_ip_configuration_id = optional(string)
      private_ip_address                                 = optional(string)
      private_ip_address_allocation                      = optional(string)
      private_ip_address_version                         = optional(string)
      public_ip_address_id                               = optional(string)
      public_ip_prefix_id                                = optional(string)
    })), [])
    sku      = optional(string)
    sku_tier = optional(string)
    tags     = optional(map(any))

    # lb backend address pool
    backend_pools = optional(list(object({
      name            = string
      loadbalancer_id = optional(string) # Inherited in module from parent resource
      tunnel_interface = optional(list(object({
        identifier = string
        type       = string
        protocol   = string
        port       = string
      })), [])
      virtual_network_id = optional(string)

      # network interface backend address pool association
      nic_association = optional(list(object({
        custom_name            = string # Custom variable used as a unique value for terraform. Has to be a unique value for each nic association
        network_interface_id   = string
        ip_configuration_name  = string
        backend_adress_pool_id = optional(string) # Inherited in module from lb backend address pool
      })), [])

      # lb backend address pool address
      backend_addresses = optional(list(object({
        name                                = string
        backend_address_pool_id             = optional(string) # Inherited in module from lb backend address pool
        ip_address                          = optional(string)
        virtual_network_id                  = optional(string)
        backend_address_ip_configuration_id = optional(string)
      })), [])

      # lb outbound rule
      outbound_rules = optional(list(object({
        name                    = string
        loadbalancer_id         = optional(string) # Inherited in module from parent resource
        backend_address_pool_id = optional(string) # Inherited in module from lb backend address pool
        protocol                = string
        frontend_ip_configuration = optional(list(object({
          name = string
        })), [])
        enable_tcp_reset         = optional(bool)
        allocated_outbound_ports = optional(number)
        idle_timeout_in_minutes  = optional(number)
      })), [])
    })), [])

    # lb probe
    probes = optional(list(object({
      name                = string
      loadbalancer_id     = optional(string) # Inherited in module from parent resource
      port                = number
      protocol            = optional(string)
      probe_threshold     = optional(number)
      request_path        = optional(string)
      interval_in_seconds = optional(number)
      number_of_probes    = optional(number)
    })), [])

    # lb rule
    rules = optional(list(object({
      name                           = string
      loadbalancer_id                = optional(string) # Inherited in module from parent resource
      frontend_ip_configuration_name = string
      protocol                       = string
      frontend_port                  = number
      backend_port                   = number
      backend_address_pool_ids       = optional(list(string)) # Do not use, is replaced by backend_address_pool_names parameter
      backend_address_pool_names     = list(string)           # Custom variable replacing backend_address_pool_ids parameter. Backend address pool names, which are being created in this load balancer, are required
      probe_id                       = optional(string)       # Do not use, is replaced by probe_name parameter
      probe_name                     = optional(string)       # Custom variable replacing probe_id parameter. Probe name, which is being created in this load balancer, is expected
      enable_floating_ip             = optional(bool)
      idle_timeout_in_minutes        = optional(number)
      load_distribution              = optional(string)
      disable_outbound_snat          = optional(bool)
      enable_tcp_reset               = optional(bool)
    })), [])

    # lb nat rule
    nat_rules = optional(list(object({
      name                           = string
      resource_group_name            = optional(string) # If not provided, inherited in module from parent resource
      loadbalancer_id                = optional(string) # Inherited in module from parent resource
      frontend_ip_configuration_name = string
      protocol                       = string
      backend_port                   = number
      frontend_port                  = optional(number)
      frontend_port_start            = optional(number)
      frontend_port_end              = optional(number)
      backend_address_pool_id        = optional(string) # Do not use, is replaced by backend_address_pool_name parameter
      backend_address_pool_name      = optional(string) # Custom variable replacing backend_address_pool_id parameter. Backend address pool name, which is being created in this load balancer, is expected
      idle_timeout_in_minutes        = optional(number)
      enable_floating_ip             = optional(bool)
      enable_tcp_reset               = optional(bool)
    })), [])

    # lb nat pool
    nat_pools = optional(list(object({
      name                           = string
      resource_group_name            = optional(string) # If not provided, inherited in module from parent resource
      loadbalancer_id                = optional(string) # Inherited in module from parent resource
      frontend_ip_configuration_name = string
      protocol                       = string
      frontend_port_start            = number
      frontend_port_end              = number
      backend_port                   = number
      idle_timeout_in_minutes        = optional(number)
      floating_ip_enabled            = optional(bool)
      tcp_reset_enabled              = optional(bool)
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
|edge_zone | string | Optional |  |  |
|frontend_ip_configuration | list(object) | Optional | [] |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;zones | list(string) | Optional |  |  |
|&nbsp;subnet_id | string | Optional |  |  |
|&nbsp;gateway_load_balancer_frontend_ip_configuration_id | string | Optional |  |  |
|&nbsp;private_ip_address | string | Optional |  |  |
|&nbsp;private_ip_address_allocation | string | Optional |  |  |
|&nbsp;private_ip_address_version | string | Optional |  |  |
|&nbsp;public_ip_address_id | string | Optional |  |  |
|&nbsp;public_ip_prefix_id | string | Optional |  |  |
|sku | string | Optional |  |  |
|sku_tier | string | Optional |  |  |
|tags | map(any) | Optional |  |  |
|backend_pools | list(object) | Optional | [] |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;loadbalancer_id | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;tunnel_interface | list(object) | Optional | [] |  |
|&nbsp;&nbsp;identifier | string | Required |  |  |
|&nbsp;&nbsp;type | string | Required |  |  |
|&nbsp;&nbsp;protocol | string | Required |  |  |
|&nbsp;&nbsp;port | string | Required |  |  |
|&nbsp;virtual_network_id | string | Optional |  |  |
|&nbsp;nic_association | list(object) | Optional | [] |  |
|&nbsp;&nbsp;custom_name | string | Required |  |  Custom variable used as a unique value for terraform. Has to be a unique value for each nic association |
|&nbsp;&nbsp;network_interface_id | string | Required |  |  |
|&nbsp;&nbsp;ip_configuration_name | string | Required |  |  |
|&nbsp;&nbsp;backend_adress_pool_id | string | Optional |  |  Inherited in module from lb backend address pool |
|&nbsp;backend_addresses | list(object) | Optional | [] |  |
|&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;backend_address_pool_id | string | Optional |  |  Inherited in module from lb backend address pool |
|&nbsp;&nbsp;ip_address | string | Optional |  |  |
|&nbsp;&nbsp;virtual_network_id | string | Optional |  |  |
|&nbsp;&nbsp;backend_address_ip_configuration_id | string | Optional |  |  |
|&nbsp;outbound_rules | list(object) | Optional | [] |  |
|&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;loadbalancer_id | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;&nbsp;backend_address_pool_id | string | Optional |  |  Inherited in module from lb backend address pool |
|&nbsp;&nbsp;protocol | string | Required |  |  |
|&nbsp;&nbsp;frontend_ip_configuration | list(object) | Optional | [] |  |
|&nbsp;&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;enable_tcp_reset | bool | Optional |  |  |
|&nbsp;&nbsp;allocated_outbound_ports | number | Optional |  |  |
|&nbsp;&nbsp;idle_timeout_in_minutes | number | Optional |  |  |
|probes | list(object) | Optional | [] |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;loadbalancer_id | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;port | number | Required |  |  |
|&nbsp;protocol | string | Optional |  |  |
|&nbsp;probe_threshold | number | Optional |  |  |
|&nbsp;request_path | string | Optional |  |  |
|&nbsp;interval_in_seconds | number | Optional |  |  |
|&nbsp;number_of_probes | number | Optional |  |  |
|rules | list(object) | Optional | [] |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;loadbalancer_id | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;frontend_ip_configuration_name | string | Required |  |  |
|&nbsp;protocol | string | Required |  |  |
|&nbsp;frontend_port | number | Required |  |  |
|&nbsp;backend_port | number | Required |  |  |
|&nbsp;backend_address_pool_ids | list(string) | Optional |  |  Do not use, is replaced by backend_address_pool_names parameter |
|&nbsp;backend_address_pool_names | list(string) | Required |  |  Custom variable replacing backend_address_pool_ids parameter. Backend address pool names, which are being created in this load balancer, are required |
|&nbsp;probe_id | string | Optional |  |  Do not use, is replaced by probe_name parameter |
|&nbsp;probe_name | string | Optional |  |  Custom variable replacing probe_id parameter. Probe name, which is being created in this load balancer, is expected |
|&nbsp;enable_floating_ip | bool | Optional |  |  |
|&nbsp;idle_timeout_in_minutes | number | Optional |  |  |
|&nbsp;load_distribution | string | Optional |  |  |
|&nbsp;disable_outbound_snat | bool | Optional |  |  |
|&nbsp;enable_tcp_reset | bool | Optional |  |  |
|nat_rules | list(object) | Optional | [] |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;resource_group_name | string | Optional |  |  If not provided, inherited in module from parent resource |
|&nbsp;loadbalancer_id | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;frontend_ip_configuration_name | string | Required |  |  |
|&nbsp;protocol | string | Required |  |  |
|&nbsp;backend_port | number | Required |  |  |
|&nbsp;frontend_port | number | Optional |  |  |
|&nbsp;frontend_port_start | number | Optional |  |  |
|&nbsp;frontend_port_end | number | Optional |  |  |
|&nbsp;backend_address_pool_id | string | Optional |  |  Do not use, is replaced by backend_address_pool_name parameter |
|&nbsp;backend_address_pool_name | string | Optional |  |  Custom variable replacing backend_address_pool_id parameter. Backend address pool name, which is being created in this load balancer, is expected |
|&nbsp;idle_timeout_in_minutes | number | Optional |  |  |
|&nbsp;enable_floating_ip | bool | Optional |  |  |
|&nbsp;enable_tcp_reset | bool | Optional |  |  |
|nat_pools | list(object) | Optional | [] |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;resource_group_name | string | Optional |  |  If not provided, inherited in module from parent resource |
|&nbsp;loadbalancer_id | string | Optional |  |  Inherited in module from parent resource |
|&nbsp;frontend_ip_configuration_name | string | Required |  |  |
|&nbsp;protocol | string | Required |  |  |
|&nbsp;frontend_port_start | number | Required |  |  |
|&nbsp;frontend_port_end | number | Required |  |  |
|&nbsp;backend_port | number | Required |  |  |
|&nbsp;idle_timeout_in_minutes | number | Optional |  |  |
|&nbsp;floating_ip_enabled | bool | Optional |  |  |
|&nbsp;tcp_reset_enabled | bool | Optional |  |  |
|monitoring | list(object) | Optional | [] |  Custom object for enabling diagnostic settings |
|&nbsp;diag_name | string | Optional |  |  Name of the diagnostic setting |
|&nbsp;log_analytics_workspace_id | string | Optional |  |  |
|&nbsp;eventhub_name | string | Optional |  |  |
|&nbsp;eventhub_authorization_rule_id | string | Optional |  |  |


