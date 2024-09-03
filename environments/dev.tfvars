# Environment
environment     = "dev"
subscription_id = "1dc9155a-a0b8-4162-88c1-58d2d387c747"

# Resource group module

# Tfstate-backend module

# Log analytics workspace module
law_sku               = "PerGB2018"
law_retention_in_days = 30

# VNet module

# NAT Gateway module

# Static website module

# CDN profile module
cdn_sku = "Standard_Microsoft"

# CDN endpoint module

# App Gateway module
appgw_capacity = 1

# AKS module
default_node_pool_node_count = 1
default_node_pool_vm_size    = "Standard_D2_v2"
default_node_pool_zones      = [1]
auto_scaling_enabled         = false
default_node_pool_min_count  = null
default_node_pool_max_count  = null
default_node_pool_upgrade_settings = {
  max_surge = "10%"
}
automatic_upgrade_channel = null        #patch, rapid, node-image, stable
node_os_upgrade_channel   = "NodeImage" #Unmanaged, SecurityPatch, NodeImage, None
maintenance_window = {
  day        = "Sunday"
  start_hour = 0
  end_hour   = 4
}
maintenance_window_auto_upgrade = {
  frequency   = "Weekly"
  interval    = 1
  duration    = 4
  day_of_week = "Sunday"
  start_time  = "00:00"
  utc_offset  = "+00:00"
}
maintenance_window_node_os = {
  frequency   = "Weekly"
  interval    = 1
  duration    = 4
  day_of_week = "Sunday"
  start_time  = "00:00"
  utc_offset  = "+00:00"
}

# ACR module
acr_sku = "Basic"

# Key Vault module
key_vault_soft_delete_retention_days = 7
key_vault_sku_name                   = "standard"

# DB module
db_private_dns_zone_name   = "db-private-dns-zone.postgres.database.azure.com"
db_dns_zone_vnet_link_name = "postgresql-dns-zone-vnet-link"
db_version                 = "16"
db_zone                    = "1"
db_storage_mb              = 32768
db_sku_name                = "B_Standard_B1ms"
db_backup_retention_days   = 7
db_ha = {
  #mode = "SameZone" #SameZone or ZoneRedundant
}

# Web pubsub module
web_pubsub_sku      = "Free_F1"
web_pubsub_capacity = 1
