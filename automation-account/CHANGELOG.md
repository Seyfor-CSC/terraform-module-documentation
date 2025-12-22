# Changelog

## Release v2.6.0

## Provider & Terraform Upgrade
- Azurerm provider: 4.56.0 (#60)
- Terraform: 1.14.2 (#60)
- OpenTofu: 1.11.1 (#60)
   
## Release v2.5.0

## Provider & Terraform Upgrade
- Azurerm provider: 4.45.0 (#58)
- Terraform: 1.13.3 (#58)
   
## Release v2.4.0

## Provider & Terraform Upgrade
- Azurerm provider: 4.33.0 (#56)
- Terraform: 1.12.2 (#56)
   
## Release v2.3.1

## Enhancements

- Add tags `Platform` and `MonitoringTier` to `ignore_changes` (#54)


   
## Release v2.3.0

## Provider & Terraform Upgrade
- Azurerm provider: 4.23.0 (#52)
- Terraform: 1.11.2 (#52)
   
## Release v2.2.0

## Enhancements

- Support for `storage_account_id` in diagnostic settings (#48)


   
## Release v2.1.0

## Provider & Terraform Upgrade
- Azurerm provider: 4.14.0 (#36)
- Terraform: 1.10.3 (#36)
   
## Release v2.0.0

## Provider & Terraform Upgrade
- Azurerm provider: 4.1.0 (#33)
- Terraform: 1.9.5 (#33)
## Enhancements
- Implement Minimal Provider Version (#33)
- Remove toset() functions (#33)
   
## Release v1.8.0

## Provider & Terraform Upgrade
- Azurerm provider: 3.108.0 (#31)
- Terraform: 1.8.5 (#31)
   
## Release v1.7.0

## Provider & Terraform Upgrade

- Azurerm provider: 3.96.0 (#27)
- Terraform: 1.7.5 (#27)

## Enhancements

- Replace explicit dependencies with implicit (#27)
   
## Release v1.6.2

## Enhancements

- Make diagnostic settings categories optional (#23)


   
## Release v1.6.1

## Bug Fixes
- Update `monthly_occurrence` variable data type to optional object (#22)



   
## Release v1.6.0

## Provider & Terraform Upgrade
- Azurerm provider: 3.84.0 (#17)
- Terraform: 1.6.5 (#17)
   
## Release v1.5.2

## Enhancements

- Set default value for `public_network_access_enabled` to false (#11)


   
## Release v1.5.1

## Enhancements

- Add automation schedule `start_time` variable to lifecycle ignore_changes (#13)


   
## Release v1.5.0

## Provider & Terraform Upgrade
- Azurerm provider: 3.73.0 (#9)
- Terraform: 1.5.7 (#9)


   
## Release v1.4.0

### Version upgrade
- Azurerm provider: 3.67.0
- Terraform: 1.5.4
   
## Release v1.3.0

### Added
- `azurerm_automation_runbook` resource
- `azurerm_automation_job_schedule` resource
- `azurerm_automation_schedule` resource
### Updated
- README.md format
   
## Release v1.2.2

### Updated
- Optional variable `location` for private endpoint
- Optional variable  `resource_group_name` for private endpoint


   
## Release v1.2.1

### Updated
- Output of identity parameter `principal_id` 
- Private endpoint `subresource_name` is required
   
## Release v1.2.0

### Removed

- `encryption.key_source` parameter

### Version upgrade

- Azurerm provider: 3.51.0

- Terraform: 1.4.5

   
## Release v1.1.0

### Added

- Private Endpoint
   
## Release v1.0.0

### Added

- Initial code
   