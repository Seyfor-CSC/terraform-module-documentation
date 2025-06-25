# Changelog

## Release v2.4.0

## Provider & Terraform Upgrade
- Azurerm provider: 4.33.0 (#86)
- Terraform: 1.12.2 (#86)

## Enhancements

- Upgrade minimal provider version to 4.33.0 (#88)


   
## Release v2.3.1

## Enhancements

- Add tags `Platform` and `MonitoringTier` to `ignore_changes` (#84)


   
## Release v2.3.0

## Provider & Terraform Upgrade
- Azurerm provider: 4.23.0 (#77)
- Terraform: 1.11.2 (#77)
   
## Release v2.2.0

## Enhancements

- Support for `storage_account_id` in diagnostic settings (#73)


   
## Release v2.1.1

## Bug Fixes

- Fix `file_share` and `container` outputs (#59)
- Fix `storage_account_id` to be used unless `storage_account_name` is used (#60)


## Enhancements

- Fix import commands of `file_shares` and `containers` (#61)


   
## Release v2.1.0

## Provider & Terraform Upgrade
- Azurerm provider: 4.14.0 (#52 #53)
- Terraform: 1.10.3 (#52 #53)
   
## Release v2.0.0

## Provider & Terraform Upgrade
- Azurerm provider: 4.1.0 (#47)
- Terraform: 1.9.5 (#47)
## Enhancements
- Implement Minimal Provider Version (#47)
- Remove toset() functions (#47)
   
## Release v1.9.1

## Bug Fixes

- Resolve diagnostic settings redeployment (#48)



   
## Release v1.9.0

## Provider & Terraform Upgrade
- Azurerm provider: 3.108.0 (#44)
- Terraform: 1.8.5 (#44)
   
## Release v1.8.0

## Provider & Terraform Upgrade

- Azurerm provider: 3.97.0 (#40)
- Terraform: 1.7.5 (#40)

## Enhancements

- Replace explicit dependencies with implicit (#40)
   
## Release v1.7.1

## Enhancements

- Make diagnostic settings categories optional (#38)


   
## Release v1.7.0

## Provider & Terraform Upgrade
- Azurerm provider: 3.84.0 (#34)
- Terraform: 1.6.5 (#34)
   
## Release v1.6.0

## Enhancements

- Add `azurerm_backup_container_storage_account` and `azurerm_backup_protected_file_share` resources for File Share backups (#29)


   
## Release v1.5.1

## Enhancements

- Set default value for `public_network_access_enabled` to false (#27)


   
## Release v1.5.0

## Provider & Terraform Upgrade
- Azurerm provider: 3.73.0 (#25)
- Terraform: 1.5.7 (#25)

## Bug Fixes
 - Set `private_link_access` variable default value to `[]` (#25)

   
## Release v1.4.0

## Enhancements

- Remove provisioner (#19)


   
## Release v1.3.2

## Enhancements

- Update provisioner condition & dependency (#17)


   
## Release v1.3.1

### Updated
- Provisioner work with subscription context 
   
## Release v1.3.0

### Version upgrade
-	Azurerm provider: 3.67.0
-	Terraform: 1.5.4

### Added
- Resource `azurerm_storage_management_policy`
   
## Release v1.2.6

### Updated
- Provisioner trigger changed to timestamp()
   
## Release v1.2.5

### Updated
- Enabled provisioner
   
## Release v1.2.4

### Updated
- Optional variable `location` for private endpoint
- Optional variable  `resource_group_name` for private endpoint
   
## Release v1.2.3

### Added
- primary_blob_endpoint to outputs
   
## Release v1.2.2

### Updated
- private endpoint dependency
- private endpoint deployment condition
   
## Release v1.2.1

### Added
- `azure_files_authentication` optional parameter
### Updated
- `ip_configuration.subresource_name` is required
   
## Release v1.2.0

### Added
- Import commands for diagnostic settings of blobs, tables, queues and files

### Updated
- `file_share.acl` condition

### Version upgrade
- Azurerm provider: 3.51.0
- Terraform: 1.4.5
   
## Release v1.1.2

### Updated
- `private_link_access` for_each condition
   
## Release v1.1.1

### Added
- Provisioner - `az login` command output supression
   
## Release v1.1.0

### Added

- Private Endpoint
- File Share
- Share Properties
- Blob Properties
   
## Release v1.0.0

### Added

- Initial code
   