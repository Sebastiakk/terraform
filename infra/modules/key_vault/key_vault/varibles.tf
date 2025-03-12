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

variable "key_vault_name" {
  description = "El nombre del Key Vault."
  type        = string
}


variable "resource_group_name" {
  description = "El nombre del grupo de recursos."
  type        = string
}


variable "sku_name" {
  description = "El SKU del Key Vault. Valores permitidos: 'standard' o 'premium'."
  type        = string
  default     = "standard"
  validation {
    condition = contains(["standard", "premium"], var.sku_name)
    error_message = "El SKU del Key Vault debe ser 'standard' o 'premium'."
  }
}

