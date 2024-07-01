# Introduction
Container App module can deploy these resources:
* azurerm_container_app (required)

Example variables structure is located in [variables.md](variables.md).

Example use case is located in [test-case/locals.tf](test-case/locals.tf).

You can also see [changelog](CHANGELOG.md).

Terraform documentation:

https://registry.terraform.io/providers/hashicorp/azurerm/3.108.0/docs/resources/container_app

&nbsp;

# Terraform Import
There are a few things you need to do to import resources into .tfstate. In the example below there are resources which can be imported within the module. You may need to modify these commands to the OS on which they will be running (Refer to the [documentation](https://developer.hashicorp.com/terraform/cli/commands/import#example-import-into-resource-configured-with-for_each) for additional details).
### Container App
* terraform import '`<path-to-module>`.azurerm_container_app.container_app["`<container-app-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.App/containerApps/`<container-app-name>`'

 > **_NOTE:_** `<path-to-module>` is terraform logical path from root. e.g. _module.container\_app_

&nbsp;

# Outputs
## Structure

| Output Name | Value          | Comment                                              |
| ----------- | --------------------- | --------------------------------------------- |
| outputs     | name                  |                                               |
|             | id                    |                                               |
|             | latest_revision_fqdn  |                                               |
|             | latest_revision_name  |                                               |
|             | outbound_ip_addresses |                                               |

## Example usage of outputs
In the example below, outputted _id_ of the deployed Container App module is used as a value for the _scope_ variable in Role Assignment resource.
```
module "ca" {
    source = "git@github.com:Seyfor-CSC/mit.container-app.git?ref=v1.0.0"
    config = [
        {
            name                         = "SEYTERRAFORMNECA01"
            resource_group_name          = "SEY-TERRAFORM-NE-RG01"
            container_app_environment_id = azurerm_container_app_environment.container_app_environment.id
            revision_mode                = "Single"
            template = {
                container = [
                    {
                        name    = "examplecontainerapp"
                        image   = "mcr.microsoft.com/azuredocs/containerapps-helloworld:latest"
                        cpu     = 0.25
                        memory  = "0.5Gi"
                    }
                ]
            }
        }
    ]
}

data "azurerm_client_config" "azurerm_client_config" {
}

resource "azurerm_role_assignment" "role_assignment" {
    scope                = module.ca.outputs.seyterraformneca01.id # This is how to use output values
    role_definition_name = "Contributor"
    principal_id         = data.azurerm_client_config.azurerm_client_config.object_id
}
```

&nbsp;

# Module Features
No special features in module.

&nbsp;

# Known Issues
We currently log no issues in this module.