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
resource "azurerm_resource_group" "rg" {
  name     = local.naming.rg
  location = local.location
}

# monitoring prerequisites
resource "azurerm_log_analytics_workspace" "la" {
  name                = "SEY-AKS-NE-LA01"
  location            = local.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

# kubernetes cluster
module "kubernetes_cluster" {
  source = "git@github.com:Seyfor-CSC/mit.kubernetes-cluster.git?ref=v2.4.1"
  config = local.aks
}

output "kubernetes_cluster" {
  value = module.kubernetes_cluster.outputs
}
