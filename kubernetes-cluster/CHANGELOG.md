# Changelog

## Release v2.6.0

## Enhancements

- Add `node_count` to `ignore_changes` when `auto_scaling_enabled = true` (#70)


   
## Release v2.5.0

## Provider & Terraform Upgrade
- Azurerm provider: 4.45.0 (#72)
- Terraform: 1.13.3 (#72)
   
## Release v2.4.1

## Enhancements

- Add `network_data_plane` parameter (#68)


   
## Release v2.4.0

## Provider & Terraform Upgrade
- Azurerm provider: 4.33.0 (#66)
- Terraform: 1.12.2 (#66)
   
## Release v2.3.1

## Enhancements

- Add tags `Platform` and `MonitoringTier` to `ignore_changes` (#64)


   
## Release v2.3.0

## Provider & Terraform Upgrade
- Azurerm provider: 4.23.0 (#62)
- Terraform: 1.11.2 (#62)
   
## Release v2.2.0

## Enhancements

- Support for `storage_account_id` in diagnostic settings (#58)


   
## Release v2.1.2

## Enhancements

- Add `drain_timeout_in_minutes` & `node_soak_duration_in_minutes` parameters (#57)


   
## Release v2.1.1

## Enhancements

- Add `monitor_metrics` & `msi_auth_for_monitoring_enabled` parameters (#55)


   
## Release v2.1.0

## Provider & Terraform Upgrade
- Azurerm provider: 4.14.0 (#41)
- Terraform: 1.10.3 (#41)
   
## Release v2.0.0

## Provider & Terraform Upgrade
- Azurerm provider: 4.1.0 (#37)
- Terraform: 1.9.5 (#37)
## Enhancements
- Implement Minimal Provider Version (#37)
- Remove toset() functions (#37)
   
## Release v1.6.0

## Provider & Terraform Upgrade
- Azurerm provider: 3.108.0 (#34)
- Terraform: 1.8.5 (#34)
   
## Release v1.5.0

## Provider & Terraform Upgrade

- Azurerm provider: 3.96.0 (#26)
- Terraform: 1.7.5 (#26)

## Enhancements

- Replace explicit dependencies with implicit (#26)
- Add `upgrade_settings` parameter (#29)


   
## Release v1.4.2

## Enhancements

- Make diagnostic settings categories optional (#23)


   
## Release v1.4.1

## Enhancements

- Add maintenance variables and the oidc_issuer_url output (#21)


   
## Release v1.4.0

## Provider & Terraform Upgrade
- Azurerm provider: 3.84.0 (#16)
- Terraform: 1.6.5 (#16)
   
## Release v1.3.0

## Provider & Terraform Upgrade
- Azurerm provider: 3.73.0 (#10)
- Terraform: 1.5.7 (#10)

   
## Release v1.2.1

### Added
- Parameters `enable_host_encryption`, `only_critical_addons_enabled` and `temporary_name_for_rotation`
   
## Release v1.2.0

### Version upgrade
- Azurerm provider: 3.67.0
- Terraform: 1.5.4
   
## Release v1.1.3

### Updated
- `kubernetes_cluster_id` variable requirement is optional as it is inherited from parent resource
   
## Release v1.1.2

### Added

- Outputs needed for further deployments
   
## Release v1.1.1

### Updated
- Output of identity parameter `principal_id` 
   
## Release v1.1.0

### Updated

- Diagnostic Settings separated into its own .tf file
- Readme - deleted change log, fixed typo
- updated default value of `default_node_pool.name`

### Version upgrade

- azurerm provider: 3.51.0
- terraform: 1.4.5


   
## Release v1.0.0

### Added 

- Initial code
   