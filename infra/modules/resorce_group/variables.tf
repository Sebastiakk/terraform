variable "name" {
  description = "Nombre del grupo de recursos"
  type        = string
}

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
