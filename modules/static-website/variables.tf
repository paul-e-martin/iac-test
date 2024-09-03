variable "storage_account_name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type        = string
  description = "Location"
}

variable "storage_account_tier" {
  description = "Storage account tier"
}

variable "storage_account_replication_type" {
  description = "Storage account replication type"
}

variable "common_tags" {
  type = map(string)
}
