terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.67.0"
    }
  }
  backend "local" {}
}

provider "azurerm" {
  skip_provider_registration = false
  features {}
}

# module deployment prerequisities

# policy set definition
module "policy_set_definition" {
  source = "git@github.com:Seyfor-CSC/mit.policy-set-definition.git?ref=v1.2.0"
  config = local.policy
}

output "policy_set_definition" {
  value = module.policy_set_definition.outputs
}
