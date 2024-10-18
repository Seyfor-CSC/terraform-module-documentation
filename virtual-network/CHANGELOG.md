# Changelog

## Release v2.0.0

## Provider & Terraform Upgrade
- Azurerm provider: 4.1.0 (#35)
- Terraform: 1.9.5 (#35)
## Enhancements
- Implement Minimal Provider Version (#35)
- Remove toset() functions (#35)
- Set `private_endpoint_network_policies` default value to `Enabled` (#35)
   
## Release v1.8.1

## Bug Fixes

- Add `nsg_rg`, `route_table_rg`, and `nat_gateway_rg` variables that can be used when resource group name in the subnet-associated resource has different capitalisation of letters. (#33)



   
## Release v1.8.0

## Provider & Terraform Upgrade
- Azurerm provider: 3.108.0 (#31)
- Terraform: 1.8.5 (#31)
   
## Release v1.7.0

## Provider & Terraform Upgrade

- Azurerm provider: 3.96.0 (#28)
- Terraform: 1.7.5 (#28)

## Enhancements

- Replace explicit dependencies with implicit (#28)
   
## Release v1.6.3

## Enhancements

- Make diagnostic settings categories optional (#22)


   
## Release v1.6.2

## Bug Fixes
- Replace try function in outputs with ternary operator (#24)



   
## Release v1.6.1

## Bug Fixes

- Fix outputs condition (#21)



   
## Release v1.6.0

## Bug Fixes

- Add `subscription_id` variable for subnet association purposes (#15)


## Enhancements

- Add option to make a subnet only deployment (#16)


   
## Release v1.5.0

## Provider & Terraform Upgrade
- Azurerm provider: 3.84.0 (#12)
- Terraform: 1.6.5 (#12)
   
## Release v1.4.0

## Enhancements

- Remove `subscription_id` variable (#8)


   
## Release v1.3.0

## Provider & Terraform Upgrade
- Azurerm provider: 3.73.0 (#5)
- Terraform: 1.5.7 (#5)

   
## Release v1.2.0

### Version upgrade
- Azurerm provider: 3.67.0
- Terraform: 1.5.4
   
## Release v1.1.4

### Updated
- Resource reference name
   
## Release v1.1.3

### Updated
- Fixed variables - `resource_group_name` in `subnets` list of object
   
## Release v1.1.2

### Updated
- Subresources have possibility to override inherited `resource_group_name` parameter
   
## Release v1.1.1

Added new outputs:

- vnet: address-space
- subnet: address_prefixes
   
## Release v1.1.0

version upgreade:

- azurerm provider: 3.51.0

- terraform: 1.4.5

   
## Release v1.0.2

### Changed
- Updated subnets names in outputs to not contain "."
   
## Release v1.0.1

### Changed
- Default value for dns_servers
   
## Release v1.0.0

### Added

- Initial code
   