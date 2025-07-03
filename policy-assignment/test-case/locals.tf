locals {
  location = "northeurope"

  naming = {
    policy_1 = "SEY-VM-ManagedDiskUse"
    policy_2 = "SEY-KeyVault-SoftDelete"
  }

  policy = [
    {
      name                 = local.naming.policy_1 # effect = 'Audit'
      display_name         = local.naming.policy_1
      description          = "Audit VMs that do not use managed disks."
      location             = local.location
      subscription_id      = data.azurerm_subscription.primary.id
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/06a78e20-9358-41c9-923c-fb736d382a4d" # built-in policy
    },
    {
      name                 = local.naming.policy_2 # effect = 'Audit'
      display_name         = local.naming.policy_2
      description          = "Key vaults should have soft delete enabled."
      location             = local.location
      management_group_id  = "/providers/Microsoft.Management/managementGroups/666-666-666-666-666" # replace with your management group ID
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/1e66c121-a66a-4b1f-9b83-0fd99bf0fc2d" # built-in policy
      parameters           = file("parameters/softDeleteKeyVaults.json")
      # other option how to pass parameters
      # parameters           = jsonencode({
      #   effect = {
      #       value = "Audit"
      #   }
      # })
    }
  ]
}
