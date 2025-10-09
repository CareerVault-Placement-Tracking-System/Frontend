# Variables used across Terraform files

# Region where Azure resources will be created
variable "location" {
  type    = string
  default = "southindia"
}

# Resource group name
variable "resource_group_name" {
  type    = string
  default = "careervault-rg"
}

# Prefix for naming resources (keep lowercase, Azure naming rules)
variable "app_name_prefix" {
  type    = string
  default = "careervault"
}
