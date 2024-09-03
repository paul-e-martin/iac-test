variable "cluster_name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

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

variable "default_node_pool_vnet_subnet_id" {
  type = string
}

variable "default_node_pool_upgrade_settings" {
  type = map(any)
}

variable "service_cidr" {
  type = string
}

variable "dns_service_ip" {
  type = string
}

variable "ingress_application_gateway_id" {
  type = string
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

variable "log_analytics_workspace_id" {
  type = string
}

variable "common_tags" {
  type = map(string)
}
