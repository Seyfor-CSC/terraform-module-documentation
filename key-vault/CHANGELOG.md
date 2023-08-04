# Changelog

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
   