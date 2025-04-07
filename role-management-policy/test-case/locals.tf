locals {
  location = "northeurope"

  role_management_policy = [
    {
      custom_name        = "SEY-ROLEMANAGEMENTPOLICY01"
      role_definition_id = data.azurerm_role_definition.rg_contributor.id
      scope              = azurerm_resource_group.rg.id

      eligible_assignment_rules = {
        expiration_required = true
      }

      active_assignment_rules = {
        expire_after          = "P90D"
        require_justification = true
      }

      activation_rules = {
        maximum_duration = "PT1H"
        require_approval = false
        approval_stage = {
          primary_approver = [
            {
              object_id = data.azuread_user.user.object_id
              type      = "User"
            }
          ]
        }
      }

      notification_rules = {
        eligible_assignments = {
          admin_notifications = {
            notification_level    = "Critical"
            default_recipients    = false
            additional_recipients = [data.azuread_user.user.user_principal_name]
          }
          approver_notifications = {
            notification_level    = "Critical"
            default_recipients    = false
            additional_recipients = [data.azuread_user.user.user_principal_name]
          }
          assignee_notifications = {
            notification_level    = "Critical"
            default_recipients    = false
            additional_recipients = [data.azuread_user.user.user_principal_name]
          }
        }
      }
    }
  ]
}
