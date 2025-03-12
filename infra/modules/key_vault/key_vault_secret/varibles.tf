variable "secret_name" {
  description = "El nombre del Key Vault."
  type        = string

  validation {
    condition = can(regex("^[a-zA-Z0-9-]+$", var.secret_name))
    error_message = "El nombre del secreto solo puede contener letras, números y guiones (-)."
  }
}

variable "project_name" {
  description = "El nombre del proyecto al cual pertenece el secreto."
  type        = string

  validation {
    condition = can(regex("^[a-zA-Z0-9-]+$", var.project_name))
    error_message = "El nombre del secreto solo puede contener letras, números y guiones (-)."
  }
}

variable "key_vault_id" {
  description = "El ID del Key Vault."
  type        = string
}

variable "value" {
  description = "Valores a almacenar en el Key Vault."
  type        = string
}

variable "content_type" {
  description = "El tipo de contenido del secreto en el Key Vault"
  type        = string
  default     = "text/plain"

  validation {
    condition = contains([
      "text/plain", "application/json", "application/xml", "binary/octet-stream"
    ], var.content_type)
    error_message = "El tipo de contenido del secreto debe ser uno de los siguientes valores: text/plain, application/json, application/xml, binary/octet-stream."
  }
}


variable "environment" {
  description = "Entorno de los recursos"
  type        = string
}


