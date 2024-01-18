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
data "azurerm_subscription" "primary" {}

# policy assignment
module "policy_assignment" {
  source = "git@github.com:Seyfor-CSC/mit.policy-assignment.git?ref=v1.4.1"
  config = local.policy
}
output "policy_assignment" {
  value = module.policy_assignment.outputs
}
