# Introduction
Private endpoint module can deploy these resources:
* azurerm_private_endpoint (required)

Example variables structure is located in [variables.md](variables.md).

Example vuse case is located in [test-case/locals.tf](test-case/locals.tf).

You can see also see [changelog](changelog.md)

Terraform documentation: 

https://registry.terraform.io/providers/hashicorp/azurerm/3.84.0/docs/resources/private_endpoint

&nbsp;

# Terraform Import
There are a few things you need to do to import resources into .tfstate. In the example below there are resources which can be imported within the module. You may need to modify these commands to the OS on which they will be running (Refer to the [documentation](https://developer.hashicorp.com/terraform/cli/commands/import#example-import-into-resource-configured-with-for_each) for additional details).
 ### Private Endpoint
* terraform import '`<path-to-module>`.azurerm_private_endpoint.private_endpoint["`<private-endpoint-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Network/privateEndpoints/`<private-endpoint-name>`'

 > **_NOTE:_** `<path-to-module>` is terraform logical path from root. e.g. _module.private\_endpoint_

&nbsp;

# Outputs
There are no outputs.

&nbsp;

# Module Features
No special features in module.

&nbsp;

# Known Issues
We currently log no issues in this module.