output "application_gateway_id" {
  description = "ID of the Application Gateway"
  value       = azurerm_application_gateway.appgw.id
}

output "application_gateway_name" {
  description = "Name of the Application Gateway"
  value       = azurerm_application_gateway.appgw.name
}

output "public_ip_address" {
  description = "Public IP address of the Application Gateway"
  value       = azurerm_public_ip.appgw_pip.ip_address
}

output "resource_group_name" {
  description = "Name of the Application Gateway resource group"
  value       = azurerm_resource_group.appgw_rg.name
}

output "virtual_network_id" {
  description = "ID of the Application Gateway virtual network"
  value       = azurerm_virtual_network.appgw_vnet.id
}
