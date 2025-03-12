variable "resource_group_name" {
  description = "El nombre del grupo de recursos donde se creará el perfil de Azure Front Door."
  type        = string
}

variable "name" {
  description = "El nombre del perfil de CDN Front Door."
  type        = string
  validation {
    condition     = length(var.name) <= 24
    error_message = "El nombre del perfil de CDN Front Door debe tener 24 caracteres o menos."
  }
}

variable "sku_name" {
  description = "El SKU del perfil de CDN Front Door. Valores permitidos: 'Standard_AzureFrontDoor', 'Premium_AzureFrontDoor'."
  type        = string
  default     = "Standard_AzureFrontDoor"
  validation {
    condition = contains(["Standard_AzureFrontDoor", "Premium_AzureFrontDoor"], var.sku_name)
    error_message = "El SKU del perfil de CDN Front Door debe ser 'Standard_AzureFrontDoor' o 'Premium_AzureFrontDoor'."
  }
}

variable "environment" {
  description = "Entorno de los recursos"
  type        = string
}
