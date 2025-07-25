locals {
  location = "northeurope"

  naming = {
    policy_1 = "SEY-TERRAFORM-POLICY01"
  }

  policy = [
    {
      name                = local.naming.policy_1
      policy_type         = "Custom"
      display_name        = local.naming.policy_1
      management_group_id = "/providers/Microsoft.Management/managementGroups/666-666-666-666-666" # replace with your own
      description         = "Policy initiative to enforce tagging on the RG level."
      metadata = jsonencode({
        category = "Tags"
      })
      parameters = file("parameters/SEY-TERRAFORM-POLICY01.json")
      # other option how to pass parameters
      # parameters = jsonencode({
      # })

      policy_definition_reference = [
        {
          reference_id : "RequiredRGTagServiceOwner",
          policy_definition_id : "/providers/Microsoft.Authorization/policyDefinitions/96670d01-0a4d-4649-9c89-2d3abc0a5025",
          parameter_values = jsonencode(
            {
              tagName = { value = "[parameters('RequiredRGTagServiceOwner')]" }
            }
          )
        },
        {
          reference_id : "RequiredRGTagAPMID",
          policy_definition_id : "/providers/Microsoft.Authorization/policyDefinitions/96670d01-0a4d-4649-9c89-2d3abc0a5025",
          parameter_values = jsonencode(
            {
              tagName = { value = "[parameters('RequiredRGTagAPMID')]" }
            }
          )
        }
      ]
    }
  ]
}
