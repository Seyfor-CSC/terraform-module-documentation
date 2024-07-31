locals {
  location = "northeurope"

  naming = {
    rg          = "SEY-TERRAFORM-NE-RG01"
    budget_mg1  = "sey-budget-mg1"
    budget_rg1  = "sey-budget-rg1"
    budget_sub1 = "sey-budget-sub1"
    budget_sub2 = "sey-budget-sub2"
  }

  consumption_budget = [
    # Management Group Level Consumption Budgets
    {
      name                = local.naming.budget_mg1
      management_group_id = "/providers/Microsoft.Management/managementGroups/CSC-Platform" # replace with your own
      amount              = 10

      time_period = {
        start_date = "2025-06-01T00:00:00Z"
      }

      notification = [
        {
          name      = "notification1"
          operator  = "EqualTo"
          threshold = 10

          contact_emails = [
            data.azuread_user.user.user_principal_name
          ]
        }
      ]
    },
    # Resource Group Level Consumption Budgets
    {
      name                = local.naming.budget_rg1
      resource_group_id   = azurerm_resource_group.rg.id
      resource_group_name = azurerm_resource_group.rg.name
      amount              = 10

      time_period = {
        start_date = "2025-06-01T00:00:00Z"
      }

      notification = [
        {
          name      = "notification1"
          operator  = "EqualTo"
          threshold = 10

          contact_emails = [
            data.azuread_user.user.user_principal_name
          ]
        }
      ]
    },
    # Subscription Level Consumption Budgets
    {
      name            = local.naming.budget_sub1
      subscription_id = data.azurerm_subscription.primary.id
      amount          = 123
      time_grain      = "Annually"

      time_period = {
        start_date = "2024-08-01T00:00:00Z"
        end_date   = "2026-08-01T00:00:00Z"
      }

      notification = [
        {
          name      = "notification1"
          operator  = "GreaterThan"
          threshold = 10

          contact_emails = [
            data.azuread_user.user.user_principal_name
          ]

          threshold_type = "Forecasted"
          enabled        = "false"
        }
      ]
    },
    {
      name            = local.naming.budget_sub2
      subscription_id = data.azurerm_subscription.primary.id
      amount          = 12
      time_grain      = "BillingMonth"

      time_period = {
        start_date = "2024-08-01T00:00:00Z"
        end_date   = "2026-08-01T00:00:00Z"
      }

      notification = [
        {
          name      = "notification1"
          operator  = "GreaterThanOrEqualTo"
          threshold = 10

          contact_emails = [
            data.azuread_user.user.user_principal_name
          ]

          threshold_type = "Forecasted"
          enabled        = "false"
        }
      ]
    }
  ]
}
