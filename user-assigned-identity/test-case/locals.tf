locals {
  location = "northeurope"

  naming = {
    rg    = "SEY-UAI-NE-RG01"
    uai_1 = "SEY-TERRAFORM-NE-UAI01"
    uai_2 = "SEY-TERRAFORM-NE-UAI02"
  }

  uai = [
    {
      name                = local.naming.uai_1
      location            = local.location
      resource_group_name = azurerm_resource_group.rg.name

      federated_identity_credential = [
        {
          name     = "example"
          audience = ["foo"]
          issuer   = "https://foo"
          subject  = "foo"
        }
      ]

      tags = {}
    },
    {
      name                = local.naming.uai_2
      location            = local.location
      resource_group_name = azurerm_resource_group.rg.name

      tags = {}
    }
  ]
}
