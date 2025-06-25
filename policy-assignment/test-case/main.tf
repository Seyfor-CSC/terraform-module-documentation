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
data "azurerm_subscription" "primary" {}

# policy assignment
module "policy_assignment" {
  source = "git@github.com:Seyfor-CSC/mit.policy-assignment.git?ref=v2.3.0"
  config = local.policy
}
output "policy_assignment" {
  value = module.policy_assignment.outputs
}
