resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.acr_sku
  admin_enabled       = false

  #   retention_policy {
  #     days    = var.retention_policy.days
  #     enabled = var.retention_policy.enabled
  #   }

  tags = var.common_tags
}

resource "azurerm_role_assignment" "acr_role_assignment" {
  principal_id                     = var.principal_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.acr.id
  skip_service_principal_aad_check = true
}

# Create diagnostic settings
resource "azurerm_monitor_diagnostic_setting" "diag_acr" {
  name                       = "amds-default"
  target_resource_id         = azurerm_container_registry.acr.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  enabled_log {
    category_group = "allLogs"
  }
  metric {
    category = "AllMetrics"
    enabled  = true
  }
}
