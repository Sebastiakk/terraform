data "terraform_remote_state" "remote_state" {
  backend = "azurerm"

  config = {
    subscription_id      = var.subscription_id
    resource_group_name  = var.tf_state_config.resource_group_name
    storage_account_name = var.tf_state_config.storage_account_name
    container_name       = var.tf_state_config.container_name
    key                  = var.tf_state_config.key
  }
}

locals {
  resource_group_name    = "content-delivery"
  frontdoor_project_name = "kiuchallenge"

}

module "content_delivery_resource_group" {
  source      = "../../../../modules/resorce_group"
  name        = local.resource_group_name
  location    = var.location
  environment = var.environment
  app_name    = var.app_name
}

module "frontdoor" {
  source              = "../../../../modules/frontdoor/frontdoor"
  name                = local.frontdoor_project_name
  resource_group_name = module.content_delivery_resource_group.name
  sku_name            = "Premium_AzureFrontDoor"
  environment         = var.environment
}

module "frontdoor_origin" {
  source                   = "../../../../modules/frontdoor/frontdoor-origin"
  name                     = local.frontdoor_project_name
  environment              = var.environment
  cdn_frontdoor_profile_id = module.frontdoor.profile_id
  host_name                = data.terraform_remote_state.remote_state.outputs.aks_private_link_private_ip
  origin_host_header       = data.terraform_remote_state.remote_state.outputs.aks_private_link_private_ip
}

module "frontdoor_route" {
  source                        = "../../../../modules/frontdoor/frontdoor-route"
  name                          = local.frontdoor_project_name
  environment                   = var.environment
  cdn_frontdoor_profile_id      = module.frontdoor.profile_id
  cdn_frontdoor_origin_group_id = module.frontdoor_origin.origin_group_id
  cdn_frontdoor_origin_ids = [module.frontdoor_origin.origin_id]
}
