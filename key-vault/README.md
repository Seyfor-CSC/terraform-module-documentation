# Introduction
Key Vault module can deploy these resources:
* azurerm_key_vault (required)
* azurerm_monitor_diagnostic_setting (optional)
* azurerm_private_endpoint (optional)

Example variables structure is located in [variables.md](variables.md).

Example use case is located in [test-case/locals.tf](test-case/locals.tf).

You can also see [changelog](changelog.md).

Terraform documentation:

https://registry.terraform.io/providers/hashicorp/azurerm/3.73.0/docs/resources/key_vault

https://registry.terraform.io/providers/hashicorp/azurerm/3.73.0/docs/resources/monitor_diagnostic_setting

https://registry.terraform.io/providers/hashicorp/azurerm/3.73.0/docs/resources/private_endpoint

&nbsp;

# Terraform Import
There are a few things you need to do to import resources into .tfstate. In the example below there are resources which can be imported within the module. You may need to modify these commands to the OS on which they will be running (Refer to the [documentation](https://developer.hashicorp.com/terraform/cli/commands/import#example-import-into-resource-configured-with-for_each) for additional details).
### Key Vault
* terraform import '`<path-to-module>`.azurerm_key_vault.key_vault["`<key-vault-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.KeyVault/vaults/`<key-vault-name>`'
### Diagnostic Setting
* terraform import '`<path-to-module>`.azurerm_monitor_diagnostic_setting.diagnostic_setting["`<key-vault-name>`_`<diag-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.KeyVault/vaults/`<key-vault-name>`|`<diag-name>`'
 ### Private Endpoint
* terraform import '`<path-to-module>`.module.private_endpoint.azurerm_private_endpoint.private_endpoint["`<private-endpoint-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Network/privateEndpoints/`<private-endpoint-name>`'

 > **_NOTE:_** `<path-to-module>` is terraform logical path from root. e.g. _module.key\_vault_

&nbsp;

# Outputs
## Structure

| Output Name | Value | Comment |
| ----------- | ----- | ------- |
| outputs     | name  |         |
|             | id    |         |

## Example usage of outputs
In the example below, outputted _id_ of the deployed Key Vault module is used as a value for the _scope_ variable in Role Assignment resource.
```
module "kv" {
    source = "git@github.com:Seyfor-CSC/mit.key-vault.git?ref=v1.0.0"
    config = [
        {
            name                = "SEY-TERRAFORM-NE-KV01"
            location            = "northeurope"
            resource_group_name = "SEY-TERRAFORM-NE-RG01"
            sku_name            = "standard"
        }
    ]
}

data "azurerm_client_config" "azurerm_client_config" {
}

resource "azurerm_role_assignment" "role_assignment" {
    scope                = module.kv.outputs.sey-terraform-ne-kv01.id # This is how to use output values
    role_definition_name = "Contributor"
    principal_id         = data.azurerm_client_config.azurerm_client_config.object_id

    depends_on = [
        module.kv
    ]
}
```

&nbsp;

# Module Features
No special features in module.

&nbsp;

# Known Issues
We currently log no issues in this module.