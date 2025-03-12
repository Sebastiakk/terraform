resource "random_password" "administrator_password" {
  length      = 16
  special     = true
  upper       = true
  lower       = true
  numeric     = true
  min_special = 2
  min_upper   = 2
  min_lower   = 2
  min_numeric = 2
}

locals {
  admin_password = random_password.administrator_password.result
  server_name    = "${var.server_name}-${var.environment}-dbsql"
}


resource "azurerm_mysql_flexible_server" "mysql" {
  name                   = local.server_name
  resource_group_name    = var.resource_group_name
  location               = var.location
  administrator_login    = var.admin_username
  administrator_password = local.admin_password
  sku_name               = var.sku_name
  version                = var.mysql_version
  zone                   = var.zone


  tags = {
    environment = var.environment
    app_name    = var.app_name
  }

  storage {
    size_gb = var.storage_size
  }
}
