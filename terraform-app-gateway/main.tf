# Azure Application Gateway Terraform Configuration

terraform {
  required_version = ">= 1.0"
  
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# Create resource group for Application Gateway
resource "azurerm_resource_group" "appgw_rg" {
  name     = "${var.project_name}-appgw-rg"
  location = var.location
  tags     = var.tags
}

# Create virtual network for Application Gateway
resource "azurerm_virtual_network" "appgw_vnet" {
  name                = "${var.project_name}-${var.vnet_name}"
  address_space       = var.vnet_address_space
  location            = azurerm_resource_group.appgw_rg.location
  resource_group_name = azurerm_resource_group.appgw_rg.name
  tags                = var.tags
}

# Create subnet for Application Gateway
resource "azurerm_subnet" "appgw_subnet" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.appgw_rg.name
  virtual_network_name = azurerm_virtual_network.appgw_vnet.name
  address_prefixes     = var.subnet_address_prefixes
}

# Create public IP for Application Gateway
resource "azurerm_public_ip" "appgw_pip" {
  name                = "${var.project_name}-appgw-pip"
  resource_group_name = azurerm_resource_group.appgw_rg.name
  location            = azurerm_resource_group.appgw_rg.location
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

# Create Application Gateway
resource "azurerm_application_gateway" "appgw" {
  name                = "${var.project_name}-appgw"
  resource_group_name = azurerm_resource_group.appgw_rg.name
  location            = azurerm_resource_group.appgw_rg.location

  sku {
    name     = var.appgw_sku_name
    tier     = var.appgw_sku_tier
    capacity = var.appgw_capacity
  }

  gateway_ip_configuration {
    name      = "appgw-ip-configuration"
    subnet_id = azurerm_subnet.appgw_subnet.id
  }

  frontend_port {
    name = "frontend-port-80"
    port = 80
  }

  frontend_port {
    name = "frontend-port-443"
    port = 443
  }

  frontend_ip_configuration {
    name                 = "frontend-ip-configuration"
    public_ip_address_id = azurerm_public_ip.appgw_pip.id
  }

  backend_address_pool {
    name = "backend-pool"
  }

  backend_http_settings {
    name                  = "backend-http-settings"
    cookie_based_affinity = "Disabled"
    path                  = "/"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

  http_listener {
    name                           = "http-listener"
    frontend_ip_configuration_name = "frontend-ip-configuration"
    frontend_port_name             = "frontend-port-80"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "routing-rule"
    rule_type                  = "Basic"
    http_listener_name         = "http-listener"
    backend_address_pool_name  = "backend-pool"
    backend_http_settings_name = "backend-http-settings"
    priority                   = 100
  }

  tags = var.tags
}
