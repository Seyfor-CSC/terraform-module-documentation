# Changelog

## Release v2.6.1

## Enhancements

- Add parameters to ignore_changes (#85)


   
## Release v2.6.0

## Provider & Terraform Upgrade
- Azurerm provider: 4.56.0 (#84)
- Terraform: 1.14.2 (#84)
- OpenTofu: 1.11.1 (#84)
   
## Release v2.5.0

## Provider & Terraform Upgrade
- Azurerm provider: 4.45.0 (#82)
- Terraform: 1.13.3 (#82)
   
## Release v2.4.1

## Enhancements

- Add `auth_settings_v2` parameter to `ignore_changes` (#79)


   
## Release v2.4.0

## Provider & Terraform Upgrade
- Azurerm provider: 4.33.0 (#77)
- Terraform: 1.12.2 (#77)
   
## Release v2.3.1

## Enhancements

- Add tags `Platform` and `MonitoringTier` to `ignore_changes` (#75)


   
## Release v2.3.0

## Provider & Terraform Upgrade
- Azurerm provider: 4.23.0 (#73)
- Terraform: 1.11.2 (#73)
   
## Release v2.2.0

## Enhancements

- Support for `storage_account_id` in diagnostic settings (#69)


   
## Release v2.1.0

## Provider & Terraform Upgrade
- Azurerm provider: 4.14.0 (#57)
- Terraform: 1.10.3 (#57)
   
## Release v2.0.0

## Provider & Terraform Upgrade
- Azurerm provider: 4.1.0 (#50)
- Terraform: 1.9.5 (#50)
## Enhancements
- Implement Minimal Provider Version (#50)
- Remove toset() functions (#50)
   
## Release v1.6.2

## Enhancements

- Add `scm_ip_restriction_default_action`, `scm_use_main_ip_restriction`, and `scm_minimum_tls_version` variables (#52)


   
## Release v1.6.1

## Enhancements

- Add `scm_ip_restriction` variable (#49)


   
## Release v1.6.0

## Provider & Terraform Upgrade
- Azurerm provider: 3.108.0 (#46)
- Terraform: 1.8.5 (#46)
   
## Release v1.5.0

## Provider & Terraform Upgrade

- Azurerm provider: 3.96.0 (#33)
- Terraform: 1.7.5 (#33)

## Enhancements

- Replace explicit dependencies with implicit (#33)
   
## Release v1.4.2

## Enhancements

- Make diagnostic settings categories optional (#30)


   
## Release v1.4.1

## Enhancements

- Add `connection_string`, `app_settings`, and `sticky_settings` to lifecycle `ignore_changes` (#29)
- Add `use_32_bit_worker` and `sticky_settings` variables (#29)


   
## Release v1.4.0

## Provider & Terraform Upgrade
- Azurerm provider: 3.84.0 (#21)
- Terraform: 1.6.5 (#21)
   
## Release v1.3.0

## Enhancements

- Separate `azurerm_service_plan` resource into its own dedicated module (#17)
- Merge `linux_web_app` and `windows_web_app` outputs (#17)


   
## Release v1.2.1

## Enhancements

- Set default value for `public_network_access_enabled` to false (#16)


   
## Release v1.2.0

## Provider & Terraform Upgrade
- Azurerm provider: 3.73.0 (#11)
- Terraform: 1.5.7 (#11)


   
## Release v1.1.1

## Bug Fixes

- Add missing logs variable in windows web app (#7)



   
## Release v1.1.0

### Version upgrade
-	Azurerm provider: 3.67.0
-	Terraform: 1.5.4
   
## Release v1.0.0

### Added
- Initial code
   