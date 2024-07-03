terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.108.0"
    }
  }
  backend "local" {}
}

provider "azurerm" {
  skip_provider_registration = false
  features {}
}

# policy definition
module "policy_definition" {
  source = "git@github.com:Seyfor-CSC/mit.policy-definition.git?ref=v1.2.0"
  config = local.policy_definition
}

output "policy_definition" {
  value = module.policy_definition.outputs
}
