variable "appgw_public_ip_name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "appgw_name" {
  type = string
}

variable "appgw_sku" {
  type = map(any)
}

variable "appgw_capacity" {
  type = number
}
variable "appgw_gateway_ip_configuration_name" {
  type = string
}

variable "appgw_gateway_ip_configuration" {
  type = map(any)
}

variable "appgw_gateway_subnet_id" {
  type = string
}

variable "appgw_frontend_port_name" {
  type = string
}

variable "appgw_frontend_port" {
  type = map(any)
}

variable "appgw_frontend_ip_configuration_name" {
  type = string
}

variable "appgw_frontend_ip_configuration" {
  type = map(any)
}

variable "appgw_backend_address_pool_name" {
  type = string
}

variable "appgw_backend_address_pool" {
  type = map(any)
}

variable "appgw_backend_http_settings_name" {
  type = string
}

variable "appgw_backend_http_settings" {
  type = map(any)
}

variable "appgw_http_listener_name" {
  type = string
}

variable "appgw_http_listener" {
  type = map(any)
}

variable "appgw_request_routing_rule_name" {
  type = string
}

variable "appgw_request_routing_rule" {
  type = map(any)
}

variable "log_analytics_workspace_id" {
  type = string
}

variable "common_tags" {
  type = map(string)
}
