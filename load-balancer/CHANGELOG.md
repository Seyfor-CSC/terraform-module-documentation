# Changelog

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

- Azurerm provider: 3.96.0 (#19)
- Terraform: 1.7.5 (#19)

## Enhancements

- Replace explicit dependencies with implicit (#19)
   
## Release v1.4.1

## Enhancements

- Make diagnostic settings categories optional (#17)


   
## Release v1.4.0

## Provider & Terraform Upgrade
- Azurerm provider: 3.84.0 (#13)
- Terraform: 1.6.5 (#13)
   
## Release v1.3.0

## Provider & Terraform Upgrade

- Azurerm provider: 3.73.0 (#10)
- Terraform: 1.5.7 (#10)

## Enhancements

- Add `azurerm_lb_nat_rule` and `azurerm_lb_nat_pool` resources (#7)
- Change `azurerm_lb_backend_address_pool`, `azurerm_lb_rule`, and `azurerm_lb_probe` resource deployment requirement to `optional` (#7)
- Add `probes` id and `backend_pools` id to outputs (#8)


   
## Release v1.2.0

### Version upgrade
-	Azurerm provider: 3.67.0
-	Terraform: 1.5.4
### Updated
`backend_pool_name` variable renamed to `backend_address_pool_id`
`rules.backend_pool_name` variable renamed to `rules.backend_address_pool_names` and changed variable type to a list of strings
`rules.probe` variable renamed to `rules.probe_name`

   
## Release v1.1.3

### Version upgrade

- added diagnostic settings
   
## Release v1.1.2

### Version upgrade

- changing logical names for subresources

- backends block is renamed to backend_pools

- fixed bug with outbound rule

- for backend addresses and nics  backend_pool_name is inherited and there is no need to write it out

- virtual network id bug fix


   
## Release v1.1.1

### Version upgrade

- outputs

- readme
   
## Release v1.1.0

### Version upgrade

- azurerm provider: 3.51.0

- terraform: 1.4.5
   
## Release v1.0.3

### Added
- changes in work with nic_association, added vm_name parameter
   
## Release v1.0.2

### Added
- bug fix
   
## Release v1.0.1

### Added
- nic_association
   
## Release v1.0.0

### Added
- Initial code
   