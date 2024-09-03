variable "acr_name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "acr_sku" {
  type = string
}

variable "principal_id" {
  type = string
}

# variable "retention_policy" {
#   type = object({
#     days    = number
#     enabled = bool
#   })
# }

variable "log_analytics_workspace_id" {
  type = string
}

variable "common_tags" {
  type = map(string)
}
