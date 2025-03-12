variable "name" {
  description = "El nombre del origen de Azure Front Door."
  type        = string
  validation {
    condition     = length(var.name) <= 12
    error_message = "El nombre del origen debe tener 12 caracteres o menos."
  }
}

variable "cdn_frontdoor_profile_id" {
  description = "El ID del perfil de Azure Front Door asociado."
  type        = string
}

variable "additional_latency_in_milliseconds" {
  description = "Latencia adicional en milisegundos para el balanceo de carga."
  type        = number
  default     = 0
}

variable "sample_size" {
  description = "Tamaño de muestra para el balanceo de carga."
  type        = number
  default     = 16
}

variable "successful_samples_required" {
  description = "Número de muestras exitosas requeridas para el balanceo de carga."
  type        = number
  default     = 3
}


variable "enabled" {
  description = "Indica si el origen está habilitado."
  type        = bool
  default     = true
}

variable "certificate_name_check_enabled" {
  description = "Indica si la verificación del nombre del certificado está habilitada."
  type        = bool
  default     = false
}

variable "host_name" {
  description = "El nombre del host del origen."
  type        = string
}

variable "origin_host_header" {
  description = "El encabezado del host del origen."
  type        = string
}

variable "http_port" {
  description = "El puerto HTTP del origen."
  type        = number
  default     = 80
}

variable "https_port" {
  description = "El puerto HTTPS del origen."
  type        = number
  default     = 443
}

variable "priority" {
  description = "La prioridad del origen."
  type        = number
  default     = 1
}

variable "weight" {
  description = "El peso del origen."
  type        = number
  default     = 1
}

variable "environment" {
  description = "Entorno de los recursos"
  type        = string
}

