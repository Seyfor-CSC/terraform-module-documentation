# Introduction
Container App Job module can deploy these resources:
* azurerm_container_app_job (required)

Example variables structure is located in [variables.md](variables.md).

Example use case is located in [test-case/locals.tf](test-case/locals.tf).

You can also see [changelog](CHANGELOG.md).

Terraform documentation:

https://registry.terraform.io/providers/hashicorp/azurerm/4.56.0/docs/resources/container_app_job

> **WARNING:** AzureRM provider had been updated to a new major version. Many breaking changes were implemented. See the [providers guide](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/4.0-upgrade-guide) for more information.

&nbsp;

# Terraform Import
There are a few things you need to do to import resources into .tfstate. In the example below there are resources which can be imported within the module. You may need to modify these commands to the OS on which they will be running (Refer to the [documentation](https://developer.hashicorp.com/terraform/cli/commands/import#example-import-into-resource-configured-with-for_each) for additional details).
### Container App Job
* terraform import '`<path-to-module>`.azurerm_container_app_job.container_app_job["`<container-app-job-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.App/jobs/`<container-app-job-name>`'

 > **_NOTE:_** `<path-to-module>` is terraform logical path from root. e.g. _module.container\_app\_job_

&nbsp;

# Outputs
## Structure

| Output Name | Value                 | Comment                                              |
| ----------- | --------------------- | ---------------------------------------------------- |
| outputs     | name                  |                                                      |
|             | id                    |                                                      |
|             | principal_id          | principal_id (object_id) of system assigned identity |
|             | event_stream_endpoint |                                                      |
|             | outbound_ip_addresses |                                                      |

## Example usage of outputs
In the example below, outputted _id_ of the deployed Container App Job module is used as a value for the _scope_ variable in Role Assignment resource.
```
module "caj" {
    source = "git@github.com:seyfor-csc/mit.container-app-job.git?ref=v1.0.0"
    config = [
        {
            name                         = "sey-terraform-ne-caj01"
            resource_group_name          = "SEY-TERRAFORM-NE-RG01"
            location                     = "northeurope"
            container_app_environment_id = azurerm_container_app_environment.cae.id
            replica_timeout_in_seconds   = 10
            manual_trigger_config = {
                parallelism              = 4
                replica_completion_count = 1
            }
            template = {
                container = {
                image  = "hello-world:latest"
                name   = "testcontainerappsjob0"
                cpu    = 0.5
                memory = "1Gi"
                }
            }
        }
    ]
}

data "azurerm_client_config" "azurerm_client_config" {
}

resource "azurerm_role_assignment" "role_assignment" {
    scope                = module.caj.outputs.sey-terraform-ne-caj01.id # This is how to use output values
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