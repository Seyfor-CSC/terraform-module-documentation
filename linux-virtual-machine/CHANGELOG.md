# Changelog

## Release v1.3.1

### Added
- Default `os_disk` name value if not provided
   
## Release v1.3.0

### Version upgrade
-	Azurerm provider: 3.67.0
-	Terraform: 1.5.4
   
## Release v1.2.0

### Added
* Add resource Virtual Machine Extension in https://github.com/Seyfor-CSC/mit.linux-virtual-machine/pull/11
   
## Release v1.1.5

### Updated
- Resource reference name
   
## Release v1.1.4

### Updated
-  os disk `name` parameter is now required

   
## Release v1.1.3

### Updated
- `vm_name` parameter changed to `name`
- `disk_name` parameter changed to  `name`
- `nic_name` parameter changed to  `name`
   
## Release v1.1.2

### Updated
- Output of identity parameter `principal_id` 
- Subresources have possibility to override inherited `resource_group_name` parameter
- `tags` parameter value is merged with our default `ManagedBy = "Terraform"` tag
   
## Release v1.1.1

### Added
- Lifecycle for admin username and password
   
## Release v1.1.0

### Version upgrade
- Azurerm provider: 3.51.0
- Terraform: 1.4.5
   
## Release v1.0.2

### Updated
- Test case
   
## Release v1.0.1

### Added
- Optional Data Collection Rule Association
   
## Release v1.0.0

### Added

- Initial code
   