# Changelog

## Release v2.1.0

## Provider & Terraform Upgrade
- Azurerm provider: 4.14.0 (#37)
- Terraform: 1.10.3 (#37)
   
## Release v2.0.0

## Provider & Terraform Upgrade
- Azurerm provider: 4.1.0 (#34)
- Terraform: 1.9.5 (#34)
## Enhancements
- Implement Minimal Provider Version (#34)
- Remove toset() functions (#34)
   
## Release v1.9.0

## Provider & Terraform Upgrade
- Azurerm provider: 3.108.0 (#32)
- Terraform: 1.8.5 (#32)
   
## Release v1.8.0

## Provider & Terraform Upgrade

- Azurerm provider: 3.96.0 (#29)
- Terraform: 1.7.5 (#29)

## Enhancements

- Replace explicit dependencies with implicit (#29)
   
## Release v1.7.1

## Enhancements

- Make diagnostic settings categories optional (#27)


   
## Release v1.7.0

## Bug Fixes

- `tenant_id` variable is now required after removing the `azurerm_client_config` data block that provided its value (#23)



   
## Release v1.6.0

## Provider & Terraform Upgrade
- Azurerm provider: 3.84.0 (#21)
- Terraform: 1.6.5 (#21)
   
## Release v1.5.1

## Bug Fixes

- Change `azurerm_monitor_diagnostic_setting` resource reference name from `diagnostic_settings` to `diagnostic_setting` (#17)


## Enhancements

- Set default value for `public_network_access_enabled` to false (#19)


   
## Release v1.5.0

## Provider & Terraform Upgrade
- Azurerm provider: 3.73.0 (#15)
- Terraform: 1.5.7 (#15)
   
## Release v1.4.0

### Removed
- Resources `key_vault_secret` + `random_password` (removed seeding)
   
## Release v1.3.0

### Version upgrade
-	Azurerm provider: 3.67.0
-	Terraform: 1.5.4
   
## Release v1.2.1

### Updated
- Optional variable `location` for private endpoint
- Optional variable  `resource_group_name` for private endpoint
   
## Release v1.2.0

### Added
- secret seeding (consists of several resources)
  - `random_password` - generate secret 
  - `role_assignment` - assigns the Key Vault Secrets Officer role to the identity that creates it
  - `key_vault_secret` - the secret itself

### Updated
- block loop `network_acls`
- block loop `access_policy`

### Version update

- azurerm provider: 3.51.0
- terraform: 1.4.5
   
## Release v1.1.1

### Changed

- Private Endpoint tag reference
   
## Release v1.1.0

### Added

- Private Endpoint
   
## Release v1.0.0

### Added
- Initial code
   