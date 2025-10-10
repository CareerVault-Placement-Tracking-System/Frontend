output "resource_group_name" {
  value       = azurerm_resource_group.rg.name
  description = "The name of the resource group created."
}

output "app_service_name" {
  value       = azurerm_linux_web_app.app.name
  description = "The name of the Linux Web App (CAREERVAULT web app)."
}

output "app_service_url" {
  value       = "https://${azurerm_linux_web_app.app.default_hostname}"
  description = "Public URL of the deployed CAREERVAULT app."
}
output "aks_cluster_name" {
  value       = azurerm_kubernetes_cluster.aks.name
  description = "The name of the AKS cluster"
}
