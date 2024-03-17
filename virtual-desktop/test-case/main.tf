terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.84.0"
    }
  }
  backend "local" {}
}

provider "azurerm" {
  skip_provider_registration = false
  features {}
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

  depends_on = [
    azurerm_resource_group.rg
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
  principal_id                     = data.azuread_service_principal.example.id
  skip_service_principal_aad_check = true

  depends_on = [
    azurerm_role_definition.example,
    data.azuread_service_principal.example,
    random_uuid.example
  ]
}

# private endpoint prerequisities
resource "azurerm_virtual_network" "vnet" {
  name                = "example-network"
  location            = local.location
  resource_group_name = local.naming.rg
  address_space       = ["10.0.0.0/16"]

  depends_on = [
    azurerm_resource_group.rg
  ]
}

resource "azurerm_subnet" "subnet" {
  name                 = "example-subnet"
  resource_group_name  = local.naming.rg
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
  depends_on = [
    azurerm_virtual_network.vnet
  ]
}

resource "azurerm_private_dns_zone" "dns" {
  name                = "test.private.dns"
  resource_group_name = local.naming.rg

  depends_on = [
    azurerm_resource_group.rg
  ]
}

resource "azurerm_private_dns_zone_virtual_network_link" "dns_link" {
  name                  = "test"
  resource_group_name   = local.naming.rg
  private_dns_zone_name = azurerm_private_dns_zone.dns.name
  virtual_network_id    = azurerm_virtual_network.vnet.id

  depends_on = [
    azurerm_private_dns_zone.dns,
    azurerm_virtual_network.vnet
  ]
}

# monitoring prerequisities
resource "azurerm_log_analytics_workspace" "la" {
  name                = "SEY-TERRAFORM-NE-LA01"
  location            = local.location
  resource_group_name = local.naming.rg
  sku                 = "PerGB2018"
  retention_in_days   = 30

  depends_on = [
    azurerm_resource_group.rg
  ]
}

# virtual desktop
module "virtual_desktop" {
  source = "git@github.com:Seyfor-CSC/mit.virtual-desktop.git?ref=v1.1.1"
  config = local.virtual_desktop

  depends_on = [
    azurerm_role_assignment.example,
    azurerm_private_dns_zone_virtual_network_link.dns_link,
    azurerm_log_analytics_workspace.la
  ]
}

output "virtual_desktop" {
  value = module.virtual_desktop.outputs
}
