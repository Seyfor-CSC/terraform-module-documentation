locals {
  location = "northeurope"

  naming = {
    rd_1 = "Terraform Reader"
    rd_2 = "Terraform Contributor"
  }


  rd = [
    {
      name  = local.naming.rd_1
      scope = data.azurerm_subscription.primary.id
      assignable_scopes = [
        data.azurerm_subscription.primary.id
      ]
      permissions = {
        actions = [
          "Microsoft.Storage/storageAccounts/blobServices/containers/read",
          "Microsoft.Storage/storageAccounts/blobServices/generateUserDelegationKey/action"
        ]
        not_actions = [
          "Microsoft.Authorization/*/Delete",
          "Microsoft.Authorization/*/Write",
          "Microsoft.Authorization/elevateAccess/Action"
        ]
      }
    },
    {
      name  = local.naming.rd_2
      scope = data.azurerm_subscription.primary.id
      permissions = {
        actions      = ["*"]
        data_actions = ["*"]
      }
    }
  ]
}
