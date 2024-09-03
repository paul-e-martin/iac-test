resource "azurerm_cdn_endpoint" "endpoint" {
  name                          = lower(var.cdn_endpoint_name)
  profile_name                  = var.cdn_profile_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  is_http_allowed               = true
  is_https_allowed              = true
  querystring_caching_behaviour = "IgnoreQueryString"
  is_compression_enabled        = true
  content_types_to_compress = [
    "application/eot",
    "application/font",
    "application/font-sfnt",
    "application/javascript",
    "application/json",
    "application/opentype",
    "application/otf",
    "application/pkcs7-mime",
    "application/truetype",
    "application/ttf",
    "application/vnd.ms-fontobject",
    "application/xhtml+xml",
    "application/xml",
    "application/xml+rss",
    "application/x-font-opentype",
    "application/x-font-truetype",
    "application/x-font-ttf",
    "application/x-httpd-cgi",
    "application/x-javascript",
    "application/x-mpegurl",
    "application/x-opentype",
    "application/x-otf",
    "application/x-perl",
    "application/x-ttf",
    "font/eot",
    "font/ttf",
    "font/otf",
    "font/opentype",
    "image/svg+xml",
    "text/css",
    "text/csv",
    "text/html",
    "text/javascript",
    "text/js",
    "text/plain",
    "text/richtext",
    "text/tab-separated-values",
    "text/xml",
    "text/x-script",
    "text/x-component",
    "text/x-java-source",
  ]

  origin_host_header = var.origin_url
  origin {
    name      = var.origin_name
    host_name = var.origin_url
  }

  delivery_rule {
    name  = "EnforceHTTPS"
    order = 1

    request_scheme_condition {
      operator     = "Equal"
      match_values = ["HTTP"]
    }

    url_redirect_action {
      redirect_type = "PermanentRedirect"
      protocol      = "Https"
    }
  }

  delivery_rule {
    name  = "AddHtmlExtension"
    order = 2

    url_path_condition {
      operator = "Any"
    }

    url_rewrite_action {
      source_pattern          = "/(.*)"
      destination             = "/$1.html"
      preserve_unmatched_path = false
    }
  }

  tags = var.common_tags
}

/*resource "azurerm_cdn_endpoint_custom_domain" "custom_domain" {
  name            = var.cdn_endpoint_custom_domain_name
  cdn_endpoint_id = azurerm_cdn_endpoint.endpoint.id
  host_name       = var.cdn_endpoint_custom_domain_host_name

  cdn_managed_https {
    certificate_type = "Dedicated"
    protocol_type    = "ServerNameIndication"
    tls_version      = "TLS12"
  }
}*/

# Create diagnostic settings
resource "azurerm_monitor_diagnostic_setting" "diag_cdn" {
  name                       = "amds-default"
  target_resource_id         = azurerm_cdn_endpoint.endpoint.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  enabled_log {
    category_group = "allLogs"
  }
}
