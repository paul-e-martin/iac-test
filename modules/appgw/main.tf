resource "azurerm_public_ip" "appgw_public_ip" {
  name                = var.appgw_public_ip_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.common_tags
}

resource "azurerm_application_gateway" "appgw" {
  name                = var.appgw_name
  location            = var.location
  resource_group_name = var.resource_group_name

  sku {
    name     = var.appgw_sku.name
    tier     = var.appgw_sku.tier
    capacity = var.appgw_capacity
  }

  gateway_ip_configuration {
    name      = var.appgw_gateway_ip_configuration_name
    subnet_id = var.appgw_gateway_subnet_id
  }

  frontend_port {
    name = var.appgw_frontend_port_name
    port = var.appgw_frontend_port.port
  }

  frontend_ip_configuration {
    name                 = var.appgw_frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.appgw_public_ip.id
  }

  backend_address_pool {
    name = var.appgw_backend_address_pool_name
  }

  backend_http_settings {
    name                  = var.appgw_backend_http_settings_name
    cookie_based_affinity = var.appgw_backend_http_settings.cookie_based_affinity
    path                  = var.appgw_backend_http_settings.path
    port                  = var.appgw_backend_http_settings.port
    protocol              = var.appgw_backend_http_settings.protocol
    request_timeout       = var.appgw_backend_http_settings.request_timeout
  }

  http_listener {
    name                           = var.appgw_http_listener_name
    frontend_ip_configuration_name = var.appgw_frontend_ip_configuration_name
    frontend_port_name             = var.appgw_frontend_port_name
    protocol                       = var.appgw_http_listener.protocol
  }

  request_routing_rule {
    name                       = var.appgw_request_routing_rule_name
    priority                   = var.appgw_request_routing_rule.priority
    rule_type                  = var.appgw_request_routing_rule.rule_type
    http_listener_name         = var.appgw_http_listener_name
    backend_address_pool_name  = var.appgw_backend_address_pool_name
    backend_http_settings_name = var.appgw_backend_http_settings_name
  }

  tags = var.common_tags
}

# Create diagnostic settings
resource "azurerm_monitor_diagnostic_setting" "diag_appgw_pip" {
  name                       = "amds-default"
  target_resource_id         = azurerm_public_ip.appgw_public_ip.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  enabled_log {
    category_group = "allLogs"
  }
  metric {
    category = "AllMetrics"
    enabled  = true
  }
}

resource "azurerm_monitor_diagnostic_setting" "diag_appgw" {
  name                       = "amds-default"
  target_resource_id         = azurerm_application_gateway.appgw.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  enabled_log {
    category_group = "allLogs"
  }
  metric {
    category = "AllMetrics"
    enabled  = true
  }
}
