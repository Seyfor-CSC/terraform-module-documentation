locals {
  location = "northeurope"

  naming = {
    rg   = "SEY-TERRAFORM-NE-RG01"
    cg_1 = "SEY-TERRAFORM-NE-CG01"
    cg_2 = "SEY-TERRAFORM-NE-CG02"
  }

  cg = [
    {
      name                = local.naming.cg_1
      location            = local.location
      resource_group_name = local.naming.rg
      os_type             = "Linux"
      ip_address_type     = "Public"
      container = [{
        name   = "testcontainer"
        image  = "mcr.microsoft.com/azuredocs/aci-tutorial-sidecar"
        cpu    = 0.25
        memory = 0.5
        ports = [
          {
            port     = 443
            protocol = "TCP"
          },
          {
            port     = 22
            protocol = "TCP"
          }
        ]
      }]
      identity = {
        type = "SystemAssigned"
      }

      tags = {}
    },
    {
      name                = local.naming.cg_2
      location            = local.location
      resource_group_name = local.naming.rg
      os_type             = "Linux"
      ip_address_type     = "Public"
      container = [{
        name   = "testcontainer"
        image  = "mcr.microsoft.com/azuredocs/aci-tutorial-sidecar"
        cpu    = 0.25
        memory = 0.5
        ports = [
          {
            port     = 443
            protocol = "TCP"
          }
        ]
      }]
      
      tags = {}
    }
  ]
}
