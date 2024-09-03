variable "db_private_dns_zone_name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "db_dns_zone_vnet_link_name" {
  type = string
}

variable "virtual_network_id" {
  type = string
}

variable "key_vault_id" {
  type = string
}

variable "db_server_name" {
  type = string
}

variable "location" {
  type = string
}

variable "db_version" {
  type = string
}

variable "delegated_subnet_id" {
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

variable "db_names" {
  type = list(string)
}

variable "log_analytics_workspace_id" {
  type = string
}

variable "common_tags" {
  type = map(string)
}
