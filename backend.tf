terraform {
  backend "azurerm" {
    resource_group_name  = "cg-uks-rg"
    storage_account_name = "cgdevuksstterraform"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
    #use_azuread_auth     = true
  }
}
