variable "location" {
  description = "Ubicación del clúster de AKS"
  type        = string
}

variable "resource_group_name" {
  description = "Nombre del grupo de recursos donde se creará el clúster de AKS"
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

variable "subnet_id" {
  description = "IDs de las subredes de la VNet donde se desplegará el clúster de AKS"
  type        = string
}


variable "vm_name" {
  description = "Nombre de la máquina virtual"
  type        = string
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
