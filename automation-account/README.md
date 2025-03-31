# Introduction
Automation Account module can deploy these resources:
* azurerm_automation_account (required)
* azurerm_automation_runbook (optional)
* azurerm_automation_job_schedule (optional)
* azurerm_automation_schedule (optional)
* azurerm_monitor_diagnostic_setting (optional)
* azurerm_private_endpoint (optional)

Example variables structure is located in [variables.md](variables.md).

Example use case is located in [test-case/locals.tf](test-case/locals.tf).

You can also see [changelog](CHANGELOG.md).

Terraform documentation:

https://registry.terraform.io/providers/hashicorp/azurerm/4.23.0/docs/resources/automation_account

https://registry.terraform.io/providers/hashicorp/azurerm/4.23.0/docs/resources/automation_runbook

https://registry.terraform.io/providers/hashicorp/azurerm/4.23.0/docs/resources/automation_job_schedule

https://registry.terraform.io/providers/hashicorp/azurerm/4.23.0/docs/resources/automation_schedule

https://registry.terraform.io/providers/hashicorp/azurerm/4.23.0/docs/resources/monitor_diagnostic_setting

https://registry.terraform.io/providers/hashicorp/azurerm/4.23.0/docs/resources/private_endpoint

> **WARNING:** AzureRM provider had been updated to a new major version. Many breaking changes were implemented. See the [providers guide](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/4.0-upgrade-guide) for more information.

&nbsp;

# Terraform Import
There are a few things you need to do to import resources into .tfstate. In the example below there are resources which can be imported within the module. You may need to modify these commands to the OS on which they will be running (Refer to the [documentation](https://developer.hashicorp.com/terraform/cli/commands/import#example-import-into-resource-configured-with-for_each) for additional details).
### Automation Account
* terraform import '`<path-to-module>`.azurerm_automation_account.automation_account["`<automation-account-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Automation/automationAccounts/`<automation-account-name>`'
### Automation Runbook
* terraform import '`<path-to-module>`.azurerm_automation_runbook.automation_runbook["`<automation-account-name>`_`<automation-runbook-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/automationAccounts/`<automation-account-name>`/runbooks/`<automation-runbook-name>`'
### Automation Job Schedule
* terraform import '`<path-to-module>`.azurerm_automation_job_schedule.automation_job_schedule["`<automation-account-name>`\_`<automation-runbook-name>`\_`<automation-job-schedule-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Automation/automationAccounts/`<automation-account-name>`/schedules/`<automation-job-schedule-name>`|/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/automationAccounts/`<automation-account-name>`/runbooks/`<automation-runbook-name>`'
### Automation Schedule
* terraform import '`<path-to-module>`.azurerm_automation_schedule.automation_schedule["`<automation-account-name>`_`<automation-schedule-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/automationAccounts/`<automation-account-name>`/schedules/`<automation-schedule-name>`'
### Diagnostic Setting
* terraform import '`<path-to-module>`.azurerm_monitor_diagnostic_setting.diagnostic_setting["`<automation-account-name>`_`<diag-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Automation/automationAccounts/`<automation-account-name>`|`<diag-name>`'
 ### Private Endpoint
* terraform import '`<path-to-module>`.module.private_endpoint.azurerm_private_endpoint.private_endpoint["`<private-endpoint-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Network/privateEndpoints/`<private-endpoint-name>`'

 > **_NOTE:_** `<path-to-module>` is terraform logical path from root. e.g. _module.automation\_account_

&nbsp;

# Outputs
## Structure

| Output Name | Value                       | Comment                                              |
| ----------- | --------------------------- | ---------------------------------------------------- |
| outputs     | name                        |                                                      |
|             | id                          |                                                      |
|             | principal_id                | principal_id (object_id) of system assigned identity |
|             | runbook                     | Automation Runbook outputs                           |
|             | &nbsp;name                  |                                                      |
|             | &nbsp;id                    |                                                      |
|             | &nbsp;job_schedule          | Automation Job Schedule outputs                      |
|             | &nbsp;&nbsp;id              |                                                      |
|             | &nbsp;&nbsp;job_schedule_id | The UUID identifying the Automation Job Schedule     |
|             | schedule                    | Automation Schedule outputs                          |
|             | &nbsp;name                  |                                                      |
|             | &nbsp;id                    |                                                      |

## Example usage of outputs
In the example below, outputted _id_ of the deployed Automation Account module is used as a value for the _scope_ variable in Role Assignment resource.
```
module "aa" {
    source = "git@github.com:seyfor-csc/mit.automation-account.git?ref=v1.0.0"
    config = [
        {
            name                = "SEY-TERRAFORM-NE-AA01"
            location            = "northeurope"
            resource_group_name = "SEY-TERRAFORM-NE-RG01"
            sku_name            = "Free"
        }
    ]
}

data "azurerm_client_config" "azurerm_client_config" {
}

resource "azurerm_role_assignment" "role_assignment" {
    scope                = module.aa.outputs.sey-terraform-ne-aa01.id # This is how to use output values
    role_definition_name = "Contributor"
    principal_id         = data.azurerm_client_config.azurerm_client_config.object_id
}
```

&nbsp;

# Module Features
## Lifecycle
This module has a lifecycle block set up like this:
```
lifecycle {
    ignore_changes = [
        start_time
    ]
}
```

&nbsp;

# Known Issues
We currently log no issues in this module.