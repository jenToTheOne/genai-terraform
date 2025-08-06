output "ml_workspace_id" {
  description = "ID of the Machine Learning workspace"
  value       = azurerm_machine_learning_workspace.ml_workspace.id
}

output "ml_workspace_name" {
  description = "Name of the Machine Learning workspace"
  value       = azurerm_machine_learning_workspace.ml_workspace.name
}

output "cognitive_services_endpoint" {
  description = "Endpoint for Cognitive Services"
  value       = azurerm_cognitive_account.ai_foundry.endpoint
}

output "openai_endpoint" {
  description = "Endpoint for OpenAI Service"
  value       = azurerm_cognitive_account.openai.endpoint
}

output "openai_primary_key" {
  description = "Primary key for OpenAI Service"
  value       = azurerm_cognitive_account.openai.primary_access_key
  sensitive   = true
}

output "resource_group_name" {
  description = "Name of the AI Services resource group"
  value       = azurerm_resource_group.ai_rg.name
}

output "storage_account_name" {
  description = "Name of the ML storage account"
  value       = azurerm_storage_account.ml_storage.name
}

output "container_registry_name" {
  description = "Name of the Container Registry"
  value       = azurerm_container_registry.ml_acr.name
}
