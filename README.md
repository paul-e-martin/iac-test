# Infrastructure as code

## Login to Azure and set the required subscription
```
az login
az account list
az account show
az account set --subscription <subscription_id>
```

## Initialize Terraform
```
terraform init
```

## Apply Terraform configuration to the required environment
```
terraform plan -var-file="dev-test.tfvars"
terraform apply -var-file="dev-test.tfvars"
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurecaf"></a> [azurecaf](#requirement\_azurecaf) | ~> 1.2, >= 1.2.22 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurecaf"></a> [azurecaf](#provider\_azurecaf) | 1.2.28 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_acr"></a> [acr](#module\_acr) | ./modules/acr | n/a |
| <a name="module_aks"></a> [aks](#module\_aks) | ./modules/aks | n/a |
| <a name="module_appgw"></a> [appgw](#module\_appgw) | ./modules/appgw | n/a |
| <a name="module_cdn-endpoint"></a> [cdn-endpoint](#module\_cdn-endpoint) | ./modules/cdn-endpoint | n/a |
| <a name="module_cdn-profile"></a> [cdn-profile](#module\_cdn-profile) | ./modules/cdn-profile | n/a |
| <a name="module_db"></a> [db](#module\_db) | ./modules/db | n/a |
| <a name="module_key-vault"></a> [key-vault](#module\_key-vault) | ./modules/key-vault | n/a |
| <a name="module_law"></a> [law](#module\_law) | ./modules/log-analytics-workspace | n/a |
| <a name="module_natgw"></a> [natgw](#module\_natgw) | ./modules/natgw | n/a |
| <a name="module_rg"></a> [rg](#module\_rg) | ./modules/rg | n/a |
| <a name="module_static-website"></a> [static-website](#module\_static-website) | ./modules/static-website | n/a |
| <a name="module_vnet"></a> [vnet](#module\_vnet) | ./modules/vnet | n/a |
| <a name="module_web_pubsub"></a> [web\_pubsub](#module\_web\_pubsub) | ./modules/web_pubsub | n/a |

## Resources

| Name | Type |
|------|------|
| [azurecaf_name.aks](https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/data-sources/name) | data source |
| [azurecaf_name.appgw](https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/data-sources/name) | data source |
| [azurecaf_name.appgw_pip](https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/data-sources/name) | data source |
| [azurecaf_name.cdnprof](https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/data-sources/name) | data source |
| [azurecaf_name.cr](https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/data-sources/name) | data source |
| [azurecaf_name.kv](https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/data-sources/name) | data source |
| [azurecaf_name.law](https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/data-sources/name) | data source |
| [azurecaf_name.natgw](https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/data-sources/name) | data source |
| [azurecaf_name.natgw_pip](https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/data-sources/name) | data source |
| [azurecaf_name.psql](https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/data-sources/name) | data source |
| [azurecaf_name.psqldb](https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/data-sources/name) | data source |
| [azurecaf_name.rg](https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/data-sources/name) | data source |
| [azurecaf_name.vnet](https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/data-sources/name) | data source |
| [azurecaf_name.web_pubsub](https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/data-sources/name) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acr_sku"></a> [acr\_sku](#input\_acr\_sku) | ACR module | `string` | n/a | yes |
| <a name="input_appgw_capacity"></a> [appgw\_capacity](#input\_appgw\_capacity) | App Gateway module | `number` | n/a | yes |
| <a name="input_auto_scaling_enabled"></a> [auto\_scaling\_enabled](#input\_auto\_scaling\_enabled) | n/a | `bool` | n/a | yes |
| <a name="input_automatic_upgrade_channel"></a> [automatic\_upgrade\_channel](#input\_automatic\_upgrade\_channel) | n/a | `string` | n/a | yes |
| <a name="input_cdn_sku"></a> [cdn\_sku](#input\_cdn\_sku) | CDN profile module | `string` | n/a | yes |
| <a name="input_db_backup_retention_days"></a> [db\_backup\_retention\_days](#input\_db\_backup\_retention\_days) | n/a | `number` | n/a | yes |
| <a name="input_db_ha"></a> [db\_ha](#input\_db\_ha) | n/a | `any` | n/a | yes |
| <a name="input_db_sku_name"></a> [db\_sku\_name](#input\_db\_sku\_name) | n/a | `string` | n/a | yes |
| <a name="input_db_storage_mb"></a> [db\_storage\_mb](#input\_db\_storage\_mb) | n/a | `number` | n/a | yes |
| <a name="input_db_version"></a> [db\_version](#input\_db\_version) | DB module | `string` | n/a | yes |
| <a name="input_db_zone"></a> [db\_zone](#input\_db\_zone) | n/a | `string` | n/a | yes |
| <a name="input_default_node_pool_max_count"></a> [default\_node\_pool\_max\_count](#input\_default\_node\_pool\_max\_count) | n/a | `number` | n/a | yes |
| <a name="input_default_node_pool_min_count"></a> [default\_node\_pool\_min\_count](#input\_default\_node\_pool\_min\_count) | n/a | `number` | n/a | yes |
| <a name="input_default_node_pool_node_count"></a> [default\_node\_pool\_node\_count](#input\_default\_node\_pool\_node\_count) | AKS module | `number` | n/a | yes |
| <a name="input_default_node_pool_upgrade_settings"></a> [default\_node\_pool\_upgrade\_settings](#input\_default\_node\_pool\_upgrade\_settings) | n/a | `map(any)` | n/a | yes |
| <a name="input_default_node_pool_vm_size"></a> [default\_node\_pool\_vm\_size](#input\_default\_node\_pool\_vm\_size) | n/a | `string` | n/a | yes |
| <a name="input_default_node_pool_zones"></a> [default\_node\_pool\_zones](#input\_default\_node\_pool\_zones) | n/a | `list(number)` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment | `string` | n/a | yes |
| <a name="input_key_vault_sku_name"></a> [key\_vault\_sku\_name](#input\_key\_vault\_sku\_name) | n/a | `string` | n/a | yes |
| <a name="input_key_vault_soft_delete_retention_days"></a> [key\_vault\_soft\_delete\_retention\_days](#input\_key\_vault\_soft\_delete\_retention\_days) | Key Vault module | `number` | n/a | yes |
| <a name="input_law_retention_in_days"></a> [law\_retention\_in\_days](#input\_law\_retention\_in\_days) | n/a | `number` | n/a | yes |
| <a name="input_law_sku"></a> [law\_sku](#input\_law\_sku) | Log analytics workspace module | `string` | n/a | yes |
| <a name="input_maintenance_window"></a> [maintenance\_window](#input\_maintenance\_window) | n/a | `map(any)` | n/a | yes |
| <a name="input_maintenance_window_auto_upgrade"></a> [maintenance\_window\_auto\_upgrade](#input\_maintenance\_window\_auto\_upgrade) | n/a | `map(any)` | n/a | yes |
| <a name="input_maintenance_window_node_os"></a> [maintenance\_window\_node\_os](#input\_maintenance\_window\_node\_os) | n/a | `map(any)` | n/a | yes |
| <a name="input_node_os_upgrade_channel"></a> [node\_os\_upgrade\_channel](#input\_node\_os\_upgrade\_channel) | n/a | `string` | n/a | yes |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | Subscription id for resources to be deployed to | `string` | n/a | yes |
| <a name="input_web_pubsub_capacity"></a> [web\_pubsub\_capacity](#input\_web\_pubsub\_capacity) | n/a | `number` | n/a | yes |
| <a name="input_web_pubsub_sku"></a> [web\_pubsub\_sku](#input\_web\_pubsub\_sku) | Web pubsub module | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_natgw_public_ip_address"></a> [natgw\_public\_ip\_address](#output\_natgw\_public\_ip\_address) | n/a |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | n/a |
<!-- END_TF_DOCS -->
