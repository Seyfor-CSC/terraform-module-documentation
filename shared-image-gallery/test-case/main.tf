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
resource "azurerm_resource_group" "rg" {
  name     = local.naming.rg
  location = local.location
}

# shared image gallery
module "shared_image_gallery" {
  source = "git@github.com:Seyfor-CSC/mit.shared-image-gallery.git?ref=v1.0.0"
  config = local.acg

  depends_on = [
    azurerm_resource_group.rg
  ]
}

output "shared_image_gallery" {
  value = module.shared_image_gallery.outputs
}
