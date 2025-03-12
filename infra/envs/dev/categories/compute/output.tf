output "jumpbox_admin_username" {
  value       = module.jumpbox.admin_username
  description = "Nombre de usuario administrador de la máquina virtual"
}

output "jumpbox_admin_password" {
  value       = module.jumpbox.admin_password
  description = "Contraseña del usuario administrador de la máquina virtual"
  sensitive   = true
}


output "aks_kubelet_identity_client_id" {
  description = "El client ID del kubelet identity del clúster de AKS"
  value       = module.aks.aks_kubelet_identity_client_id
}

output "aks_private_link_private_ip" {
  description = "Dirección IP privada del servicio Private Link de AKS"
  value       = azurerm_private_link_service.aks_private_link.nat_ip_configuration[0].private_ip_address
}

output "aks_host" {
  value       = module.aks.aks_host
  description = "Host público del clúster AKS"
}
