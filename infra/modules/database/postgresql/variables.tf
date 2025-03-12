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

variable "server_name" {
  description = "El nombre del servidor de PostgreSQL. Debe tener entre 3 y 63 caracteres y contener solo letras minúsculas, números y guiones."
  type        = string
  validation {
    condition     = length(var.server_name) >= 3 && length(var.server_name) <= 63 && can(regex("^[-a-z0-9]+$", var.server_name))
    error_message = "El nombre del servidor debe tener entre 3 y 63 caracteres y contener solo letras minúsculas, números y guiones."
  }
}


variable "resource_group_name" {
  description = "El nombre del grupo de recursos."
  type        = string
  validation {
    condition     = length(var.resource_group_name) >= 1
    error_message = "El nombre del grupo de recursos no puede estar vacío."
  }
}

variable "sku_name" {
  description = "El SKU del servidor flexible de PostgreSQL, por ejemplo, 'GP_Standard_D2s_v3'."
  type        = string
  validation {
    condition = can(regex("^(B|GP|MO)_(Standard|Memory)_\\w+$", var.sku_name))
    error_message = "El SKU debe ser 'B', 'GP' o 'MO' seguido de 'Standard' o 'Memory' y una descripción válida, por ejemplo, 'GP_Standard_D2s_v3'."
  }
}

variable "storage_mb" {
  description = "El tamaño de almacenamiento del servidor de PostgreSQL en megabytes. Debe ser un múltiplo de 32 entre 32 y 65536."
  type        = number
  validation {
    condition     = var.storage_mb >= 32 && var.storage_mb <= 65536 && var.storage_mb % 32 == 0
    error_message = "El tamaño de almacenamiento debe estar entre 32 MB y 65536 MB y ser un múltiplo de 32."
  }
}

variable "storage_tier" {
  description = "El nombre del nivel de rendimiento de almacenamiento para IOPS del servidor flexible de PostgreSQL. Los valores posibles son 'P4', 'P6', 'P10', 'P15', 'P20', 'P30', 'P40', 'P50', 'P60', 'P70', 'P80'."
  type        = string
  default     = "P10"
  validation {
    condition = contains(["P4", "P6", "P10", "P15", "P20", "P30", "P40", "P50", "P60", "P70", "P80"], var.storage_tier)
    error_message = "El nivel de rendimiento de almacenamiento debe ser uno de los siguientes: 'P4', 'P6', 'P10', 'P15', 'P20', 'P30', 'P40', 'P50', 'P60', 'P70', 'P80'."
  }
}

variable "backup_retention_days" {
  description = "El número de días para retener los backups del servidor de PostgreSQL. Debe estar entre 7 y 35 días."
  type        = number
  default     = 30
  validation {
    condition     = var.backup_retention_days >= 7 && var.backup_retention_days <= 35
    error_message = "El número de días para retener los backups debe estar entre 7 y 35 días."
  }
}

variable "geo_redundant_backup_enabled" {
  description = "Indica si el backup georredundante está habilitado ('true' o 'false')."
  default     = true
  type        = bool
}

variable "auto_grow_enabled" {
  description = "Indica si el almacenamiento automático está habilitado."
  default     = true
  type        = bool
}

variable "postgres_version" {
  description = "La versión del servidor de PostgreSQL, por ejemplo, '12'."
  type        = string
  default     = "16"
  validation {
    condition = can(regex("^(12|13|14|15|16)$", var.postgres_version))
    error_message = "La versión del servidor de PostgreSQL debe ser una de las siguientes: '12', '13', '14', '15', '16'."
  }
}


variable "database_name" {
  description = "El nombre de la base de datos de PostgreSQL. Debe tener entre 1 y 63 caracteres."
  type        = string
  validation {
    condition     = length(var.database_name) >= 1 && length(var.database_name) <= 63
    error_message = "El nombre de la base de datos debe tener entre 1 y 63 caracteres."
  }
}

variable "charset" {
  description = "El conjunto de caracteres para la base de datos de PostgreSQL."
  type        = string
  default     = "UTF8"
  validation {
    condition = can(regex("^[a-zA-Z0-9_]+$", var.charset))
    error_message = "El conjunto de caracteres debe ser una cadena válida de caracteres alfanuméricos y guiones bajos."
  }
}

variable "collation" {
  description = "La collation para la base de datos de PostgreSQL."
  type        = string
  default     = "es_ES"
  validation {
    condition = can(regex("^[a-zA-Z0-9._-]+$", var.collation))
    error_message = "La collation debe ser una cadena válida de caracteres alfanuméricos, puntos, guiones y guiones bajos."
  }
}

variable "zone" {
  description = "La zona de disponibilidad en la que se creará el servidor de PostgreSQL."
  type        = string
  default     = "1"
  validation {
    condition = can(regex("^[1-3]$", var.zone))
    error_message = "La zona de disponibilidad debe ser '1', '2' o '3'."
  }
}

