locals {
  location = "northeurope"

  naming = {
    rg     = "SEY-TERRAFORM-NE-RG01"
    vnet_1 = "SEY-TERRAFORM-NE-VNET01"
    vnet_2 = "SEY-TERRAFORM-NE-VNET02"
    nsg    = "SEY-TERRAFORM-NE-NSG01"
    rt     = "SEY-TERRAFORM-NE-UDR01"
  }

  vnet = [
    {
      name                = local.naming.vnet_1
      address_space       = ["10.0.0.0/24"]
      resource_group_name = azurerm_resource_group.rg.name
      location            = local.location
      subnets = [
        {
          name             = "sey-terraform-ne-10.0.0.0-25"
          address_prefixes = ["10.0.0.0/25"]
          nsg_name         = azurerm_network_security_group.nsg.name # deploys subnet network security group association
          nsg_rg           = lower(azurerm_resource_group.rg.name)   # has to be configured because azurerm_network_security_group.nsg has a resource group name in lowercase
          route_table_name = azurerm_route_table.rt.name             # deploys subnet route table association
          delegation = {
            name = "aks-delegation"
            service_delegation = {
              name    = "Microsoft.ContainerService/managedClusters"
              actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
            }
          }
        }
      ]

      monitoring = [
        {
          diag_name                  = "Monitoring"
          log_analytics_workspace_id = azurerm_log_analytics_workspace.la.id
          categories = {
            vm_protection_alerts = false
          }
        }
      ]

      tags = {}
    },
    {
      name                = local.naming.vnet_2
      address_space       = ["10.0.1.0/24"]
      resource_group_name = azurerm_resource_group.rg.name
      location            = local.location
      subnets = [
        {
          name             = "sey-terraform-ne-10.0.1.0-25"
          address_prefixes = ["10.0.1.0/25"]
        }
      ]

      tags = {}
    }
  ]

  subnets = [
    {
      name                 = "sey-terraform-ne-10.0.2.0-25"
      address_prefixes     = ["10.0.2.0/25"]
      resource_group_name  = azurerm_resource_group.rg.name
      virtual_network_name = azurerm_virtual_network.vnet.name
      nsg_name             = azurerm_network_security_group.nsg.name # deploys subnet network security group association
      nsg_rg               = lower(azurerm_resource_group.rg.name)   # has to be configured because azurerm_network_security_group.nsg has a resource group name in lowercase
      route_table_name     = azurerm_route_table.rt.name             # deploys subnet route table association
    },
    {
      name                 = "sey-terraform-ne-10.0.2.128-25"
      address_prefixes     = ["10.0.2.128/25"]
      resource_group_name  = azurerm_resource_group.rg.name
      virtual_network_name = azurerm_virtual_network.vnet.name
    }
  ]
}
