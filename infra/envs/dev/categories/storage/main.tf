locals {
  resource_group_name = "storage"
  db_name             = "kiu-challenge"
  registry_name       = "kiuchallenge"
}


module "storage_resource_group" {
  source = "../../../../modules/resorce_group"

  name        = local.resource_group_name
  app_name    = var.app_name
  environment = var.environment
  location    = var.location

}


module "database_server" {
  source = "../../../../modules/database/mysql"

  environment         = var.environment
  app_name            = var.app_name
  location            = module.storage_resource_group.location
  resource_group_name = module.storage_resource_group.name
  server_name         = local.db_name
  sku_name            = "GP_Standard_D2ds_v4"
  storage_size        = 32
  mysql_version       = "8.0.21"
  zone                = "3"

  depends_on = [
    module.storage_resource_group
  ]
}

module "container_registry" {
  source = "../../../../modules/container_registry"

  acr_name            = local.registry_name
  environment         = var.environment
  app_name            = var.app_name
  location            = module.storage_resource_group.location
  resource_group_name = module.storage_resource_group.name

  depends_on = [
    module.storage_resource_group
  ]
}



