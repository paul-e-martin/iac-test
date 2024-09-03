resource "azurerm_web_pubsub" "web_pubsub" {
  name                = var.web_pubsub_name
  location            = var.location
  resource_group_name = var.resource_group_name

  sku      = var.web_pubsub_sku
  capacity = var.web_pubsub_capacity

  public_network_access_enabled = false

  live_trace {
    enabled                   = true
    messaging_logs_enabled    = true
    connectivity_logs_enabled = false
  }

  identity {
    type = "SystemAssigned"
  }
}

# Create diagnostic settings
resource "azurerm_monitor_diagnostic_setting" "diag_web_pubsub" {
  name                       = "amds-default"
  target_resource_id         = azurerm_web_pubsub.web_pubsub.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  enabled_log {
    category_group = "allLogs"
  }
  metric {
    category = "AllMetrics"
    enabled  = true
  }
}
