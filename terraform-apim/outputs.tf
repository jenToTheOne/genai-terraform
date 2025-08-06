output "apim_id" {
  description = "ID of the API Management instance"
  value       = azurerm_api_management.apim.id
}

output "apim_name" {
  description = "Name of the API Management instance"
  value       = azurerm_api_management.apim.name
}

output "apim_gateway_url" {
  description = "Gateway URL of the API Management instance"
  value       = azurerm_api_management.apim.gateway_url
}

output "apim_management_api_url" {
  description = "Management API URL of the API Management instance"
  value       = azurerm_api_management.apim.management_api_url
}

output "resource_group_name" {
  description = "Name of the APIM resource group"
  value       = azurerm_resource_group.apim_rg.name
}

output "virtual_network_id" {
  description = "ID of the APIM virtual network"
  value       = azurerm_virtual_network.apim_vnet.id
}
