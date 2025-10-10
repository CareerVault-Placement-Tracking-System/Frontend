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
}


# Create Resource Group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# Create App Service Plan
resource "azurerm_service_plan" "plan" {
  name                = "${var.app_name_prefix}-plan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"
  sku_name            = "B1"
}

# Generate Random Suffix for Unique Web App Name
resource "random_id" "suffix" {
  byte_length = 3
}

# Create Web App
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

# --------------------------
# ✅ Terraform Outputs
# --------------------------

output "webapp_name" {
  description = "The name of the deployed Web App"
  value       = azurerm_linux_web_app.app.name
}

output "webapp_url" {
  description = "The URL of the deployed Web App"
  value       = "https://${azurerm_linux_web_app.app.default_hostname}"
}
