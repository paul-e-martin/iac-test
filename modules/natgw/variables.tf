variable "natgw_public_ip_name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "natgw_name" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "log_analytics_workspace_id" {
  type = string
}

variable "common_tags" {
  type = map(string)
}
