locals {
  azure_common_tags = {
    environment = var.environment
    managedBy   = "terraform"
  }
}

# Resource group
module "rg" {
  source              = "./modules/rg"
  location            = local.location
  resource_group_name = data.azurecaf_name.rg.result
  common_tags         = local.azure_common_tags
}

# Log analytics workspace
module "law" {
  source                     = "./modules/log-analytics-workspace"
  location                   = module.rg.resource_group_location
  resource_group_name        = module.rg.resource_group_name
  law_name                   = data.azurecaf_name.law.result
  law_sku                    = var.law_sku
  law_retention_in_days      = var.law_retention_in_days
  log_analytics_workspace_id = module.law.log_analytics_workspace_id
  common_tags                = local.azure_common_tags
}

# Virtual Network
module "vnet" {
  source                     = "./modules/vnet"
  env                        = var.environment
  subnets                    = local.subnets
  vnet_name                  = data.azurecaf_name.vnet.result
  vnet_location              = module.rg.resource_group_location
  resource_group_name        = module.rg.resource_group_name
  address_space              = local.address_space
  nsg_list                   = local.nsg_list
  security_rules             = local.security_rules
  log_analytics_workspace_id = module.law.log_analytics_workspace_id
  common_tags                = local.azure_common_tags
}

# NAT Gateway
module "natgw" {
  source                     = "./modules/natgw"
  natgw_public_ip_name       = data.azurecaf_name.natgw_pip.result
  location                   = module.rg.resource_group_location
  resource_group_name        = module.rg.resource_group_name
  natgw_name                 = data.azurecaf_name.natgw.result
  subnet_ids                 = [for subnet_name in local.natgw_subnet_names : module.vnet.vnet_subnets_name_id[subnet_name]]
  log_analytics_workspace_id = module.law.log_analytics_workspace_id
  common_tags                = local.azure_common_tags
}

# Static-website
module "static-website" {
  source   = "./modules/static-website"
  for_each = local.sites

  storage_account_name             = each.key
  location                         = module.rg.resource_group_location
  resource_group_name              = module.rg.resource_group_name
  storage_account_tier             = each.value.storage_account_tier
  storage_account_replication_type = each.value.storage_account_replication_type
  common_tags                      = local.azure_common_tags
}

# CDN profile
module "cdn-profile" {
  source                     = "./modules/cdn-profile"
  cdn_profile_name           = data.azurecaf_name.cdnprof.result
  location                   = "global"
  resource_group_name        = module.rg.resource_group_name
  cdn_sku                    = var.cdn_sku
  log_analytics_workspace_id = module.law.log_analytics_workspace_id
  common_tags                = local.azure_common_tags
}

# CDN endpoint
# After creating the endpoint add a CNAME record pointing to the CDN endpoint
module "cdn-endpoint" {
  source   = "./modules/cdn-endpoint"
  for_each = local.cdn_endpoints

  cdn_profile_name                     = module.cdn-profile.cdn_profile_name
  location                             = "global"
  resource_group_name                  = module.rg.resource_group_name
  cdn_endpoint_name                    = each.key
  origin_name                          = each.value.origin_name
  origin_url                           = lookup(module.static-website, each.value.origin_name).static_website_primary_web_host
  cdn_endpoint_custom_domain_name      = each.value.cdn_endpoint_custom_domain_name
  cdn_endpoint_custom_domain_host_name = each.value.cdn_endpoint_custom_domain_host_name
  log_analytics_workspace_id           = module.law.log_analytics_workspace_id
  common_tags                          = local.azure_common_tags
}

# APP Gateway
module "appgw" {
  source                               = "./modules/appgw"
  appgw_public_ip_name                 = data.azurecaf_name.appgw_pip.result
  appgw_name                           = data.azurecaf_name.appgw.result
  location                             = module.rg.resource_group_location
  resource_group_name                  = module.rg.resource_group_name
  appgw_sku                            = local.appgw_sku
  appgw_capacity                       = var.appgw_capacity
  appgw_gateway_ip_configuration_name  = local.appgw_gateway_ip_configuration_name
  appgw_gateway_ip_configuration       = local.appgw_gateway_ip_configuration
  appgw_gateway_subnet_id              = module.vnet.vnet_subnets_name_id[local.appgw_subnet_name]
  appgw_frontend_port_name             = local.appgw_frontend_port_name
  appgw_frontend_port                  = local.appgw_frontend_port
  appgw_frontend_ip_configuration_name = local.appgw_frontend_ip_configuration_name
  appgw_frontend_ip_configuration      = local.appgw_frontend_ip_configuration
  appgw_backend_address_pool_name      = local.appgw_backend_address_pool_name
  appgw_backend_address_pool           = local.appgw_backend_address_pool
  appgw_backend_http_settings_name     = local.appgw_backend_http_settings_name
  appgw_backend_http_settings          = local.appgw_backend_http_settings
  appgw_http_listener_name             = local.appgw_http_listener_name
  appgw_http_listener                  = local.appgw_http_listener
  appgw_request_routing_rule_name      = local.appgw_request_routing_rule_name
  appgw_request_routing_rule           = local.appgw_request_routing_rule
  log_analytics_workspace_id           = module.law.log_analytics_workspace_id
  common_tags                          = local.azure_common_tags
  depends_on                           = [module.vnet]
}

# AKS
module "aks" {
  source                             = "./modules/aks"
  cluster_name                       = data.azurecaf_name.aks.result
  location                           = module.rg.resource_group_location
  resource_group_name                = module.rg.resource_group_name
  default_node_pool_node_count       = var.default_node_pool_node_count
  default_node_pool_vm_size          = var.default_node_pool_vm_size
  default_node_pool_zones            = var.default_node_pool_zones
  auto_scaling_enabled               = var.auto_scaling_enabled
  default_node_pool_min_count        = var.default_node_pool_min_count
  default_node_pool_max_count        = var.default_node_pool_max_count
  default_node_pool_vnet_subnet_id   = module.vnet.vnet_subnets_name_id[local.default_node_pool_vnet_subnet_name]
  default_node_pool_upgrade_settings = var.default_node_pool_upgrade_settings
  service_cidr                       = local.service_cidr
  dns_service_ip                     = local.dns_service_ip
  ingress_application_gateway_id     = module.appgw.application_gateway_id
  automatic_upgrade_channel          = var.automatic_upgrade_channel
  node_os_upgrade_channel            = var.node_os_upgrade_channel
  maintenance_window                 = var.maintenance_window
  maintenance_window_auto_upgrade    = var.maintenance_window_auto_upgrade
  maintenance_window_node_os         = var.maintenance_window_node_os
  log_analytics_workspace_id         = module.law.log_analytics_workspace_id
  common_tags                        = local.azure_common_tags
}

# ACR
module "acr" {
  source                     = "./modules/acr"
  acr_name                   = data.azurecaf_name.cr.result
  location                   = module.rg.resource_group_location
  resource_group_name        = module.rg.resource_group_name
  acr_sku                    = var.acr_sku
  principal_id               = module.aks.kubelet_identity_object_id
  log_analytics_workspace_id = module.law.log_analytics_workspace_id
  common_tags                = local.azure_common_tags
}

# Key vault
module "key-vault" {
  source                               = "./modules/key-vault"
  location                             = module.rg.resource_group_location
  resource_group_name                  = module.rg.resource_group_name
  key_vault_name                       = data.azurecaf_name.kv.result
  key_vault_soft_delete_retention_days = var.key_vault_soft_delete_retention_days
  key_vault_sku_name                   = var.key_vault_sku_name
  log_analytics_workspace_id           = module.law.log_analytics_workspace_id
  common_tags                          = local.azure_common_tags
}

# DB
module "db" {
  source                     = "./modules/db"
  location                   = module.rg.resource_group_location
  resource_group_name        = module.rg.resource_group_name
  db_private_dns_zone_name   = local.db_private_dns_zone_name
  db_dns_zone_vnet_link_name = local.db_dns_zone_vnet_link_name
  db_server_name             = lower(data.azurecaf_name.psql.result)
  db_version                 = var.db_version
  delegated_subnet_id        = module.vnet.vnet_subnets_name_id[local.delegated_subnet_id_name]
  db_zone                    = var.db_zone
  db_storage_mb              = var.db_storage_mb
  db_sku_name                = var.db_sku_name
  db_backup_retention_days   = var.db_backup_retention_days
  db_ha                      = var.db_ha
  virtual_network_id         = module.vnet.vnet_id
  key_vault_id               = module.key-vault.key_vault_id
  db_names                   = [data.azurecaf_name.psqldb.result]
  log_analytics_workspace_id = module.law.log_analytics_workspace_id
  common_tags                = local.azure_common_tags
}

# Web_pubsub
module "web_pubsub" {
  source                     = "./modules/web_pubsub"
  location                   = module.rg.resource_group_location
  resource_group_name        = module.rg.resource_group_name
  web_pubsub_name            = data.azurecaf_name.web_pubsub.result
  web_pubsub_sku             = var.web_pubsub_sku
  web_pubsub_capacity        = var.web_pubsub_capacity
  log_analytics_workspace_id = module.law.log_analytics_workspace_id
  common_tags                = local.azure_common_tags
}
