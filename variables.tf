variable "environment" {
  description = "Environment"
}

variable "subscription_id" {
  description = "Subscription id for resources to be deployed to"
  type        = string
}

# Log analytics workspace module
variable "law_sku" {
  type = string
}

variable "law_retention_in_days" {
  type = number
}

# VNet module

# natgw module

# Static website module

# CDN profile module
variable "cdn_sku" {
  type = string
}

# CDN endpoint module

# App Gateway module
variable "appgw_capacity" {
  type = number
}

# AKS module
variable "default_node_pool_node_count" {
  type = number
}

variable "default_node_pool_vm_size" {
  type = string
}

variable "default_node_pool_zones" {
  type = list(number)
}

variable "auto_scaling_enabled" {
  type = bool
}

variable "default_node_pool_min_count" {
  type = number
}

variable "default_node_pool_max_count" {
  type = number
}

variable "default_node_pool_upgrade_settings" {
  type = map(any)
}

variable "automatic_upgrade_channel" {
  type = string
}

variable "node_os_upgrade_channel" {
  type = string
}

variable "maintenance_window" {
  type = map(any)
}

variable "maintenance_window_auto_upgrade" {
  type = map(any)
}

variable "maintenance_window_node_os" {
  type = map(any)
}

# ACR module
variable "acr_sku" {
  type = string
}

# Key Vault module
variable "key_vault_soft_delete_retention_days" {
  type = number
}

variable "key_vault_sku_name" {
  type = string
}

# DB module
variable "db_private_dns_zone_name" {
  type = string
}

variable "db_dns_zone_vnet_link_name" {
  type = string
}

variable "db_version" {
  type = string
}

variable "db_zone" {
  type = string
}

variable "db_storage_mb" {
  type = number
}
variable "db_sku_name" {
  type = string
}

variable "db_backup_retention_days" {
  type = number
}

variable "db_ha" {
  #type = map(any)
}

# Web pubsub module
variable "web_pubsub_sku" {
  type = string
}

variable "web_pubsub_capacity" {
  type = number
}
