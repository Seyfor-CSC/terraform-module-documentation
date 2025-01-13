terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.14.0"
    }
  }
  backend "local" {}
}

provider "azurerm" {
  resource_provider_registrations = "core"
  features {}
}

# policy definition
module "policy_definition" {
  source = "git@github.com:Seyfor-CSC/mit.policy-definition.git?ref=v2.1.0"
  config = local.policy_definition
}

output "policy_definition" {
  value = module.policy_definition.outputs
}
