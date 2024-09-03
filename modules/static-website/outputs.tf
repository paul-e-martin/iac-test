output "static_website_storage_account_name" {
  value = azurerm_storage_account.static_website.name
}

output "static_website_primary_web_host" {
  value = azurerm_storage_account.static_website.primary_web_host
}
