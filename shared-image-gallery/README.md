# Introduction
Shared Image Gallery module can deploy these resources:
* azurerm_shared_image_gallery (required)
* azurerm_shared_image (optional)
* azurerm_shared_image_version (optional)

Example variables structure is located in [variables.md](variables.md).

Example use case is located in [test-case/locals.tf](test-case/locals.tf).

You can also see [changelog](CHANGELOG.md).

Terraform documentation:

https://registry.terraform.io/providers/hashicorp/azurerm/3.108.0/docs/resources/shared_image_gallery

https://registry.terraform.io/providers/hashicorp/azurerm/3.108.0/docs/resources/shared_image

https://registry.terraform.io/providers/hashicorp/azurerm/3.108.0/docs/resources/shared_image_version

&nbsp;

# Terraform Import
There are a few things you need to do to import resources into .tfstate. In the example below there are resources which can be imported within the module. You may need to modify these commands to the OS on which they will be running (Refer to the [documentation](https://developer.hashicorp.com/terraform/cli/commands/import#example-import-into-resource-configured-with-for_each) for additional details).
### Shared Image Gallery
* terraform import '`<path-to-module>`.azurerm_shared_image_gallery.shared_image_gallery["`<shared-image-gallery-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Compute/galleries/`<shared-image-gallery-name>`'
### Shared Image
* terraform import '`<path-to-module>`.azurerm_shared_image.shared_image["`<shared-image-gallery-name>`_`<shared-image-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Compute/galleries/`<shared-image-gallery-name>`/images/`<shared-image-name>`'
### Shared Image Version
* terraform import '`<path-to-module>`.azurerm_shared_image_version.shared_image_version["`<shared-image-name>`_`<shared-image-version-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Compute/galleries/`<shared-image-gallery-name>`/images/`<shared-image-name>`/versions/`<shared-image-version-name>`'

 > **_NOTE:_** `<path-to-module>` is terraform logical path from root. e.g. _module.shared\_image\_gallery_

&nbsp;

# Outputs
## Structure

| Output Name | Value               | Comment                      |
| ----------- | ------------------- | ---------------------------- |
| outputs     | name                |                              |
|             | id                  |                              |
|             | shared_image        | Shared Image outputs         |
|             | &nbsp;name          |                              |
|             | &nbsp;id            |                              |
|             | &nbsp;image_version | Shared Image Version outputs |
|             | &nbsp;&nbsp;name    |                              |
|             | &nbsp;&nbsp;id      |                              |

## Example usage of outputs
In the example below, outputted _id_ of the deployed Shared Image Gallery module is used as a value for the _scope_ variable in Role Assignment resource.
```
module "acg" {
    source = "git@github.com:seyfor-csc/mit.shared-image-gallery.git?ref=v1.0.0"
    config = [
        {
            name                = "SEY-TERRAFORM-NE-ACG01"
            location            = "northeurope"
            resource_group_name = "SEY-TERRAFORM-NE-RG01"
        }
    ]
}

data "azurerm_client_config" "azurerm_client_config" {
}

resource "azurerm_role_assignment" "role_assignment" {
    scope                = module.acg.outputs.sey-terraform-ne-acg01.id # This is how to use output values
    role_definition_name = "Contributor"
    principal_id         = data.azurerm_client_config.azurerm_client_config.object_id

    depends_on = [
        module.acg
    ]
}
```

&nbsp;

# Module Features
No special features in module.

&nbsp;

# Known Issues
We currently log no issues in this module.