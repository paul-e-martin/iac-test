variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "law_name" {
  type = string
}

variable "law_sku" {
  type = string
}

variable "law_retention_in_days" {
  type = number
}

variable "log_analytics_workspace_id" {
  type = string
}

variable "common_tags" {
  type = map(string)
}
