output "resource_group_name" {
  value = module.rg.resource_group_name
}

output "natgw_public_ip_address" {
  value = module.natgw.natgw_public_ip_address
}
