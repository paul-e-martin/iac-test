resource "random_string" "storage_account_name" {
  length  = 5
  special = false
  upper   = false
}

resource "azurerm_storage_account" "static_website" {
  name                          = "${var.storage_account_name}${random_string.storage_account_name.result}"
  resource_group_name           = var.resource_group_name
  location                      = var.location
  account_tier                  = var.storage_account_tier
  account_replication_type      = var.storage_account_replication_type
  public_network_access_enabled = true
  min_tls_version               = "TLS1_2"

  static_website {
    index_document     = "index.html"
    error_404_document = "404.html"
  }

  tags = var.common_tags
}

resource "azurerm_storage_blob" "static_website" {
  name                   = "index.html"
  storage_account_name   = azurerm_storage_account.static_website.name
  storage_container_name = "$web"
  type                   = "Block"
  content_type           = "text/html"
  source                 = "./src/index.html"

  lifecycle {
    ignore_changes = [
      content_md5
    ]
  }
}
