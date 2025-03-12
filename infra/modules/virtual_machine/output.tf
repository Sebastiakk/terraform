output "admin_username" {
  value       = local.admin_username
  description = "Nombre de usuario administrador de la máquina virtual"
}

output "admin_password" {
  value       = local.admin_password
  description = "Contraseña del usuario administrador de la máquina virtual"
  sensitive   = true
}
