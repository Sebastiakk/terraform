variable "name" {
  description = "Nombre del clúster de AKS"
  type        = string
}

variable "location" {
  description = "Ubicación del clúster de AKS"
  type        = string
}

variable "resource_group_name" {
  description = "Nombre del grupo de recursos donde se creará el clúster de AKS"
  type        = string
}


variable "node_count" {
  description = "Número de nodos en el pool predeterminado"
  type        = number
  default     = 1
  validation {
    condition     = var.node_count > 0
    error_message = "El número de nodos debe ser mayor que 0."
  }
}

variable "vm_size" {
  description = "Tamaño de la máquina virtual para los nodos del clúster"
  type        = string
  default     = "Standard_DS2_v2"
  validation {
    condition = contains([
      "Standard_B2s", "Standard_B2ms", "Standard_D2s_v3", "Standard_D4s_v3", "Standard_D8s_v3", "Standard_DS1_v2",
      "Standard_DS2_v2", "Standard_DS3_v2", "Standard_DS4_v2"
    ], var.vm_size)
    error_message = "El tamaño de la máquina virtual debe ser uno de los siguientes: Standard_B2s, Standard_B2ms, Standard_D2s_v3, Standard_D4s_v3, Standard_D8s_v3, Standard_DS1_v2, Standard_DS2_v2, Standard_DS3_v2, Standard_DS4_v2."
  }
}


variable "vnet_subnet_id" {
  description = "ID de la subred de la VNet donde se desplegará el clúster de AKS"
  type        = string
}

variable "network_plugin" {
  description = "Plugin de red para el clúster de AKS"
  type        = string
  default     = "azure"
}
variable "service_cidr" {
  description = "CIDR del servicio del clúster de AKS"
  type        = string
}

variable "dns_service_ip" {
  description = "Dirección IP del servicio DNS del clúster de AKS"
  type        = string
}


variable "environment" {
  description = "Entorno de los recursos"
  type        = string
}

variable "app_name" {
  description = "Nombre de la aplicación"
  type        = string
}
