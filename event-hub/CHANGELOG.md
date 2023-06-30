# Changelog

## Release v1.2.4

### Updated
- Subresource logical name
- Bring variables one level higher
   
## Release v1.2.3

### Removed
- `EventHubVNetConnectionEvent` log in diagnostic settings
- `RuntimeAuditLogs` log  in diagnostic settings
   
## Release v1.2.2

### Updated
- Optional variable `location` for private endpoint
- Optional variable  `resource_group_name` for private endpoint
- Subresources have possibility to override inherited `resource_group_name` parameter
   
## Release v1.2.1

### Added
- Output of identity parameter `principal_id` 

### Updated
- Subresources have possibility to override inherited `resource_group_name` parameter
   
## Release v1.2.0

### Added

- `identity.identity_ids` parameter

### Updated
- `ip_rule` parameter is a list of objects
- `ip_rule` and `virtual_network_rule` parametrs default value set to '[ ]'
- `ip_configuration.subresource_name` is required

### Version upgrade

- azurerm provider: 3.51.0

- terraform: 1.4.5
   
## Release v1.1.1

### Updated

- Private Endpoint tag reference
   
## Release v1.1.0

### Added

- Private Endpoint
   
## Release v1.0.1

### Updated
- Eventhub authorization rule dependency
   
## Release v1.0.0

### Added
- Initial code
   