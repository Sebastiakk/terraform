output "aks_cluster_name" {
  description = "Nombre del clúster de AKS"
  value       = azurerm_kubernetes_cluster.aks.name
}

output "aks_cluster_id" {
  description = "ID del clúster de AKS"
  value       = azurerm_kubernetes_cluster.aks.id
}

output "kube_config" {
  description = "Archivo de configuración de kubectl para el clúster de AKS"
  value       = azurerm_kubernetes_cluster.aks.kube_config_raw
}

output "aks_kubelet_identity_client_id" {
  description = "El client ID del kubelet identity del clúster de AKS"
  value       = azurerm_kubernetes_cluster.aks.fqdn
}

output "aks_host" {
  value       = azurerm_kubernetes_cluster.aks.fqdn
  description = "Host público del clúster AKS"
}
