locals {
  location = "germanywestcentral"

  naming = {
    rg    = "SEY-TERRAFORM-NE-RG01"
    ag_1  = "SEY-TERRAFORM-NE-AG01"
    ags_1 = "SEYAG01"
    ag_2  = "SEY-TERRAFORM-NE-AG02"
    ags_2 = "SEYAG02"
  }

  rg = [
    {
      name     = local.naming.rg
      location = local.location
    }
  ]

  ag = [
    {
      name                = local.naming.ag_1
      resource_group_name = local.naming.rg
      short_name          = local.naming.ags_1
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
      resource_group_name = local.naming.rg
      short_name          = local.naming.ags_2
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
