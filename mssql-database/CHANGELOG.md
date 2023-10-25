# Changelog

## Release v1.4.1

## Enhancements

- Set default value for `public_network_access_enabled` to false (#11)


   
## Release v1.4.0

## Provider & Terraform Upgrade

- Upgrade Azurerm provider & Terraform version (#8)

## Enhancements

- Add `administrator_login` and `administrator_login_password` variables to a ignore_changes lifecycle (#7)


   
## Release v1.3.0

## Enhancements

- Add `azurerm_mssql_elasticpool` resource (#4)


   
## Release v1.2.0

### Version upgrade
-	Azurerm provider: 3.67.0
-	Terraform: 1.5.4
   
## Release v1.1.3

### Updated
- Optional variable `location` for private endpoint
- Optional variable  `resource_group_name` for private endpoint


   
## Release v1.1.2

### Updated

- `idnetity.identity_ids` variable is optional
- database has default value in variables.tf set to `[]`
   
## Release v1.1.1

### Added
- Output of identity parameter `principal_id` 

### Updated
- Private endpoint `subresource_name` is required
   
## Release v1.1.0

### Added

- Private Endpoint
### Version upgrade

- azurerm provider: 3.51.0

- terraform: 1.4.5
   
## Release v1.0.0

### Added

- initial code

   