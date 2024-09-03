variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "web_pubsub_name" {
  type = string
}

variable "web_pubsub_sku" {
  type = string
}

variable "web_pubsub_capacity" {
  type = number
}

variable "log_analytics_workspace_id" {
  type = string
}

variable "common_tags" {
  type = map(string)
}
