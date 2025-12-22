# Changelog

## Release v2.7.0

## Provider & Terraform Upgrade
- Azurerm provider: 4.56.0 (#57)
- Terraform: 1.14.2 (#57)
- OpenTofu: 1.11.1 (#57)
   
## Release v2.6.0

## Enhancements

- Add `azurerm_data_protection_backup_policy_blob_storage` and `azurerm_data_protection_backup_policy_postgresql_flexible_server` resources (#55)


   
## Release v2.5.0

## Provider & Terraform Upgrade
- Azurerm provider: 4.45.0 (#53)
- Terraform: 1.13.3 (#53)
   
## Release v2.4.0

## Provider & Terraform Upgrade
- Azurerm provider: 4.33.0 (#50)
- Terraform: 1.12.2 (#50)

## Enhancements

- Upgrade minimal provider version to 4.33.0 (#51)


   
## Release v2.3.1

## Enhancements

- Add tags `Platform` and `MonitoringTier` to `ignore_changes` (#48)


   
## Release v2.3.0

## Provider & Terraform Upgrade
- Azurerm provider: 4.23.0 (#45 #46)
- Terraform: 1.11.2 (#45 #46)
   
## Release v2.2.0

## Enhancements

- Support for `storage_account_id` in diagnostic settings (#41)


   
## Release v2.1.0

## Provider & Terraform Upgrade
- Azurerm provider: 4.14.0 (#29)
- Terraform: 1.10.3 (#29)
   
## Release v2.0.0

## Provider & Terraform Upgrade
- Azurerm provider: 4.1.0 (#26)
- Terraform: 1.9.5 (#26)
## Enhancements
- Implement Minimal Provider Version (#26)
- Remove toset() functions (#26)
   
## Release v1.6.0

## Provider & Terraform Upgrade
- Azurerm provider: 3.108.0 (#24)
- Terraform: 1.8.5 (#24)
   
## Release v1.5.0

## Provider & Terraform Upgrade

- Azurerm provider: 3.96.0 (#22)
- Terraform: 1.7.5 (#22)

## Enhancements

- Replace explicit dependencies with implicit (#22)
   
## Release v1.4.1

## Enhancements

- Make diagnostic settings categories optional (#20)


   
## Release v1.4.0

## Provider & Terraform Upgrade
- Azurerm provider: 3.84.0 (#16)
- Terraform: 1.6.5 (#16)
   
## Release v1.3.1

## Enhancements

- Rename `backup_policy` variable to `backup_policy_disk` (#14)
- Rename `policy` output to `disk_policy` (#14)

   
## Release v1.3.0

## Provider & Terraform Upgrade
- Azurerm provider: 3.73.0 (#12)
- Terraform: 1.5.7 (#12)

   
## Release v1.2.1

### Added
* `azurerm_data_protection_backup_policy_disk` id to outputs in https://github.com/Seyfor-CSC/mit.backup-vault/pull/8
   
## Release v1.2.0

### Version upgrade
-	Azurerm provider: 3.67.0
-	Terraform: 1.5.4
   
## Release v1.1.3

### Updated
- Output of identity parameter `principal_id` 
   
## Release v1.1.2

### Updated

- Output of identity parameter `principal_id`
   
## Release v1.1.1

### Added

- `identity` parameter
   
## Release v1.1.0

Version upgrade:

- Azurerm provider: 3.51.0

- Terraform: 1.4.5

   
## Release v1.0.0

### Added

- Initial code
   