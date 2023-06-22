locals {
  location = "norwayeast"

  naming = {
    rg    = "SEY-TERRAFORM-NE-RG01"
    lb_1  = "SEY-TERRAFORM-NE-LB01"
    lb_2  = "SEY-TERRAFORM-NE-LB02"
    nic_0 = "nic0"
    nic_1 = "nic1"
  }

  lb = [
    {
      name                = local.naming.lb_1
      location            = local.location
      resource_group_name = local.naming.rg
      sku                 = "Standard"
      backend_pools = [
        {
          name = "${local.naming.lb_1}-backend-pool"
          nic_association = [
            {
              custom_name           = "${local.naming.nic_0}-association"
              ip_configuration_name = "internal"
              network_interface_id  = azurerm_network_interface.nic0.id
            },
            {
              custom_name           = "${local.naming.nic_1}-association"
              ip_configuration_name = "internal"
              network_interface_id  = azurerm_network_interface.nic1.id
            }
          ]
          outbound_rules = [
            {
              name     = "${local.naming.lb_1}-outbound-r"
              protocol = "All"
            }
          ]
        }
      ]
      probes = [
        {
          name = "ssh-probe"
          port = 22
        },
        {
          name = "https-probe"
          port = 443
        }
      ]
      rules = [
        {
          name                           = "LBRule1"
          protocol                       = "Tcp"
          frontend_port                  = 339
          backend_port                   = 339
          frontend_ip_configuration_name = "${local.naming.lb_1}-frontend-ip"
          disable_outbound_snat          = true
          probe                          = "ssh-probe"
          backend_pool_name              = "${local.naming.lb_1}-backend-pool"
        },
        {
          name                           = "LBRule2"
          protocol                       = "Tcp"
          frontend_port                  = 3393
          backend_port                   = 3393
          frontend_ip_configuration_name = "${local.naming.lb_1}-frontend-ip"
          disable_outbound_snat          = true
          probe                          = "ssh-probe"
          backend_pool_name              = "${local.naming.lb_1}-backend-pool"
        }
      ]

      monitoring = [
        {
          diag_name                  = "Monitoring"
          log_analytics_workspace_id = azurerm_log_analytics_workspace.la.id
        }
      ]

      tags = {}
    },
    {
      name                = local.naming.lb_2
      location            = local.location
      resource_group_name = local.naming.rg
      sku                 = "Standard"
      backend_pools = [
        {
          name = "${local.naming.lb_2}-backend-pool"
          backend_addresses = [
            {
              name               = "${local.naming.lb_2}-address0"
              virtual_network_id = azurerm_virtual_network.vnet.id
              ip_address         = "10.0.2.4"
            },
            {
              name               = "${local.naming.lb_2}-address1"
              virtual_network_id = azurerm_virtual_network.vnet.id
              ip_address         = "10.0.2.5"
            }
          ]
        }
      ]
      probes = [
        {
          name = "ssh-probe"
          port = 22
        }
      ]
      rules = [
        {
          name                           = "LBRule1"
          protocol                       = "Tcp"
          frontend_port                  = 339
          backend_port                   = 339
          frontend_ip_configuration_name = "${local.naming.lb_2}-frontend-ip"
          disable_outbound_snat          = true
          probe                          = "ssh-probe"
          backend_pool_name              = "${local.naming.lb_2}-backend-pool"
        }
      ]

      tags = {}
    }
  ]
}
