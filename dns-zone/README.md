# Introduction
DNS Zone module can deploy these resources:
* azurerm_dns_zone (required)

Example variables structure is located in [variables.md](variables.md).

Example use case is located in [test-case/locals.tf](test-case/locals.tf).

You can also see [changelog](changelog.md).

Terraform documentation:

https://registry.terraform.io/providers/hashicorp/azurerm/3.73.0/docs/resources/dns_zone

&nbsp;

# Terraform Import
There are a few things you need to do to import resources into .tfstate. In the example below there are resources which can be imported within the module. You may need to modify these commands to the OS on which they will be running (Refer to the [documentation](https://developer.hashicorp.com/terraform/cli/commands/import#example-import-into-resource-configured-with-for_each) for additional details).
### DNS Zone
* terraform import '`<path-to-module>`.azurerm_dns_zone.dns_zone["`<dns-zone-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.Network/dnsZones/`<dns-zone-name>`'
* 
 > **_NOTE:_** `<path-to-module>` is terraform logical path from root. e.g. _module.dns\_zone_

&nbsp;

# Outputs
## Structure

| Output Name | Value                     | Comment |
| ----------- | ------------------------- | ------- |
| outputs     | name                      |         |
|             | id                        |         |
|             | max_number_of_record_sets |         |
|             | number_of_record_sets     |         |
|             | name_servers              |         |

## Example usage of outputs
In the example below, outputted _id_ of the deployed DNS Zone module is used as a value for the _scope_ variable in Role Assignment resource.
```
module "dns" {
    source = "git@github.com:seyfor-csc/mit.dns-zone.git?ref=v1.0.0"
    config = [
        {
            name                = "sey.terraform.dns01"
            resource_group_name = "SEY-TERRAFORM-NE-RG01"
        }
    ]
}

data "azurerm_client_config" "azurerm_client_config" {
}

resource "azurerm_role_assignment" "role_assignment" {
    scope                = module.dns.outputs.sey-terraform-dns01.id # This is how to use output values. Dots are replaced with hyphens.
    role_definition_name = "Contributor"
    principal_id         = data.azurerm_client_config.azurerm_client_config.object_id

    depends_on = [
        module.dns
    ]
}
```

&nbsp;

# Module Features
## DNS Zone outputs: replacement of dots with hyphens
DNS zone has dots in its name. However, dots are not allowed in the output names. Therefore, these dots are replaced with hyphens in the outputs. For example, if you have a DNS zone named `sey.terraform.dns` in your configuration, the output will be `sey-terraform-dns`. Reference the Example usage of outputs (section above) to see how to use the DNS zone output.

&nbsp;

# Known Issues
We currently log no issues in this module.