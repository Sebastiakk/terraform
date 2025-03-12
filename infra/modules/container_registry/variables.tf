variable "location" {
  type        = string
  description = "Ubicación del recurso en Azure"
}

variable "environment" {
  description = "Entorno de los recursos (dev, lab, pdn)"
  type        = string
}

variable "app_name" {
  description = "Nombre de la aplicación"
  type        = string
}

variable "resource_group_name" {
  description = "El nombre del grupo de recursos en Azure donde se creará el ACR."
  type        = string
}

variable "acr_name" {
  description = "El nombre del Azure Container Registry."
  type        = string
}

variable "sku" {
  description = "El SKU del Azure Container Registry."
  type        = string
  default     = "Basic"
  validation {
    condition = contains(["Basic", "Standard", "Premium"], var.sku)
    error_message = "El SKU debe ser uno de los siguientes valores: Basic, Standard, Premium."
  }
}
