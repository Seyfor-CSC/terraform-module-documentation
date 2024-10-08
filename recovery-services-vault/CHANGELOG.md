# Changelog

## Release v2.0.0

## Provider & Terraform Upgrade
- Azurerm provider: 4.1.0 (#30)
- Terraform: 1.9.5 (#30)
## Enhancements
- Implement Minimal Provider Version (#30)
- Remove toset() functions (#30)
   
## Release v1.9.0

## Provider & Terraform Upgrade
- Azurerm provider: 3.108.0 (#28)
- Terraform: 1.8.5 (#28)
   
## Release v1.8.0

## Provider & Terraform Upgrade

- Azurerm provider: 3.96.0 (#25)
- Terraform: 1.7.5 (#25)

## Enhancements

- Replace explicit dependencies with implicit (#25)
   
## Release v1.7.1

## Enhancements

- Make diagnostic settings categories optional (#23)


   
## Release v1.7.0

## Provider & Terraform Upgrade
- Azurerm provider: 3.84.0 (#18)
- Terraform: 1.6.5 (#18)
   
## Release v1.6.0

## Enhancements

- Add `azurerm_backup_policy_file_share` resource (#15)
- Rename `backup_policy` variable to `backup_policy_vm` (#15)
- Rename `policy` output to `vm_policy` (#15)


   
## Release v1.5.2

## Enhancements

- Set default value for `public_network_access_enabled` to false (#13)


   
## Release v1.5.1

## Enhancements

- Set `monitoring_rsv` variables default values to `false` (#11)


   
## Release v1.5.0

## Provider & Terraform Upgrade
- Azurerm provider: 3.73.0 (#9)
- Terraform: 1.5.7 (#9)


   
## Release v1.4.1

## Enhancements

- Set default values of `monitoring_rsv` variables to false (#7)


   
## Release v1.4.0

### Removed
- Removed `azurerm_backup_protected_vm` in https://github.com/Seyfor-CSC/mit.recovery-services-vault/pull/5
### Added
- `azurerm_backup_policy_vm` id to outputs in https://github.com/Seyfor-CSC/mit.recovery-services-vault/pull/5

   
## Release v1.3.0

### Version upgrade
- Azurerm provider: 3.67.0
- Terraform: 1.5.4
   
## Release v1.2.6

### Updated
- Subresource logical name
   
## Release v1.2.5

### Updated
- Optional variable `location` for private endpoint
- Optional variable  `resource_group_name` for private endpoint


   
## Release v1.2.4

### Added
- Output of identity parameter `principal_id` 
- Subresources have possibility to override inherited `resource_group_name` parameter
   
## Release v1.2.3

### Updated
- fixed the `instant_restore_resource_group` parameter
   
## Release v1.2.2

### Updated
- `instant_restore_resource_group` parameter was missing in main.tf
   
## 

### Added
- `classic_vmware_replication_enabled` parameter
- `user_assigned_identity_id ` parameter
- `exclude_disk_luns` parameter
- `include_disk_luns` parameter
- `instant_restore_resource_group` parameter
   
## Release v1.2.0

### Version upgrade

- azurerm provider: 3.51.0

- terraform: 1.4.5
   
## Release v1.1.1

### Updated

- Private Endpoint tag reference
   
## Release v1.1.0

### Added

- Private Endpoint
   
## Release v1.0.0

### Added

- Initial code
   