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
    })))

    sku      = optional(string)
    sku_tier = optional(string)

    tags = optional(map(any))

    # backend pool
    backend_pools = list(object({
      name               = string
      virtual_network_id = optional(string)
      loadbalancer_id    = optional(string) # inherited from load balancer

      tunnel_interface = optional(object({
        identifier = string
        type       = string
        protocol   = string
        port       = string
      }))

      # nic association
      nic_association = optional(list(object({
        custom_name           = string
        backend_pool_name     = optional(string) # inherited from backend pool if not specified
        network_interface_id  = string
        ip_configuration_name = string
      })), [])

      # backend pool address
      backend_addresses = optional(list(object({
        name                                = string
        backend_pool_name                   = optional(string) # inherited from backend pool if not specified
        ip_address                          = optional(string)
        virtual_network_id                  = optional(string)
        backend_address_ip_configuration_id = optional(string)
      })), [])

      # outbound rules
      outbound_rules = optional(list(object({
        name     = string
        protocol = string

        frontend_ip_configuration = optional(list(object({
          name = string
        })), [])

        loadbalancer_id          = optional(string) # inherited from load balancer
        backend_pool_name        = optional(string) # inherited from backend pool if not specified
        enable_tcp_reset         = optional(bool)
        allocated_outbound_ports = optional(number)
        idle_timeout_in_minutes  = optional(number)
      })), [])
    }))

    # probes
    probes = list(object({
      name                = string
      port                = number
      loadbalancer_id     = optional(string) # inherited from load balancer
      protocol            = optional(string)
      probe_threshold     = optional(number)
      request_path        = optional(string)
      interval_in_seconds = optional(number)
      number_of_probes    = optional(number)
    }))

    # rules
    rules = list(object({
      name                           = string
      frontend_ip_configuration_name = string
      protocol                       = string
      frontend_port                  = number
      backend_port                   = number
      backend_pool_name              = string
      loadbalancer_id                = optional(string) # inherited from load balancer
      probe                          = optional(string)
      enable_floating_ip             = optional(bool)
      idle_timeout_in_minutes        = optional(number)
      load_distribution              = optional(string)
      disable_outbound_snat          = optional(bool)
      enable_tcp_reset               = optional(bool)
    }))

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
|backend_pools | list(object) | Required |  |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;virtual_network_id | string | Optional |  |  |
|&nbsp;loadbalancer_id | string | Optional |  |  inherited from load balancer |
|&nbsp;tunnel_interface | object | Optional |  |  |
|&nbsp;&nbsp;identifier | string | Required |  |  |
|&nbsp;&nbsp;type | string | Required |  |  |
|&nbsp;&nbsp;protocol | string | Required |  |  |
|&nbsp;&nbsp;port | string | Required |  |  |
|&nbsp;nic_association | list(object) | Optional | [] |  |
|&nbsp;&nbsp;custom_name | string | Required |  |  |
|&nbsp;&nbsp;backend_pool_name | string | Optional |  |  inherited from backend pool if not specified |
|&nbsp;&nbsp;network_interface_id | string | Required |  |  |
|&nbsp;&nbsp;ip_configuration_name | string | Required |  |  |
|&nbsp;backend_addresses | list(object) | Optional | [] |  |
|&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;backend_pool_name | string | Optional |  |  inherited from backend pool if not specified |
|&nbsp;&nbsp;ip_address | string | Optional |  |  |
|&nbsp;&nbsp;virtual_network_id | string | Optional |  |  |
|&nbsp;&nbsp;backend_address_ip_configuration_id | string | Optional |  |  |
|&nbsp;outbound_rules | list(object) | Optional | [] |  |
|&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;protocol | string | Required |  |  |
|&nbsp;&nbsp;frontend_ip_configuration | list(object) | Optional | [] |  |
|&nbsp;&nbsp;&nbsp;name | string | Required |  |  |
|&nbsp;&nbsp;loadbalancer_id | string | Optional |  |  inherited from load balancer |
|&nbsp;&nbsp;backend_pool_name | string | Optional |  |  inherited from backend pool if not specified |
|&nbsp;&nbsp;enable_tcp_reset | bool | Optional |  |  |
|&nbsp;&nbsp;allocated_outbound_ports | number | Optional |  |  |
|&nbsp;&nbsp;idle_timeout_in_minutes | number | Optional |  |  |
|probes | list(object) | Required |  |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;port | number | Required |  |  |
|&nbsp;loadbalancer_id | string | Optional |  |  inherited from load balancer |
|&nbsp;protocol | string | Optional |  |  |
|&nbsp;probe_threshold | number | Optional |  |  |
|&nbsp;request_path | string | Optional |  |  |
|&nbsp;interval_in_seconds | number | Optional |  |  |
|&nbsp;number_of_probes | number | Optional |  |  |
|rules | list(object) | Required |  |  |
|&nbsp;name | string | Required |  |  |
|&nbsp;frontend_ip_configuration_name | string | Required |  |  |
|&nbsp;protocol | string | Required |  |  |
|&nbsp;frontend_port | number | Required |  |  |
|&nbsp;backend_port | number | Required |  |  |
|&nbsp;backend_pool_name | string | Required |  |  |
|&nbsp;loadbalancer_id | string | Optional |  |  inherited from load balancer |
|&nbsp;probe | string | Optional |  |  |
|&nbsp;enable_floating_ip | bool | Optional |  |  |
|&nbsp;idle_timeout_in_minutes | number | Optional |  |  |
|&nbsp;load_distribution | string | Optional |  |  |
|&nbsp;disable_outbound_snat | bool | Optional |  |  |
|&nbsp;enable_tcp_reset | bool | Optional |  |  |
|monitoring | list(object) | Optional | [] |  Custom object for enabling diagnostic settings |
|&nbsp;diag_name | string | Optional |  |  Name of the diagnostic setting |
|&nbsp;log_analytics_workspace_id | string | Optional |  |  |
|&nbsp;eventhub_name | string | Optional |  |  |
|&nbsp;eventhub_authorization_rule_id | string | Optional |  |  |


