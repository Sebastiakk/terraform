output "postgresql_server_name" {
  description = "El nombre del servidor de PostgreSQL."
  value       = azurerm_postgresql_flexible_server.postgresql.name
}

output "postgresql_fully_qualified_domain_name" {
  description = "El nombre de dominio completo del servidor de PostgreSQL."
  value       = azurerm_postgresql_flexible_server.postgresql.fqdn
}

output "postgresql_database_name" {
  description = "El nombre de la base de datos de PostgreSQL."
  value       = azurerm_postgresql_flexible_server_database.postgresql.name
}

output "postgresql_administrator_login" {
  description = "El nombre de usuario del administrador del servidor de PostgreSQL."
  value       = local.administrator_login
}

output "postgresql_administrator_password" {
  description = "La contraseña del administrador del servidor de PostgreSQL."
  value       = random_password.administrator_login_password.result
  sensitive   = true
}

output "postgresql_version" {
  description = "La versión del servidor de PostgreSQL."
  value       = azurerm_postgresql_flexible_server.postgresql.version
}
