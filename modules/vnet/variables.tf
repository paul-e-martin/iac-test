variable "env" {
  description = "Environment"
}

variable "vnet_name" {
  type = string
}

variable "address_space" {
  type = list(string)
}

variable "vnet_location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "subnets" {
  type = map(object({
    address_prefixes  = list(string)
    service_endpoints = list(string)
    delegation = object({
      name = string
      service_delegation = object({
        name    = string
        actions = list(string)
      })
    })
  }))
}

variable "nsg_list" {
  type = map(any)
}

variable "security_rules" {
  type = any
}

variable "log_analytics_workspace_id" {
  type = string
}

variable "common_tags" {
  type = map(string)
}
