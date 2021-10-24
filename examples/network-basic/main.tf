terraform {
  required_version = ">= 0.15"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.74.0"
    }
  }
}

provider "azurerm" {
  features {}
}

module "network" {
  source                 = "cybergavin/network-basic/azurerm"
  version                = "1.0.0"
  region-name            = var.region-name
  network-resource-group = var.network-resource-group
  networks               = var.networks
  global-tags            = var.global-tags
}
