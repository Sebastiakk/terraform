variable "location" {
  description = "Ubicación de la red virtual"
  type        = string
}

variable "resource_group_name" {
  description = "Nombre del grupo de recursos donde se creará la red virtual"
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

variable "prefix" {
  description = "Prefijo para los nombres de los recursos"
  type        = string
}

variable "bastion_subnet_id" {
  description = "ID de la subred de bastión"
  type        = string
}





