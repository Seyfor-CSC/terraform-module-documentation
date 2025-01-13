locals {
  location = "northeurope"

  naming = {
    rg   = "SEY-LB-NE-RG01"
    lb_1 = "SEY-TERRAFORM-NE-LB01"
    lb_2 = "SEY-TERRAFORM-NE-LB02"
  }

  lb = [
    {
      name                = local.naming.lb_1
      location            = local.location
      resource_group_name = azurerm_resource_group.rg.name
      sku                 = "Gateway"
      frontend_ip_configuration = [
        {
          name               = "${local.naming.lb_1}-frontend-ip"
          subnet_id          = azurerm_subnet.subnet.id
          private_ip_address = "10.0.2.5"
        }
      ]

      backend_pools = [
        {
          name = "${local.naming.lb_1}-backend-pool"
          tunnel_interface = [
            {
              identifier = "900"
              type       = "Internal"
              protocol   = "VXLAN"
              port       = "339"
            },
            {
              identifier = "910"
              type       = "External"
              protocol   = "VXLAN"
              port       = "443"
            }
          ]

          nic_association = [
            {
              custom_name           = "${azurerm_network_interface.nic0.name}-association"
              ip_configuration_name = "internal"
              network_interface_id  = azurerm_network_interface.nic0.id
            },
            {
              custom_name           = "${azurerm_network_interface.nic1.name}-association"
              ip_configuration_name = "internal"
              network_interface_id  = azurerm_network_interface.nic1.id
            }
          ]
        },
        {
          name = "${local.naming.lb_1}-backend-pool2"
          tunnel_interface = [
            {
              identifier = "910"
              type       = "External"
              protocol   = "VXLAN"
              port       = "339"
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
          protocol                       = "All"
          frontend_port                  = 0
          backend_port                   = 0
          frontend_ip_configuration_name = "${local.naming.lb_1}-frontend-ip"
          disable_outbound_snat          = true
          backend_address_pool_names     = ["${local.naming.lb_1}-backend-pool"]
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
      resource_group_name = azurerm_resource_group.rg.name
      sku                 = "Standard"
      frontend_ip_configuration = [
        {
          name                 = "${local.naming.lb_2}-frontend-ip"
          public_ip_address_id = azurerm_public_ip.pip1.id
        }
      ]

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

      nat_rules = [
        {
          name                           = "${local.naming.lb_2}-nat-rule"
          frontend_ip_configuration_name = "${local.naming.lb_2}-frontend-ip"
          protocol                       = "Tcp"
          frontend_port_start            = 3000
          frontend_port_end              = 3389
          backend_port                   = 3389
          backend_address_pool_name      = "${local.naming.lb_2}-backend-pool"
        }
      ]

      nat_pools = [
        {
          name                           = "${local.naming.lb_2}-nat-pool"
          frontend_ip_configuration_name = "${local.naming.lb_2}-frontend-ip"
          protocol                       = "Tcp"
          frontend_port_start            = 587
          frontend_port_end              = 588
          backend_port                   = 589
        }
      ]

      tags = {}
    }
  ]
}
