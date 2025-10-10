terraform {
  required_version = ">= 1.4.0"

  backend "azurerm" {
    resource_group_name  = "rg-terraform"
    storage_account_name = "tfstatecareervault01"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
  use_oidc = true
  skip_provider_registration = true
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
  client_id       = var.client_id
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_service_plan" "plan" {
  name                = "${var.app_name_prefix}-plan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"
  sku_name            = "B1"
}

resource "random_id" "suffix" {
  byte_length = 3
}

resource "azurerm_linux_web_app" "app" {
  name                = "${var.app_name_prefix}-${random_id.suffix.hex}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.plan.id

  site_config {
    application_stack {
      node_version = "20-lts"
    }
  }

  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE" = "1"
  }
}

output "webapp_name" {
  description = "The name of the deployed Web App"
  value       = azurerm_linux_web_app.app.name
}

output "webapp_url" {
  description = "The URL of the deployed Web App"
  value       = "https://${azurerm_linux_web_app.app.default_hostname}"
}
