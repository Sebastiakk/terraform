locals {
  resource_group_name = "security"
  kv_name             = "kiu-challenge"
}

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


module "security_resource_group" {
  source = "../../../../modules/resorce_group"

  name        = local.resource_group_name
  app_name    = var.app_name
  environment = var.environment
  location    = var.location
}

module "key_vault" {
  source = "../../../../modules/key_vault/key_vault"

  resource_group_name = module.security_resource_group.name
  app_name            = var.app_name
  environment         = var.environment
  location            = var.location
  key_vault_name      = local.kv_name

  depends_on = [
    module.security_resource_group
  ]
}


module "key_vault_secret_mysql_credentials" {
  source = "../../../../modules/key_vault/key_vault_secret"

  key_vault_id = module.key_vault.key_vault_id
  secret_name  = "mysql-credentials-administrator"
  project_name = var.app_name
  environment  = var.environment
  content_type = "application/json"
  value = jsonencode({
    USERNAME = data.terraform_remote_state.remote_state.outputs.mysql_admin_username
    PASSWORD = data.terraform_remote_state.remote_state.outputs.mysql_admin_password
    FQDN     = data.terraform_remote_state.remote_state.outputs.mysql_server_fqdn
  })

  depends_on = [
    module.key_vault
  ]
}

module "key_vault_secret_jumpbox_credentials" {
  source = "../../../../modules/key_vault/key_vault_secret"

  key_vault_id = module.key_vault.key_vault_id
  secret_name  = "jumpbox-credentials-administrator"
  project_name = var.app_name
  environment  = var.environment
  content_type = "application/json"
  value = jsonencode({
    USERNAME = data.terraform_remote_state.remote_state.outputs.jumpbox_admin_username
    PASSWORD = data.terraform_remote_state.remote_state.outputs.jumpbox_admin_password
  })

  depends_on = [
    module.key_vault
  ]
}

