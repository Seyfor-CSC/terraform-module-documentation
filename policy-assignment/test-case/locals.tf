locals {
  location = "northeurope"

  naming = {
    policy_1 = "SEY-AllowedLocations"
    policy_2 = "SEY-NotAllowedResourceTypes"
  }

  policy = [
    {
      name                 = local.naming.policy_1
      management_group_id  = "/providers/Microsoft.Management/managementGroups/666-666-666-666-666" # replace with your own
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/e56962a6-4747-49cd-b67b-bf8b01975c4c" # link to built-in policy
      parameters           = "${path.module}/parameters/listOfAllowedLocations.json"
    },
    {
      name                 = local.naming.policy_2
      subscription_id      = data.azurerm_subscription.primary.id
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/6c112d4e-5bc7-47ae-a041-ea2d9dccd749" # link to built-in policy
      parameters           = "${path.module}/parameters/listOfResourceTypesNotAllowed.json"
    }
  ]
}
