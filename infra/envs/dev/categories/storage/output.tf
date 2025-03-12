output "mysql_server_fqdn" {
  description = "FQDN del servidor MySQL"
  value       = module.database_server.mysql_server_fqdn
}

output "mysql_admin_username" {
  description = "Usuario administrador de MySQL"
  value       = module.database_server.mysql_admin_username
  sensitive   = true
}

output "mysql_admin_password" {
  description = "Contraseña del usuario administrador"
  value       = module.database_server.mysql_admin_password
  sensitive   = true
}


output "acr_id" {
  description = "ID del Azure Container Registry"
  value       = module.container_registry.acr_id
}
