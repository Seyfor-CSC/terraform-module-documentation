locals {
  location = "northeurope"

  naming = {
    policy_1 = "SEY-TERRAFORM-POLICY01"
    policy_2 = "SEY-TERRAFORM-POLICY02"
  }

  policy_definition = [
    {
      name                = local.naming.policy_1
      policy_type         = "Custom"
      mode                = "Indexed"
      display_name        = local.naming.policy_1
      management_group_id = "/providers/Microsoft.Management/managementGroups/666-666-666-666-666" # replace with your own
      description         = "Allow to create resources only in selected locations."
      metadata = jsonencode({
        category = "General"
      })
      parameters = jsonencode({
        allowedLocations = {
          type = "Array"
          metadata = {
            description = "The list of allowed locations for resources."
            displayName = "Allowed locations"
            strongType = "location"
          }
        }
      })

      policy_rule = jsonencode({
        if = {
          not = {
            field = "location"
            in   = "[parameters('allowedLocations')]"
          }
        }
        then = {
          effect = "audit"
        }
      })
    },
    {
      name                = local.naming.policy_2
      policy_type         = "Custom"
      mode                = "All"
      display_name        = local.naming.policy_2
      management_group_id = "/providers/Microsoft.Management/managementGroups/666-666-666-666-666" # replace with your own
      description         = "Disallow to create selected resources."
      metadata = jsonencode({
        category = "General"
      })
      parameters = file("parameters/Disallowed-Resources.json")

      policy_rule = jsonencode({
        if = {
          allOf = [
            {
              field = "type"
              in    = "[parameters('listOfResourceTypesNotAllowed')]"
            },
            {
              value = "[field('type')]"
              exists = true
            }
          ]
        },
        then = {
          effect = "[parameters('effect')]"
        }
      })
    }
  ]
}
