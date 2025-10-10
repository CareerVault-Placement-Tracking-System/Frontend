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

  use_oidc       = true
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
  client_id       = var.client_id

  # Correct usage: comma-separated string
  resource_provider_registrations = "Microsoft.Web,Microsoft.Resources,Microsoft.ContainerService,Microsoft.Network,Microsoft.OperationalInsights"
}


# --------------------------
# Resource Group
# --------------------------
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# --------------------------
# Linux App Service Plan
# --------------------------
resource "azurerm_service_plan" "plan" {
  name                = "${var.app_name_prefix}-plan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"
  sku_name            = "B1"
}

# --------------------------
# Random Suffix for uniqueness
# --------------------------
resource "random_id" "suffix" {
  byte_length = 3
}

# --------------------------
# Linux Web App
# --------------------------
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
# AKS Cluster
# --------------------------
resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${var.app_name_prefix}-aks"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "${var.app_name_prefix}-dns"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_DS2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Dev"
  }
}
