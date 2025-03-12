locals {
  origin_group_name = "${var.name}-${var.environment}-origingroup"
  origin_name       = "${var.name}-${var.environment}-origin"
}


resource "azurerm_cdn_frontdoor_origin_group" "origin_group" {
  name                     = local.origin_group_name
  cdn_frontdoor_profile_id = var.cdn_frontdoor_profile_id

  load_balancing {
    additional_latency_in_milliseconds = var.additional_latency_in_milliseconds
    sample_size                        = var.sample_size
    successful_samples_required        = var.successful_samples_required
  }
}

resource "azurerm_cdn_frontdoor_origin" "origin" {
  name                          = local.origin_name
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.origin_group.id
  enabled                       = var.enabled

  certificate_name_check_enabled = var.certificate_name_check_enabled

  host_name          = var.host_name
  origin_host_header = var.origin_host_header
  http_port          = var.http_port
  https_port         = var.https_port
  priority           = var.priority
  weight             = var.weight

}
