# Create a Private DNS zone for PostgreSQL
resource "azurerm_private_dns_zone" "db_private_dns_zone" {
  name                = var.db_private_dns_zone_name
  resource_group_name = var.resource_group_name
  tags                = var.common_tags
}

# Associate PostgreSQL Private DNS zone with virtual network
resource "azurerm_private_dns_zone_virtual_network_link" "db_dns_zone_vnet_link" {
  name                  = var.db_dns_zone_vnet_link_name
  private_dns_zone_name = azurerm_private_dns_zone.db_private_dns_zone.name
  virtual_network_id    = var.virtual_network_id
  resource_group_name   = var.resource_group_name
  tags                  = var.common_tags
}

# Generate PostgreSQL admin password
resource "random_password" "db_admin_password" {
  length  = 20
  special = true
  lower   = true
  upper   = true
}

# Store PostgreSQL admin login in Azure Key Vault
# az keyvault secret set --vault-name "..." --name "postgres-db-login" --value "..."
resource "azurerm_key_vault_secret" "db_admin_login" {
  name         = "postgres-db-login"
  value        = "psqladmin"
  key_vault_id = var.key_vault_id
  tags         = var.common_tags
}

# Store PostgreSQL admin password in Azure Key Vault
resource "azurerm_key_vault_secret" "db_admin_password" {
  name         = "postgres-db-password"
  value        = random_password.db_admin_password.result
  key_vault_id = var.key_vault_id
  tags         = var.common_tags
}

resource "azurerm_postgresql_flexible_server" "db_server" {
  name                          = var.db_server_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  version                       = var.db_version
  delegated_subnet_id           = var.delegated_subnet_id
  private_dns_zone_id           = azurerm_private_dns_zone.db_private_dns_zone.id
  public_network_access_enabled = false
  administrator_login           = azurerm_key_vault_secret.db_admin_login.value
  administrator_password        = azurerm_key_vault_secret.db_admin_password.value
  zone                          = var.db_zone
  storage_mb                    = var.db_storage_mb
  sku_name                      = var.db_sku_name
  backup_retention_days         = var.db_backup_retention_days
  tags                          = var.common_tags

  dynamic "high_availability" {
    for_each = var.db_ha != null && contains(keys(var.db_ha), "mode") ? [var.db_ha] : []
    content {
      mode = high_availability.value.mode
    }
  }

  depends_on = [azurerm_private_dns_zone_virtual_network_link.db_dns_zone_vnet_link]

  lifecycle {
    create_before_destroy = true
  }
}

# Create databases in PostgreSQL Server
resource "azurerm_postgresql_flexible_server_database" "db" {
  for_each = { for name in var.db_names : name => name }

  name      = each.key
  server_id = azurerm_postgresql_flexible_server.db_server.id
  collation = "en_US.utf8"
  charset   = "UTF8"

  depends_on = [azurerm_postgresql_flexible_server.db_server]
}

# Create diagnostic settings
resource "azurerm_monitor_diagnostic_setting" "diag_psql" {
  name                       = "amds-default"
  target_resource_id         = azurerm_postgresql_flexible_server.db_server.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  enabled_log {
    category_group = "allLogs"
  }
  metric {
    category = "AllMetrics"
    enabled  = true
  }
}
