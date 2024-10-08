terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.1.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "=3.0.1"
    }
  }
  backend "local" {}
}

provider "azurerm" {
  resource_provider_registrations = "core"
  features {}
}
provider "azuread" {
}

# module deployment prerequisities
resource "azurerm_resource_group" "rg" {
  name     = local.naming.rg
  location = local.location
}

resource "azurerm_role_definition" "example" {
  name        = "AVD-CustomRole"
  scope       = azurerm_resource_group.rg.id
  description = "AVD AutoScale Role"
  permissions {
    actions = [
      "Microsoft.Insights/eventtypes/values/read",
      "Microsoft.Compute/virtualMachines/deallocate/action",
      "Microsoft.Compute/virtualMachines/restart/action",
      "Microsoft.Compute/virtualMachines/powerOff/action",
      "Microsoft.Compute/virtualMachines/start/action",
      "Microsoft.Compute/virtualMachines/read",
      "Microsoft.DesktopVirtualization/hostpools/read",
      "Microsoft.DesktopVirtualization/hostpools/write",
      "Microsoft.DesktopVirtualization/hostpools/sessionhosts/read",
      "Microsoft.DesktopVirtualization/hostpools/sessionhosts/write",
      "Microsoft.DesktopVirtualization/hostpools/sessionhosts/usersessions/delete",
      "Microsoft.DesktopVirtualization/hostpools/sessionhosts/usersessions/read",
      "Microsoft.DesktopVirtualization/hostpools/sessionhosts/usersessions/sendMessage/action",
      "Microsoft.DesktopVirtualization/hostpools/sessionhosts/usersessions/read"
    ]
  }
  assignable_scopes = [
    azurerm_resource_group.rg.id,
  ]
}

data "azuread_service_principal" "example" {
  display_name = "Windows Virtual Desktop"
}

resource "random_uuid" "example" {
}

resource "azurerm_role_assignment" "example" {
  name                             = random_uuid.example.result
  scope                            = azurerm_resource_group.rg.id
  role_definition_id               = azurerm_role_definition.example.role_definition_resource_id
  principal_id                     = data.azuread_service_principal.example.object_id
  skip_service_principal_aad_check = true
}

# private endpoint prerequisities
resource "azurerm_virtual_network" "vnet" {
  name                = "SEY-AVD-NE-VNET01"
  location            = local.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet" {
  name                 = "sey-avd-ne-subnet01"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_private_dns_zone" "dns" {
  name                = "sey.avd.private.dns"
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "dns_link" {
  name                  = "SEY-AVD-NE-VNET01"
  resource_group_name   = azurerm_resource_group.rg.name
  private_dns_zone_name = azurerm_private_dns_zone.dns.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
}

# monitoring prerequisities
resource "azurerm_log_analytics_workspace" "la" {
  name                = "SEY-AVD-NE-LA01"
  location            = local.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

# virtual desktop
module "virtual_desktop" {
  source = "git@github.com:Seyfor-CSC/mit.virtual-desktop.git?ref=v2.0.0"
  config = local.virtual_desktop
}

output "virtual_desktop" {
  value = module.virtual_desktop.outputs
}
