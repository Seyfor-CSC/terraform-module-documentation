# Introduction
Key Vault Seeding module can deploy these resources:
* azurerm_key_vault_secret (optional)
* random_password (optional)

Example variables structure is located in [variables.md](variables.md).

Example use case is located in [test-case/locals.tf](test-case/locals.tf).

You can also see [changelog](changelog.md).

Terraform documentation:

https://registry.terraform.io/providers/hashicorp/azurerm/3.73.0/docs/resources/key_vault_secret

https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password

&nbsp;

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
This module has a resource called "random_password" which is used to generate random secret values. This way we can avoid hardcoding secrets in the code. For this purpose, we created a variable called `length` of data type number, which is used to define the length of the secret. The default value is 12 characters. You can change the length of the secret by passing a different number to the `length` variable in the key vault secret configuration. If you still decide to hardcode the secret into the code, you can do so by setting the variable called `value` to your desired value. This will override the random secret generator. Go to [test-case/locals.tf](test-case/locals.tf) to see an example of how to use this feature.

&nbsp;

# Known Issues
We currently log no issues in this module.