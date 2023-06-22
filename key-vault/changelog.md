# Release v1.2.1
### Updated
- Optional variable `location` for private endpoint
- Optional variable `resource_group_name` for private endpoint

&nbsp;

# Release v1.2.0
### Added
- Secret seeding (consists of several resources)
  - `random_password` - generate secret
  - `role_assignment` - assigns the Key Vault Secrets Officer role to the identity that creates it
  - `key_vault_secret` - the secret itself
### Updated
- Block loop `network_acls`
- Block loop `access_policy`
### Version update
- Azurerm provider: 3.51.0
- Terraform: 1.4.5

&nbsp;

# Release v1.1.1
### Changed
- Private Endpoint tag reference

&nbsp;

# Release v1.1.0
### Added
- Private Endpoint

&nbsp;

# Release v1.0.0
### Added
- Initial code