variable "name" {
  description = "El nombre del endpoint y ruta de Azure Front Door."
  type        = string
  validation {
    condition     = length(var.name) <= 12
    error_message = "El nombre del endpoint debe tener 12 caracteres o menos."
  }
}

variable "cdn_frontdoor_profile_id" {
  description = "El ID del perfil de Azure Front Door asociado."
  type        = string
}


variable "cdn_frontdoor_origin_group_id" {
  description = "El ID del grupo de orígenes de Azure Front Door asociado."
  type        = string
}

variable "cdn_frontdoor_origin_ids" {
  description = "Lista de IDs de orígenes de Azure Front Door asociados."
  type = list(string)
}

variable "enabled" {
  description = "Indica si la ruta está habilitada."
  type        = bool
  default     = true
}

variable "forwarding_protocol" {
  description = "El protocolo de reenvío de la ruta."
  type        = string
  default     = "HttpsOnly"
  validation {
    condition = contains(["HttpOnly", "HttpsOnly", "MatchRequest"], var.forwarding_protocol)
    error_message = "El protocolo de reenvío debe ser 'HttpOnly', 'HttpsOnly' o 'MatchRequest'."
  }
}

variable "https_redirect_enabled" {
  description = "Indica si la redirección HTTPS está habilitada."
  type        = bool
  default     = true
}

variable "patterns_to_match" {
  description = "Patrones para coincidir en la ruta."
  type = list(string)
  default = ["/*"]
}

variable "supported_protocols" {
  description = "Protocolos soportados por la ruta."
  type = list(string)
  default = ["Http", "Https"]
  validation {
    condition     = length(var.supported_protocols) > 0
    error_message = "Debe haber al menos un protocolo soportado."
  }
}

variable "query_string_caching_behavior" {
  description = "Comportamiento de caché de cadenas de consulta."
  type        = string
  default     = "IgnoreSpecifiedQueryStrings"
  validation {
    condition = contains([
      "IgnoreQueryString", "IgnoreSpecifiedQueryStrings", "IncludeSpecifiedQueryStrings", "IncludeAllQueryStrings"
    ], var.query_string_caching_behavior)
    error_message = "El comportamiento de caché de cadenas de consulta debe ser 'IgnoreQueryString', 'IgnoreSpecifiedQueryStrings', 'IncludeSpecifiedQueryStrings' o 'IncludeAllQueryStrings'."
  }
}

variable "query_strings" {
  description = "Lista de cadenas de consulta a ignorar o incluir."
  type = list(string)
  default = ["account", "settings"]
}

variable "compression_enabled" {
  description = "Indica si la compresión está habilitada."
  type        = bool
  default     = true
}

variable "content_types_to_compress" {
  description = "Lista de tipos de contenido a comprimir."
  type = list(string)
  default = ["text/html", "text/javascript", "text/xml"]
}

variable "environment" {
  description = "Entorno de los recursos"
  type        = string
}

