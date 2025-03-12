provider "azurerm" {
  features {}
  subscription_id = var.subscription_id

}

terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate-rg"
    storage_account_name = "kiustate"
    container_name       = "tfstate"
    key                  = "dev.terraform.tfstate"
  }
}


locals {
  environment = "dev"
  location    = "East US 2"
  app_name    = "kiu-challenge"
}


module "storage" {
  source = "./categories/storage"

  environment = local.environment
  location    = local.location
  app_name    = local.app_name
}


module "compute" {
  source = "./categories/compute"

  environment     = local.environment
  location        = local.location
  app_name        = local.app_name
  subscription_id = var.subscription_id
  tf_state_config = var.tf_state_config

}


module "content_delivery" {
  source = "./categories/content_delivery"

  environment     = local.environment
  location        = local.location
  app_name        = local.app_name
  subscription_id = var.subscription_id
  tf_state_config = var.tf_state_config

  depends_on = [
    module.compute
  ]
}

module "security" {
  source = "./categories/security"

  environment     = local.environment
  location        = local.location
  app_name        = local.app_name
  subscription_id = var.subscription_id
  tf_state_config = var.tf_state_config

  depends_on = [
    module.storage,
    module.compute
  ]
}
