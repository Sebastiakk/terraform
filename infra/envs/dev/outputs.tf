output "mysql_server_fqdn" {
  description = "FQDN del servidor MySQL"
  value       = module.storage.mysql_server_fqdn
}

output "mysql_admin_username" {
  description = "Usuario administrador de MySQL"
  value       = module.storage.mysql_admin_username
  sensitive   = true
}

output "mysql_admin_password" {
  description = "Contraseña del usuario administrador"
  value       = module.storage.mysql_admin_password
  sensitive   = true
}

output "acr_id" {
  description = "ID del Azure Container Registry"
  value       = module.storage.acr_id
}

output "jumpbox_admin_username" {
  value       = module.compute.jumpbox_admin_username
  description = "Nombre de usuario administrador de la máquina virtual"
}

output "jumpbox_admin_password" {
  value       = module.compute.jumpbox_admin_password
  description = "Contraseña del usuario administrador de la máquina virtual"
  sensitive   = true
}

output "aks_kubelet_identity_client_id" {
  description = "El client ID del kubelet identity del clúster de AKS"
  value       = module.compute.aks_kubelet_identity_client_id
}


output "aks_private_link_private_ip" {
  description = "Dirección IP privada del servicio Private Link de AKS"
  value       = module.compute.aks_private_link_private_ip
}

output "aks_host" {
  value       = module.compute.aks_host
  description = "Host público del clúster AKS"
}
