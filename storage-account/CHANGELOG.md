# Changelog

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
   