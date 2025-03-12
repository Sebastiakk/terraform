locals {
  endpoint_name = "${var.name}-${var.environment}-endpoint"
  route_name    = "${var.name}-${var.environment}-route"
}

resource "azurerm_cdn_frontdoor_endpoint" "endpoint" {
  name                     = local.endpoint_name
  cdn_frontdoor_profile_id = var.cdn_frontdoor_profile_id
  tags = {
    environment = var.environment
  }
}

resource "azurerm_cdn_frontdoor_route" "route" {
  name                          = local.route_name
  cdn_frontdoor_endpoint_id     = azurerm_cdn_frontdoor_endpoint.endpoint.id
  cdn_frontdoor_origin_group_id = var.cdn_frontdoor_origin_group_id
  cdn_frontdoor_origin_ids      = var.cdn_frontdoor_origin_ids
  enabled                       = var.enabled

  forwarding_protocol    = var.forwarding_protocol
  https_redirect_enabled = var.https_redirect_enabled
  patterns_to_match      = var.patterns_to_match
  supported_protocols    = var.supported_protocols

  cache {
    query_string_caching_behavior = var.query_string_caching_behavior
    query_strings                 = var.query_strings
    compression_enabled           = var.compression_enabled
    content_types_to_compress     = var.content_types_to_compress
  }
}
