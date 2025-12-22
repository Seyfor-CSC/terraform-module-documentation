# Introduction
Key Vault Seeding module can deploy these resources:
* azurerm_key_vault_secret (optional)
* random_password (optional)

Example variables structure is located in [variables.md](variables.md).

Example use case is located in [test-case/locals.tf](test-case/locals.tf).

You can also see [changelog](CHANGELOG.md).

Terraform documentation:

https://registry.terraform.io/providers/hashicorp/azurerm/4.56.0/docs/resources/key_vault_secret

https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password

&nbsp;

> **WARNING:** AzureRM provider had been updated to a new major version. Many breaking changes were implemented. See the [providers guide](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/4.0-upgrade-guide) for more information.

# Terraform Import
There are a few things you need to do to import resources into .tfstate. In the example below there are resources which can be imported within the module. You may need to modify these commands to the OS on which they will be running (Refer to the [documentation](https://developer.hashicorp.com/terraform/cli/commands/import#example-import-into-resource-configured-with-for_each) for additional details).
### Key Vault Secret
* terraform import '`<path-to-module>`.azurerm_key_vault_secret.key_vault_secret["`<secret-name>`"]' 'https://`<key-vault-name>`.vault.azure.net/secrets/`<secret-name>`/`<secret-version>`'

 > **_NOTE:_** `<path-to-module>` is terraform logical path from root. e.g. _module.key\_vault\_seeding_
 
 > **_NOTE:_** You should not be importing secrets as it is a security risk.

&nbsp;

# Outputs
## Structure

| Output Name | Value                   | Comment |
| ----------- | ----------------------- | ------- |
| outputs     | id                      |         |
|             | resource_id             |         |
|             | resource_versionless_id |         |


&nbsp;

# Module Features
## Random Secret Generator
This module has a resource called `random_password` which is used to generate random secret values. This way, hardcoding secrets in the code can be avoided. A random password will only be generated if you don't set neither `value` nor `value_wo` variable in the secret. Go to [test-case/locals.tf](test-case/locals.tf) to see an example of how to use this feature.
## Monitoring tags in `ignore_changes` lifecycle block
We reserve the right to include tags dedicated to our product Advanced Monitoring in the `ignore_changes` lifecycle block. This is to prevent the module from deleting those tags. The tags we ignore are: `tags["Platform"]`, `tags["MonitoringTier"]`.

&nbsp;

# Known Issues
We currently log no issues in this module.
