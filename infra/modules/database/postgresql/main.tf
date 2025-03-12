resource "random_string" "administrator_login_prefix" {
  length  = 1
  upper   = false
  lower   = true
  special = false
}

resource "random_string" "administrator_login_suffix" {
  length      = 7
  special     = false
  upper       = false
  min_numeric = 1
  lower       = true
}

locals {
  administrator_login = "${random_string.administrator_login_prefix.result}${random_string.administrator_login_suffix.result}"
  server_name         = "${var.server_name}-${var.environment}-dbsql"
}

resource "random_password" "administrator_login_password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

resource "azurerm_postgresql_flexible_server" "postgresql" {
  name                         = local.server_name
  location                     = var.location
  resource_group_name          = var.resource_group_name
  sku_name                     = var.sku_name
  backup_retention_days        = var.backup_retention_days
  storage_mb                   = var.storage_mb
  administrator_login          = local.administrator_login
  administrator_password       = random_password.administrator_login_password.result
  storage_tier                 = var.storage_tier
  version                      = var.postgres_version
  geo_redundant_backup_enabled = var.geo_redundant_backup_enabled
  auto_grow_enabled            = var.auto_grow_enabled
  zone                         = var.zone


  tags = {
    environment = var.environment
    app_name    = var.app_name
  }
}

resource "azurerm_postgresql_flexible_server_database" "postgresql" {
  name      = var.database_name
  charset   = var.charset
  collation = var.collation
  server_id = azurerm_postgresql_flexible_server.postgresql.id
  lifecycle {
    prevent_destroy = true
  }
}
