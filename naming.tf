# resource group naming via caf
data "azurecaf_name" "rg" {

  resource_type = "azurerm_resource_group"
  prefixes      = [local.resource_prefix, var.environment, local.location_short]
  suffixes      = []
  use_slug      = local.use_caf_naming
  clean_input   = true
  separator     = "-"
}

# log analytics workspace naming via caf
data "azurecaf_name" "law" {

  resource_type = "azurerm_log_analytics_workspace"
  prefixes      = [local.resource_prefix, var.environment, local.location_short]
  suffixes      = []
  use_slug      = local.use_caf_naming
  clean_input   = true
  separator     = "-"
}

# vnet naming via caf
data "azurecaf_name" "vnet" {

  resource_type = "azurerm_virtual_network"
  prefixes      = [local.resource_prefix, var.environment, local.location_short]
  suffixes      = []
  use_slug      = local.use_caf_naming
  clean_input   = true
  separator     = "-"
}

# natgw naming via caf
data "azurecaf_name" "natgw" {

  resource_type = "azurerm_resource_group"
  prefixes      = [local.resource_prefix, var.environment, local.location_short]
  suffixes      = ["natgw"]
  use_slug      = false
  clean_input   = true
  separator     = "-"
}

# natgw public ip naming via caf
data "azurecaf_name" "natgw_pip" {

  resource_type = "azurerm_public_ip"
  prefixes      = [data.azurecaf_name.natgw.result]
  suffixes      = []
  use_slug      = local.use_caf_naming
  clean_input   = true
  separator     = "-"
}

# cdn profile naming via caf
data "azurecaf_name" "cdnprof" {

  resource_type = "azurerm_cdn_profile"
  prefixes      = [local.resource_prefix, var.environment]
  suffixes      = []
  use_slug      = local.use_caf_naming
  clean_input   = true
  separator     = "-"
}

# appgw naming via caf
data "azurecaf_name" "appgw" {

  resource_type = "azurerm_application_gateway"
  prefixes      = [local.resource_prefix, var.environment, local.location_short]
  suffixes      = []
  use_slug      = local.use_caf_naming
  clean_input   = true
  separator     = "-"
}

# appgw public ip naming via caf
data "azurecaf_name" "appgw_pip" {

  resource_type = "azurerm_public_ip"
  prefixes      = [data.azurecaf_name.appgw.result]
  suffixes      = []
  use_slug      = local.use_caf_naming
  clean_input   = true
  separator     = "-"
}

# aks naming via caf
data "azurecaf_name" "aks" {

  resource_type = "azurerm_kubernetes_cluster"
  prefixes      = [local.resource_prefix, var.environment, local.location_short]
  suffixes      = []
  use_slug      = local.use_caf_naming
  clean_input   = true
  separator     = "-"
}

# container registry naming via caf
data "azurecaf_name" "cr" {

  resource_type = "azurerm_container_registry"
  prefixes      = [local.resource_prefix, var.environment, local.location_short]
  suffixes      = []
  use_slug      = local.use_caf_naming
  clean_input   = true
  separator     = "-"
}

# key vault naming via caf
data "azurecaf_name" "kv" {

  resource_type = "azurerm_key_vault"
  prefixes      = [local.resource_prefix, var.environment, local.location_short]
  suffixes      = []
  use_slug      = local.use_caf_naming
  clean_input   = true
  separator     = "-"
}

# postgres server naming via caf
data "azurecaf_name" "psql" {

  resource_type = "azurerm_postgresql_server"
  prefixes      = [local.resource_prefix, var.environment, local.location_short]
  suffixes      = []
  use_slug      = local.use_caf_naming
  clean_input   = true
  separator     = "-"
}

# postgres db naming via caf
data "azurecaf_name" "psqldb" {

  resource_type = "azurerm_postgresql_database"
  prefixes      = [local.resource_prefix, var.environment]
  suffixes      = []
  use_slug      = local.use_caf_naming
  clean_input   = true
  separator     = "-"
}

# web pubsub naming via caf
data "azurecaf_name" "web_pubsub" {

  resource_type = "azurerm_web_pubsub"
  prefixes      = [local.resource_prefix, var.environment]
  suffixes      = ["wps"]
  use_slug      = false
  clean_input   = true
  separator     = "-"
}
