# Changelog

## Release v1.8.0

## Provider & Terraform Upgrade
- Azurerm provider: 3.108.0 (#25)
- Terraform: 1.8.5 (#25)
## Enhancements
- Remove firewall rules from outputs (#25)
   
## Release v1.7.0

## Provider & Terraform Upgrade

- Azurerm provider: 3.96.0 (#23)
- Terraform: 1.7.5 (#23)

## Enhancements

- Replace explicit dependencies with implicit (#23)
   
## Release v1.6.1

## Enhancements

- Make diagnostic settings categories optional (#21)


   
## Release v1.6.0

## Enhancements
- Add `azurerm_mssql_database_extended_auditing_policy` resource (#20)


   
## Release v1.5.1

## Enhancements

- Remove lifecycle block from diag settings (#15)


   
## Release v1.5.0

## Provider & Terraform Upgrade
- Azurerm provider: 3.84.0 (#13)
- Terraform: 1.6.5 (#13)
   
## Release v1.4.1

## Enhancements

- Set default value for `public_network_access_enabled` to false (#11)


   
## Release v1.4.0

## Provider & Terraform Upgrade

- Azurerm provider: 3.73.0 (#8)
- Terraform: 1.5.7  (#8)

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

   