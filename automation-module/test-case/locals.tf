locals {
  location = "northeurope"

  naming = {
    rg = "SEY-TERRAFORM-NE-RG01"
    aa = "SEY-TERRAFORM-NE-AA01"
  }

  amp = [
    {
      name                    = "Az.Accounts"
      resource_group_name     = local.naming.rg
      automation_account_name = local.naming.aa
      module_link = {
        uri = "https://www.powershellgallery.com/api/v2/package/Az.Accounts/2.12.1"
      }
    }
  ]

  amd = [
    {
      name                    = "Az.Monitor"
      resource_group_name     = local.naming.rg
      automation_account_name = local.naming.aa
      module_link = {
        uri = "https://www.powershellgallery.com/api/v2/package/Az.Monitor/4.4.1"
      }
    },
    {
      name                    = "Az.AlertsManagement"
      resource_group_name     = local.naming.rg
      automation_account_name = local.naming.aa
      module_link = {
        uri = "https://www.powershellgallery.com/api/v2/package/Az.AlertsManagement/0.5.0"
      }
    }
  ]
}
