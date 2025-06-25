# Changelog

## Release v2.4.0

## Provider & Terraform Upgrade
- Azurerm provider: 4.33.0 (#48)
- Terraform: 1.12.2 (#48)

## Enhancements

- Upgrade minimal provider version to 4.33.0 (#49)


   
## Release v2.3.1

## Enhancements

- Add tags `Platform` and `MonitoringTier` to `ignore_changes` (#46)


   
## Release v2.3.0

## Provider & Terraform Upgrade
- Azurerm provider: 4.23.0 (#44)
- Terraform: 1.11.2 (#44)
   
## Release v2.2.0

## Enhancements

- Support for `storage_account_id` in diagnostic settings (#40)


   
## Release v2.1.0

## Provider & Terraform Upgrade
- Azurerm provider: 4.14.0 (#28)
- Terraform: 1.10.3 (#28)
   
## Release v2.0.0

## Provider & Terraform Upgrade
- Azurerm provider: 4.1.0 (#24)
- Terraform: 1.9.5 (#24)
## Enhancements
- Implement Minimal Provider Version (#24)
- Remove toset() functions (#24)
   
## Release v1.6.0

## Provider & Terraform Upgrade
- Azurerm provider: 3.108.0 (#22)
- Terraform: 1.8.5 (#22)
   
## Release v1.5.0

## Provider & Terraform Upgrade

- Azurerm provider: 3.96.0 (#18)
- Terraform: 1.7.5 (#18)

## Enhancements

- Replace explicit dependencies with implicit (#18)
   
## Release v1.4.1

## Enhancements

- Make diagnostic settings categories optional (#16)


   
## Release v1.4.0

## Provider & Terraform Upgrade
- Azurerm provider: 3.84.0 (#12)
- Terraform: 1.6.5 (#12)
   
## Release v1.3.1

## Enhancements

- Set default value for `public_network_access_enabled` to false (#10)


   
## Release v1.3.0

## Provider & Terraform Upgrade
- Azurerm provider: 3.73.0 (#8)
- Terraform: 1.5.7 (#8)

   
## Release v1.2.0

### Version upgrade
- Azurerm provider: 3.67.0
- Terraform: 1.5.4
   
## Release v1.1.2

### Updated
- Optional variable `location` for private endpoint
- Optional variable  `resource_group_name` for private endpoint
   
## Release v1.1.1

### Updated
- Output of identity parameter `principal_id` 
- Private endpoint `subresource_name` is required
   
## Release v1.1.0

### Added
- Private Endpoint
### Updated
 - Diagnostic Settings separated into its own .tf file
 - Readme - deleted change log
### Version upgrade
- Azurerm provider: 3.51.0
- Terraform: 1.4.5

   
## Release v1.0.0

### Added 

- Initial code
   