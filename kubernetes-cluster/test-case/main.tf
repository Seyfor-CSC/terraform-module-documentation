terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.73.0"
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

# kubernetes cluster
module "kubernetes_cluster" {
  source = "git@github.com:Seyfor-CSC/mit.kubernetes-cluster.git?ref=v1.3.0"
  config = local.aks

  depends_on = [
    azurerm_log_analytics_workspace.la
  ]
}

output "kubernetes_cluster" {
  value = module.kubernetes_cluster.outputs
}
