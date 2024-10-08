locals {
  location = "northeurope"

  naming = {
    rg       = "SEY-DNSRES-NE-RG01"
    dnsres_1 = "SEY-TERRAFORM-NE-DNSRES01"
    dnsres_2 = "SEY-TERRAFORM-NE-DNSRES02"
  }

  dnsres = [
    {
      name                = local.naming.dnsres_1
      location            = local.location
      resource_group_name = azurerm_resource_group.rg.name
      virtual_network_id  = azurerm_virtual_network.vnet1.id

      inbound_endpoints = [
        {
          name = "inbound_ep"
          ip_configurations = [
            {
              subnet_id                    = azurerm_subnet.subnet1.id
              private_ip_address           = "10.0.1.12"
              private_ip_allocation_method = "Static"
            }
          ]
        }
      ]

      outbound_endpoints = [
        {
          name      = "outbound_ep"
          subnet_id = azurerm_subnet.subnet2.id
        }
      ]

      private_dns_resolver_dns_forwarding_rulesets = [
        {
          name                                         = "fwdrs01"
          private_dns_resolver_outbound_endpoint_names = ["outbound_ep"]


          private_dns_resolver_forwarding_rules = [
            {
              name        = "fwdrule01"
              domain_name = "sey.cz."
              target_dns_servers = [{
                ip_address = "192.168.1.1"
                port       = 53
                }
              ]
            }
          ]

          private_dns_resolver_virtual_network_links = [
            {
              name               = "SEY-DNSRES-NE-VNETLINK01"
              virtual_network_id = azurerm_virtual_network.vnet1.id
            }
          ]
        }
      ]
    },
    {
      name                = local.naming.dnsres_2
      location            = local.location
      resource_group_name = azurerm_resource_group.rg.name
      virtual_network_id  = azurerm_virtual_network.vnet2.id
    }
  ]
}
