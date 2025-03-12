output "mysql_server_fqdn" {
  description = "FQDN del servidor MySQL"
  value       = azurerm_mysql_flexible_server.mysql.fqdn
}

output "mysql_admin_username" {
  description = "Usuario administrador de MySQL"
  value       = azurerm_mysql_flexible_server.mysql.administrator_login
}

output "mysql_admin_password" {
  description = "Contraseña del usuario administrador"
  value       = azurerm_mysql_flexible_server.mysql.administrator_password
  sensitive   = true
}
output "mysql_server_name" {
  description = "Nombre del servidor MySQL"
  value       = azurerm_mysql_flexible_server.mysql.name
}
