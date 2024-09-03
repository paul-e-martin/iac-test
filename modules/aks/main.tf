data "azurerm_kubernetes_service_versions" "aks_version" {
  location        = var.location
  include_preview = false
}

resource "azurerm_kubernetes_cluster" "k8s_cluster" {
  name                      = var.cluster_name
  location                  = var.location
  resource_group_name       = var.resource_group_name
  dns_prefix                = var.cluster_name
  kubernetes_version        = data.azurerm_kubernetes_service_versions.aks_version.latest_version
  automatic_upgrade_channel = var.automatic_upgrade_channel
  node_os_upgrade_channel   = var.node_os_upgrade_channel

  default_node_pool {
    name                 = "default"
    node_count           = var.default_node_pool_node_count
    vm_size              = var.default_node_pool_vm_size
    zones                = var.default_node_pool_zones
    auto_scaling_enabled = var.auto_scaling_enabled
    min_count            = var.default_node_pool_min_count
    max_count            = var.default_node_pool_max_count
    vnet_subnet_id       = var.default_node_pool_vnet_subnet_id
    upgrade_settings {
      max_surge = var.default_node_pool_upgrade_settings.max_surge
    }
    tags = merge(
      var.common_tags,
      {
        nodepool = "default"
      }
    )
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin = "azure"
    service_cidr   = var.service_cidr
    dns_service_ip = var.dns_service_ip

    load_balancer_sku = "standard"
    network_policy    = "calico"
  }

  key_vault_secrets_provider {
    secret_rotation_enabled = true
  }

  ingress_application_gateway {
    gateway_id = var.ingress_application_gateway_id
  }

  maintenance_window {
    allowed {
      day   = var.maintenance_window.day
      hours = [var.maintenance_window.start_hour, var.maintenance_window.end_hour]
    }
  }

  maintenance_window_auto_upgrade {
    frequency   = var.maintenance_window_auto_upgrade.frequency
    interval    = var.maintenance_window_auto_upgrade.interval
    duration    = var.maintenance_window_auto_upgrade.duration
    day_of_week = var.maintenance_window_auto_upgrade.day_of_week
    start_time  = var.maintenance_window_auto_upgrade.start_time
    utc_offset  = var.maintenance_window_auto_upgrade.utc_offset
  }

  maintenance_window_node_os {
    frequency   = var.maintenance_window_node_os.frequency
    interval    = var.maintenance_window_node_os.interval
    duration    = var.maintenance_window_node_os.duration
    day_of_week = var.maintenance_window_node_os.day_of_week
    start_time  = var.maintenance_window_node_os.start_time
    utc_offset  = var.maintenance_window_node_os.utc_offset
  }

  tags = var.common_tags

  lifecycle {
    create_before_destroy = true
  }
}

# Create diagnostic settings
resource "azurerm_monitor_diagnostic_setting" "diag_aks" {
  name                       = "amds-default"
  target_resource_id         = azurerm_kubernetes_cluster.k8s_cluster.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  enabled_log {
    category_group = "allLogs"
  }
  metric {
    category = "AllMetrics"
    enabled  = true
  }
}
