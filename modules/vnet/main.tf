resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = var.address_space
  location            = var.vnet_location
  resource_group_name = var.resource_group_name
  tags                = var.common_tags
}

resource "azurerm_subnet" "subnet" {
  for_each = var.subnets

  name                 = each.key
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = each.value.address_prefixes

  service_endpoints = each.value.service_endpoints != null ? each.value.service_endpoints : []

  dynamic "delegation" {
    for_each = each.value.delegation != null ? [each.value.delegation] : []

    content {
      name = delegation.value.name

      dynamic "service_delegation" {
        for_each = delegation.value.service_delegation != null ? [delegation.value.service_delegation] : []

        content {
          name    = service_delegation.value.name
          actions = service_delegation.value.actions
        }
      }
    }
  }
}

resource "azurerm_network_security_group" "nsg" {
  for_each = var.nsg_list

  name                = "${var.vnet_name}_${each.value.nsg_name}"
  location            = var.vnet_location
  resource_group_name = var.resource_group_name
  tags                = var.common_tags
}

locals {
  nsg_rules = flatten([
    for subnet, rules in var.security_rules : [
      for rule in rules : {
        subnet = subnet
        rule   = rule
      }
    ]
  ])
}

resource "azurerm_network_security_rule" "nsg_rules" {
  for_each = { for rule in local.nsg_rules : "${rule.subnet}-${rule.rule.name}" => rule }

  name                         = each.value.rule.name
  description                  = each.value.rule.description
  priority                     = each.value.rule.priority
  direction                    = each.value.rule.direction
  access                       = each.value.rule.access
  protocol                     = each.value.rule.protocol
  source_port_range            = try(each.value.rule.source_port_range, null)
  source_port_ranges           = try(each.value.rule.source_port_ranges, null)
  destination_port_range       = try(each.value.rule.destination_port_range, null)
  destination_port_ranges      = try(each.value.rule.destination_port_ranges, null)
  source_address_prefix        = try(each.value.rule.source_address_prefix, null)
  source_address_prefixes      = try(each.value.rule.source_address_prefixes, null)
  destination_address_prefix   = try(each.value.rule.destination_address_prefix, null)
  destination_address_prefixes = try(each.value.rule.destination_address_prefixes, null)

  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.nsg[each.value.subnet].name
}

resource "azurerm_subnet_network_security_group_association" "nsg_association" {
  for_each = azurerm_subnet.subnet

  subnet_id                 = each.value.id
  network_security_group_id = azurerm_network_security_group.nsg[each.key].id
}

# Create diagnostic settings
resource "azurerm_monitor_diagnostic_setting" "diag_vnet" {
  name                       = "amds-default"
  target_resource_id         = azurerm_virtual_network.vnet.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  enabled_log {
    category_group = "allLogs"
  }
  metric {
    category = "AllMetrics"
    enabled  = true
  }
}

# Create diagnostic settings
resource "azurerm_monitor_diagnostic_setting" "diag_nsg" {
  for_each = azurerm_network_security_group.nsg

  name                       = "amds-default"
  target_resource_id         = each.value.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  enabled_log {
    category_group = "allLogs"
  }
}
