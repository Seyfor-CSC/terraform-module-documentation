# Introduction
Application Insights module can deploy these resources:
* azurerm_application_insights (required)

Example variables structure is located in [variables.md](variables.md).

Example use case is located in [test-case/locals.tf](test-case/locals.tf).

You can also see [changelog](CHANGELOG.md).

Terraform documentation:

https://registry.terraform.io/providers/hashicorp/azurerm/4.64.0/docs/resources/application_insights

&nbsp;

# Terraform Import
There are a few things you need to do to import resources into .tfstate. In the example below there are resources which can be imported within the module. You may need to modify these commands to the OS on which they will be running (Refer to the [documentation](https://developer.hashicorp.com/terraform/cli/commands/import#example-import-into-resource-configured-with-for_each) for additional details).

### Application Insights
* terraform import '`<path-to-module>`.azurerm_application_insights.application_insights["`<application-insights-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Insights/components/`<application-insights-name>`'

> **_NOTE:_** `<path-to-module>` is terraform logical path from root. e.g. _module.application\_insights_

&nbsp;

# Outputs
## Structure

| Output Name | Value   | Comment                                     |
| ----------- | ------- | ------------------------------------------- |
| outputs     | name    |                                             |
|             | id      |                                             |
|             | app_id  | The App ID of the Application Insights component |

## Example usage of outputs
In the example below, outputted _id_ of the deployed Application Insights module is used as a value for the _scope_ variable in Role Assignment resource.
```
module "application_insights" {
    source = "git@github.com:seyfor-csc/mit.application-insights.git?ref=v1.0.0"
    config = [
        {
            name                = "SEY-TERRAFORM-NE-APPI01"
            location            = "northeurope"
            resource_group_name = "SEY-APPI-NE-RG01"
            application_type    = "web"
        }
    ]
}

data "azurerm_client_config" "azurerm_client_config" {
}

resource "azurerm_role_assignment" "role_assignment" {
    scope                = module.application_insights.outputs.sey-terraform-ne-appi01.id # This is how to use output values
    role_definition_name = "Contributor"
    principal_id         = data.azurerm_client_config.azurerm_client_config.object_id
}
```

&nbsp;

# Module Features
## Monitoring tags in `ignore_changes` lifecycle block
We reserve the right to include tags dedicated to our product Advanced Monitoring in the `ignore_changes` lifecycle block. This is to prevent the module from deleting those tags. The tags we ignore are: `tags["Platform"]`, `tags["MonitoringTier"]`.

&nbsp;

# Known Issues
We currently log no issues in this module.
