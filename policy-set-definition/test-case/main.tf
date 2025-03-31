terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.23.0"
    }
  }
  backend "local" {}
}

provider "azurerm" {
  resource_provider_registrations = "core"
  features {}
}

# policy set definition
module "policy_set_definition" {
  source = "git@github.com:Seyfor-CSC/mit.policy-set-definition.git?ref=v2.2.0"
  config = local.policy
}

output "policy_set_definition" {
  value = module.policy_set_definition.outputs
}
