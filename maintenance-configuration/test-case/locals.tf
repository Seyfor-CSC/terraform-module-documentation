locals {
  location = "northeurope"

  naming = {
    rg  = "SEY-MAINTENANCE-NE-RG01"
    mc1 = "SEY-TERRAFORM-NE-MC01"
    mc2 = "SEY-TERRAFORM-NE-MC02"
  }

  mc = [
    {
      name                = local.naming.mc1
      resource_group_name = azurerm_resource_group.rg.name
      location            = local.location
      scope               = "InGuestPatch"

      window = {
        start_date_time = "2024-07-01 00:00"
        duration        = "02:00"
        time_zone       = "UTC"
        recur_every     = "2week"
      }

      install_patches = {
        linux = {
          classifications_to_include    = ["Critical", "Security"]
          package_names_mask_to_exclude = ["*kernel*"]
          package_names_mask_to_include = ["*"]
        }
        windows = {
          classifications_to_include = ["Critical", "Security"]
          kb_numbers_to_exclude      = ["3103696"]
          kb_numbers_to_include      = ["3134815"]
        }
        reboot = "IfRequired"
      }
      in_guest_user_patch_mode = "User"
    },
    {
        name                = local.naming.mc2
        resource_group_name = azurerm_resource_group.rg.name
        location            = local.location
        scope               = "Extension"
    }
  ]
}
