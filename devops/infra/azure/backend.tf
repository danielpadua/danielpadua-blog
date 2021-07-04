terraform {
  backend "azurerm" {
    resource_group_name   = "danielpadua-dev-rg"
    storage_account_name  = "blogterraform"
    container_name        = "blogterraform"
    key                   = "terraform.tfstate"
  }
}
