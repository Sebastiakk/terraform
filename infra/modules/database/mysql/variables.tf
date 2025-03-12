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
  description = "El nombre del grupo de recursos."
  type        = string
  validation {
    condition     = length(var.resource_group_name) >= 1
    error_message = "El nombre del grupo de recursos no puede estar vacío."
  }
}

variable "server_name" {
  description = "Nombre del servidor MySQL"
  type        = string
  validation {
    condition = can(regex("^[a-z0-9-]{3,53}$", var.server_name))
    error_message = "El nombre del servidor debe tener entre 3 y 53 caracteres, solo letras minúsculas, números y guiones."
  }
}

variable "admin_username" {
  description = "Usuario administrador de la base de datos"
  type        = string
  default     = "admin_user"
  validation {
    condition     = length(var.admin_username) >= 5 && length(var.admin_username) <= 16
    error_message = "El usuario administrador debe tener entre 5 y 16 caracteres."
  }
}

variable "sku_name" {
  description = "SKU del servidor MySQL (Ejemplo: B_Standard_B1ms)"
  type        = string
  validation {
    condition = can(regex("^(B_|GP_|MO_)", var.sku_name))
    error_message = "El SKU debe comenzar con 'B_', 'GP_' o 'MO_' según los niveles de MySQL en Azure."
  }
}

variable "mysql_version" {
  description = "Versión de MySQL (Ejemplo: 5.7, 8.0)"
  type        = string
}

variable "storage_size" {
  description = "Tamaño del almacenamiento en GB"
  type        = number
  validation {
    condition     = var.storage_size >= 20 && var.storage_size <= 1024
    error_message = "El tamaño del almacenamiento debe estar entre 20GB y 1024GB."
  }
}

variable "zone" {
  description = "Zona de disponibilidad"
  type        = string
  default     = "1"
  validation {
    condition = can(regex("^[1-3]$", var.zone))
    error_message = "La zona de disponibilidad debe ser un número entre 1 y 3."
  }
}

