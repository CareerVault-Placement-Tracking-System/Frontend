/* terraform {
  required_version = ">= 1.4.0"

  backend "azurerm" {
    resource_group_name  = "rg-terraform"
    storage_account_name = "tfstatecareervault01"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
} */
