locals {
  location = "germanywestcentral"

  naming = {
    rg   = "SEY-AG-NE-RG01"
    ag_1 = "SEY-TERRAFORM-NE-AG01"
    ag_2 = "SEY-TERRAFORM-NE-AG02"
  }

  ag = [
    {
      name                = local.naming.ag_1
      resource_group_name = azurerm_resource_group.rg.name
      short_name          = "SEYAGS01"
      location            = local.location
      azure_app_push_receiver = [
        {
          name          = "pushtoadmin"
          email_address = "admin@contoso.com"
        }

      ]

      tags = {}
    },
    {
      name                = local.naming.ag_2
      resource_group_name = azurerm_resource_group.rg.name
      short_name          = "SEYAGS02"
      webhook_receiver = [
        {
          name                    = "callmyapiaswell"
          service_uri             = "http://example.com/alert"
          use_common_alert_schema = true
        }
      ]

      tags = {}
    }
  ]
}
