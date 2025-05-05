# Introduction
This module deploys and manages Azure Front Door resources, including:
* azurerm_cdn_frontdoor_profile (required)
* azurerm_cdn_frontdoor_endpoint (optional)
* azurerm_cdn_frontdoor_origin_group (optional)
* azurerm_cdn_frontdoor_origin (optional)
* azurerm_cdn_frontdoor_route (optional)
* azurerm_cdn_frontdoor_custom_domain (optional)
* azurerm_monitor_diagnostic_setting (optional)

Example variables structure is located in [variables.md](variables.md).

Example use case is located in [test-case/locals.tf](test-case/locals.tf).

You can also see [changelog](CHANGELOG.md).

Terraform documentation:

https://registry.terraform.io/providers/hashicorp/azurerm/4.23.0/docs/resources/cdn_frontdoor_profile
  
https://registry.terraform.io/providers/hashicorp/azurerm/4.23.0/docs/resources/cdn_frontdoor_endpoint

https://registry.terraform.io/providers/hashicorp/azurerm/4.23.0/docs/resources/cdn_frontdoor_origin_group

https://registry.terraform.io/providers/hashicorp/azurerm/4.23.0/docs/resources/cdn_frontdoor_origin

https://registry.terraform.io/providers/hashicorp/azurerm/4.23.0/docs/resources/cdn_frontdoor_route

https://registry.terraform.io/providers/hashicorp/azurerm/4.23.0/docs/resources/cdn_frontdoor_custom_domain

https://registry.terraform.io/providers/hashicorp/azurerm/4.23.0/docs/resources/monitor_diagnostic_setting

&nbsp;

# Terraform Import
There are a few things you need to do to import resources into .tfstate. In the example below there are resources which can be imported within the module. You may need to modify these commands to the OS on which they will be running (Refer to the [documentation](https://developer.hashicorp.com/terraform/cli/commands/import#example-import-into-resource-configured-with-for_each) for additional details).
### Front Door Profile
* terraform import '`<path-to-module>`.azurerm_cdn_frontdoor_profile.frontdoor_profile["`<profile-name>`"]'
'/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Cdn/profiles/`<profile-name>`'

### Front Door Endpoint
* terraform import '`<path-to-module>`.azurerm_cdn_frontdoor_endpoint.frontdoor_endpoint["`<profile-name>`\_`<endpoint-name>`"]'
'/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Cdn/profiles/`<profile-name>`/afdEndpoints/`<endpoint-name>`'

### Front Door Origin Group
* terraform import '`<path-to-module>`.azurerm_cdn_frontdoor_origin_group.frontdoor_origin_group["`<profile-name>`\_`<origin-group-name>`"]'
'/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Cdn/profiles/`<profile-name>`/originGroups/`<origin-group-name>`'

### Front Door Origin
* terraform import '`<path-to-module>`.azurerm_cdn_frontdoor_origin.frontdoor_origin["`<profile-name>`\_`<origin_group_name>`\_`<origin-name>`"]'
'/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Cdn/profiles/`<profile-name>`/originGroups/`<origin_group_name>`/origins/`<origin-name>`'

### Front Door Route
* terraform import '`<path-to-module>`.azurerm_cdn_frontdoor_route.frontdoor_route["`<profile-name>`\_`<route-name>`"]'
'/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Cdn/profiles/`<profile-name>`/afdEndpoints/`<endpoint-name>`/routes/`<route-name>`'

### Front Door Custom Domain
* terraform import '`<path-to-module>`.azurerm_cdn_frontdoor_custom_domain.frontdoor_custom_domain["`<profile-name>`\_`<custom-domain-name>`"]'
'/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Cdn/profiles/`<profile-name>`/customDomains/`<custom-domain-name>`'

 > **_NOTE:_** `<path-to-module>` is terraform logical path from root. e.g. _module.frontdoor_

&nbsp;

# Outputs
## Structure
| Output Name | Value           | Comment                                              |
| ----------- | --------------- | ---------------------------------------------------- |
| outputs     | name            |                                                      |
|             | id              |                                                      |
|             | principal_id    | principal_id (object_id) of system assigned identity |
|             | endpoints       | Frontdoor endpoints outputs                          |
|             | &nbsp;id        |                                                      |
|             | &nbsp;host_name |                                                      |
|             | origin_groups   | Frontdoor origin groups outputs                      |
|             | &nbsp;id        |                                                      |
|             | origins         | Frontdoor origins outputs                            |
|             | &nbsp;id        |                                                      |
|             | custom_domains  | Frontdoor custom domains outputs                     |
|             | &nbsp;id        |                                                      |
|             | routes          | Frontdoor routes outputs                             |
|             | &nbsp;id        |                                                      |

## Example usage of outputs
In the example below, outputted _id_ of the deployed Front Door module is used as a value for the _scope_ variable in Role Assignment resource.
```
module "frontdoor" {
    source = "git@github.com:Seyfor-CSC/mit.frontdoor.git?ref=v1.0.0"
    config = [
        {
            name                = "SEY-TERRAFORM-NE-FD01"
            resource_group_name = "SEY-TERRAFORM-NE-RG01"
            sku_name            = "Premium_AzureFrontDoor"
        }
    ]
}

data "azurerm_client_config" "azurerm_client_config" {
}

resource "azurerm_role_assignment" "role_assignment" {
    scope                = module.frontdoor.outputs.sey-terraform-ne-fd01.id # This is how to use output values
    role_definition_name = "Contributor"
    principal_id         = data.azurerm_client_config.azurerm_client_config.object_id
}
```

&nbsp;

# Module Features
## Custom variables
* `cdn_frontdoor_endpoint_name` replaces the `cdn_frontdoor_endpoint_id` variable in the `route` list of objects.
* `cdn_frontdoor_origin_group_name` replaces the `cdn_frontdoor_origin_group_id` variable in the `route` list of objects.
* `cdn_frontdoor_origin_names` replaces the `cdn_frontdoor_origin_ids` variable in the `route` list of objects.
* `cdn_frontdoor_custom_domain_names` replaces the `cdn_frontdoor_custom_domain_ids` variable in the `route` list of objects.
## Monitoring tags in `ignore_changes` lifecycle block
We reserve the right to include tags dedicated to our product Advanced Monitoring in the `ignore_changes` lifecycle block. This is to prevent the module from deleting those tags. The tags we ignore are: `tags["Platform"]`, `tags["MonitoringTier"]`.

&nbsp;

# Known Issues
## Diagnostic Setting metrics updating in place
If any of the diagnostic settings categories is disabled, the diagnostic setting will be updating in place with every run.
### GitHub issue
https://github.com/hashicorp/terraform-provider-azurerm/issues/10388