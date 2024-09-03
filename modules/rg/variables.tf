variable "resource_group_name" {
  type = string
}

variable "location" {
  type        = string
  description = "Location"
}

variable "common_tags" {
  type = map(string)
}
