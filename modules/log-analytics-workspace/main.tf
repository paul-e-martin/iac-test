resource "azurerm_log_analytics_workspace" "law" {
  name                = var.law_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.law_sku
  retention_in_days   = var.law_retention_in_days
  tags                = var.common_tags
}

# Create diagnostic settings
resource "azurerm_monitor_diagnostic_setting" "diag_law" {
  name                       = "amds-default"
  target_resource_id         = azurerm_log_analytics_workspace.law.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  enabled_log {
    category_group = "allLogs"
  }
  metric {
    category = "AllMetrics"
    enabled  = true
  }
}
