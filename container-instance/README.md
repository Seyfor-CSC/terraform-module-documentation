# Introduction
Container Instance module can deploy these resources:
* azurerm_container_group (required)

Example variables structure is located in [variables.md](variables.md).

Example use case is located in [test-case/locals.tf](test-case/locals.tf).

You can also see [changelog](changelog.md).

Terraform documentation:

https://registry.terraform.io/providers/hashicorp/azurerm/3.84.0/docs/resources/container_group

&nbsp;

# Terraform Import
There are a few things you need to do to import resources into .tfstate. In the example below there are resources which can be imported within the module. You may need to modify these commands to the OS on which they will be running (Refer to the [documentation](https://developer.hashicorp.com/terraform/cli/commands/import#example-import-into-resource-configured-with-for_each) for additional details).
### Container Instance
* terraform import '`<path-to-module>`.azurerm_container_group.container_group["`<container-instance-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.ContainerInstance/containerGroups/`<container-instance-name>`'

 > **_NOTE:_** `<path-to-module>` is terraform logical path from root. e.g. _module.container\_instance_

&nbsp;

# Outputs
## Structure

| Output Name | Value        | Comment                                                      |
| ----------- | ------------ | ------------------------------------------------------------ |
| outputs     | name         |                                                              |
|             | id           |                                                              |
|             | principal_id | principal_id (object_id) of system assigned identity         |
|             | ip_address   | IP address allocated to the container instance               |
|             | fqdn         | FQDN of the container instance derived from `dns_name_label` |


## Example usage of outputs
In the example below, outputted _id_ of the deployed Container Instance module is used as a value for the _scope_ variable in Role Assignment resource.
```
module "cg" {
    source = "git@github.com:Seyfor-CSC/mit.container-instance.git?ref=v1.0.0"
    config = [
        {
            name                = "SEY-TERRAFORM-NE-CG01"
            location            = "northeurope"
            resource_group_name = "SEY-TERRAFORM-NE-RG01"
            os_type             = "Linux"

            container = [
                {
                    name   = "hello-world"
                    image  = "microsoft/aci-helloworld:latest"
                    cpu    = "0.5"
                    memory = "1.5"
                }
            ]
        }
    ]
}

data "azurerm_client_config" "azurerm_client_config" {
}

resource "azurerm_role_assignment" "role_assignment" {
    scope                = module.cg.outputs.sey-terraform-ne-cg01.id # This is how to use output values
    role_definition_name = "Contributor"
    principal_id         = data.azurerm_client_config.azurerm_client_config.object_id

    depends_on = [
        module.cg
    ]
}
```

&nbsp;

# Module Features
No special features in module.

&nbsp;

# Known Issues
We currently log no issues in this module.