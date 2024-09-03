resource "azurerm_cdn_profile" "profile" {
  name                = var.cdn_profile_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.cdn_sku
  tags                = var.common_tags
}

# Create diagnostic settings
resource "azurerm_monitor_diagnostic_setting" "diag_cdnprof" {
  name                       = "amds-default"
  target_resource_id         = azurerm_cdn_profile.profile.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  enabled_log {
    category_group = "allLogs"
  }
  metric {
    category = "AllMetrics"
    enabled  = true
  }
}
