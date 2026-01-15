# Changelog

## Release v2.5.1

## Enhancements

- Add `size` and `zone` to outputs (#74)


   
## Release v2.5.0

## Provider & Terraform Upgrade
- Azurerm provider: 4.56.0 (#72)
- Terraform: 1.14.2 (#72)
- OpenTofu: 1.11.1 (#72)
   
## Release v2.4.1

## Bug Fixes

- Remove `zone` inheritance in `managed_disks` (#70)



   
## Release v2.4.0

## Provider & Terraform Upgrade
- Azurerm provider: 4.45.0 (#69)
- Terraform: 1.13.3 (#69)
   
## Release v2.3.1

## Enhancements

- Allow optional inheritance of `source_vm_id` in the `azurerm_backup_protected_vm` resource (#66)


   
## Release v2.3.0

## Provider & Terraform Upgrade
- Azurerm provider: 4.33.0 (#64)
- Terraform: 1.12.2 (#64)
   
## Release v2.2.1

## Enhancements

- Add tags `Platform` and `MonitoringTier` to `ignore_changes` (#62)


   
## Release v2.2.0

## Provider & Terraform Upgrade
- Azurerm provider: 4.23.0 (#60)
- Terraform: 1.11.2 (#60)
   
## Release v2.1.0

## Provider & Terraform Upgrade
- Azurerm provider: 4.14.0 (#45)
- Terraform: 1.10.3 (#45)
   
## Release v2.0.0

## Provider & Terraform Upgrade
- Azurerm provider: 4.1.0 (#36)
- Terraform: 1.9.5 (#36)
## Enhancements
- Implement Minimal Provider Version (#36)
- Remove toset() functions (#36)
   
## Release v1.5.0

## Provider & Terraform Upgrade
- Azurerm provider: 3.108.0 (#30)
- Terraform: 1.8.5 (#30)
   
## Release v1.4.1

## Bug Fixes

- Fix typo in the `admin_ssh_key` dynamic block (#28)



   
## Release v1.4.0

## Provider & Terraform Upgrade

- Azurerm provider: 3.96.0 (#26)
- Terraform: 1.7.5 (#26)

## Enhancements

- Replace explicit dependencies with implicit (#26)
   
## Release v1.3.1

## Enhancements

- Allow attachment of network interface IDs to a virtual machine (#24)


   
## Release v1.3.0

## Bug Fixes

- Replace data blocks used for disk backup with a `subscription_id` variable (#20)



   
## Release v1.2.0

## Provider & Terraform Upgrade
- Azurerm provider: 3.84.0 (#18)
- Terraform: 1.6.5 (#18)
   
## Release v1.1.3

## Bug Fixes

- Fix `azurerm_virtual_machine_extension` resource looping key to support extensions with identical names in different virtual machines (#16)



   
## Release v1.1.2

## Enhancements

- Set `enable_accelerated_networking` variable default value to true (#14)


   
## Release v1.1.1

## Bug Fixes

- Remove Data Disk `os_type` value inheritance from Virtual Machine (#12)



   
## Release v1.1.0

## Provider & Terraform Upgrade
- Azurerm provider: 3.73.0 (#7)
- Terraform: 1.5.7 (#7)
   
## Release v1.0.0

### Added
- Initial code

   