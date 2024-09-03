variable "cdn_endpoint_name" {
  type = string
}

variable "cdn_profile_name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "origin_url" {
  type = string
}

variable "origin_name" {
  type = string
}

variable "cdn_endpoint_custom_domain_name" {
  type = string
}

variable "cdn_endpoint_custom_domain_host_name" {
  type = string
}

variable "log_analytics_workspace_id" {
  type = string
}

variable "common_tags" {
  type = map(string)
}
