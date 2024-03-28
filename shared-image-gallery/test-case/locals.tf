locals {
  location = "northeurope"

  naming = {
    rg    = "SEY-TERRAFORM-NE-RG01"
    acg_1 = "seyterraformneacg01"
    acg_2 = "seyterraformneacg02"
  }

  acg = [
    {
      name                = local.naming.acg_1
      location            = local.location
      resource_group_name = azurerm_resource_group.rg.name
      description         = "Shared Image Gallery with customized OS images for deployment across various subscriptions and locations."
      tags                = {}

      image = [
        {
          name = "Microsoft_Windows_2016"
          identifier = {
            offer     = "WindowsServer"
            publisher = "MicrosoftWindowsServer"
            sku       = "2016-Datacenter"
          }
          os_type = "Windows"
          purchase_plan = {
            name      = "windows-datacenter"
            publisher = "MicrosoftWindowsServer"
            product   = "WindowsServer"
          }
          specialized = true

          image_version = [
            {
              name = "0.0.1"
              target_region = [
                {
                  name                   = "northeurope"
                  regional_replica_count = 1
                }
              ]
              managed_image_id = azurerm_windows_virtual_machine.example1.id
            }
          ]
        },
        {
          name = "Microsoft_Windows_2019"
          identifier = {
            offer     = "WindowsServer"
            publisher = "MicrosoftWindowsServer"
            sku       = "2019-Datacenter"
          }
          os_type = "Windows"
          purchase_plan = {
            name      = "windows-datacenter"
            publisher = "MicrosoftWindowsServer"
            product   = "WindowsServer"
          }
          specialized = true

          image_version = [
            {
              name = "0.0.1"
              target_region = [
                {
                  name                   = "northeurope"
                  regional_replica_count = 1
                }
              ]
              managed_image_id = azurerm_windows_virtual_machine.example2.id
            }
          ]
        }
      ]
    },
    {
      name                = local.naming.acg_2
      location            = local.location
      resource_group_name = azurerm_resource_group.rg.name
      tags                = {}
    }
  ]
}
