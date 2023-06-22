terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.51.0"
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
  source = "git@github.com:Seyfor-CSC/mit.policy-assignment.git?ref=v1.1.1"
  config = local.policy
}

output "policy_assignment_mg" {
  value = module.policy_assignment.outputs_mg
}

output "policy_assignment_sub" {
  value = module.policy_assignment.outputs_sub
}
