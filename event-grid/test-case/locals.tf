locals {
  location = "northeurope"

  naming = {
    rg = "SEY-TERRAFORM-NE-RG001"
    sa = "seyterraformne001"
    st = "seyterraformne001"
  }

  eventgrid = {
    system_topic = [
      {
        location               = local.location
        name                   = local.naming.st
        resource_group_name    = local.naming.rg
        source_arm_resource_id = azurerm_storage_account.sa.id
        topic_type             = "Microsoft.Storage.StorageAccounts"
      }
    ]
  }

  tags = {
    environment = "DEV"
  }
}
