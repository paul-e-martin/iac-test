output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "vnet_subnets_name_id" {
  value = { for name, subnet in azurerm_subnet.subnet : name => subnet.id }
}
