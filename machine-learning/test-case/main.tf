terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.33.0"
    }
  }
  backend "local" {}
}

provider "azurerm" {
  resource_provider_registrations = "core"
  features {}
}

# module deployment prerequisites
data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "rg" {
  name     = "SEY-MLWORKSPACE-NE-RG01"
  location = local.location
}

resource "azurerm_application_insights" "ai" {
  name                = "SEY-MLWORKSPACE-NE-AI01"
  location            = local.location
  resource_group_name = azurerm_resource_group.rg.name
  application_type    = "web"
}

resource "azurerm_storage_account" "sa" {
  name                     = "seymlworkspacenesa01"
  location                 = local.location
  resource_group_name      = azurerm_resource_group.rg.name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_key_vault" "kv" {
  name                     = "sey-mlworkspace-ne-kv01"
  location                 = local.location
  resource_group_name      = azurerm_resource_group.rg.name
  tenant_id                = data.azurerm_client_config.current.tenant_id
  sku_name                 = "standard"
  purge_protection_enabled = true
}

resource "azurerm_key_vault_access_policy" "kvap" {
  key_vault_id = azurerm_key_vault.kv.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  key_permissions = [
    "Create",
    "List",
    "Get",
    "Delete",
    "Purge",
    "GetRotationPolicy",
  ]
}

resource "azurerm_key_vault_key" "kvk" {
  name         = "workspaceexamplekeyvaultkey"
  key_vault_id = azurerm_key_vault.kv.id
  key_type     = "RSA"
  key_size     = 2048

  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey",
  ]

  depends_on = [azurerm_key_vault_access_policy.kvap]
}

# private endpoint prerequisites
resource "azurerm_virtual_network" "vnet" {
  name                = "SEY-MLWORKSPACE-NE-VNET01"
  location            = local.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet" {
  name                 = "sey-mlworkspace-ne-subnet01"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_private_dns_zone" "dns" {
  name                = "sey.mlworkspace.private.dns"
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "dns_link" {
  name                  = "SEY-MLWORKSPACE-NE-VNET01"
  resource_group_name   = azurerm_resource_group.rg.name
  private_dns_zone_name = azurerm_private_dns_zone.dns.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
}

# monitoring prerequisites
resource "azurerm_log_analytics_workspace" "la" {
  name                = "SEY-MLWORKSPACE-NE-LA01"
  resource_group_name = azurerm_resource_group.rg.name
  location            = local.location
}

resource "azurerm_eventhub_namespace" "eventhub_namespace" {
  name                = "SEY-MLWORKSPACE-NE-EVHNS0"
  location            = local.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Basic"
  capacity            = 2
}

resource "azurerm_eventhub" "eh" {
  name              = "sey-mlworkspace-ne-evh01"
  namespace_id      = azurerm_eventhub_namespace.eventhub_namespace.id
  partition_count   = 2
  message_retention = 1
}

# machine learning workspace
module "machine_learning_workspace" {
  source = "git@github.com:Seyfor-CSC/mit.machine-learning.git?ref=v2.4.0"
  config = local.mlw
}

output "mlw" {
  value = module.machine_learning_workspace.outputs
}
