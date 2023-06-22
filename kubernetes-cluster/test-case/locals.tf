locals {
  location = "northeurope"

  naming = {
    rg    = "SEY-TERRAFORM-NE-RG01"
    aks_1 = "SEY-TERRAFORM-NE-AKS01"
    aks_2 = "SEY-TERRAFORM-NE-AKS02"
  }

  aks = [
    {
      name                = local.naming.aks_1
      location            = local.location
      resource_group_name = local.naming.rg
      dns_prefix          = local.naming.aks_1
      default_node_pool = {
        name    = "systemnp"
        vm_size = "Standard_D2_v2"
        node_count = 1
      }
      cluster_node_pool = [
        {
          name                  = "examplenp"
          vm_size               = "Standard_D2_v2"
          node_count            = 1
        }
      ]
      identity = {
        type = "SystemAssigned"
      }

      monitoring = [
        {
          diag_name                  = "Monitoring"
          log_analytics_workspace_id = azurerm_log_analytics_workspace.la.id
        }
      ]

      tags = {}
    },
    {
      name                = local.naming.aks_2
      location            = local.location
      resource_group_name = local.naming.rg
      dns_prefix          = local.naming.aks_2
      default_node_pool = {
        name    = "systemnp"
        vm_size = "Standard_D2_v2"
        node_count = 1
      }
      identity = {
        type = "SystemAssigned"
      }

      tags = {}
    }
  ]
}
