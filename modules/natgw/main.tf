resource "azurerm_public_ip" "public_ip" {
  name                = var.natgw_public_ip_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.common_tags
}

resource "azurerm_nat_gateway" "natgw" {
  name                = var.natgw_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.common_tags
}

resource "azurerm_nat_gateway_public_ip_association" "natgw_ip_association" {
  nat_gateway_id       = azurerm_nat_gateway.natgw.id
  public_ip_address_id = azurerm_public_ip.public_ip.id
}

resource "azurerm_subnet_nat_gateway_association" "natgw_subnet_association" {
  for_each       = { for idx, subnet_id in var.subnet_ids : idx => subnet_id }
  subnet_id      = each.value
  nat_gateway_id = azurerm_nat_gateway.natgw.id
}

# Create diagnostic settings
resource "azurerm_monitor_diagnostic_setting" "diag_natgw_pip" {
  name                       = "amds-default"
  target_resource_id         = azurerm_public_ip.public_ip.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  enabled_log {
    category_group = "allLogs"
  }
  metric {
    category = "AllMetrics"
    enabled  = true
  }
}
