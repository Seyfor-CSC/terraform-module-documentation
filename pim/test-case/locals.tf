locals {

  pim = [
    {
      type               = "Active"
      custom_name        = "example-name"
      scope              = data.azurerm_subscription.primary.id
      role_definition_id = "${data.azurerm_subscription.primary.id}${data.azurerm_role_definition.reader.id}"
      principal_id       = data.azurerm_client_config.example.object_id

      schedule = {
        start_date_time = plantimestamp()
        expiration = {
          duration_days = 30
        }
      }

      justification = "Expiration Duration Set"

      ticket = {
        number = "1"
        system = "Jira"
      }
    },
    {
      type               = "Eligible"
      scope              = data.azurerm_subscription.primary.id
      role_definition_id = "${data.azurerm_subscription.primary.id}${data.azurerm_role_definition.contributor.id}"
      principal_id       = data.azurerm_client_config.example.object_id

      schedule = {
        start_date_time = plantimestamp()
        expiration = {
          duration_hours = 8
        }
      }
    }
  ]
}
