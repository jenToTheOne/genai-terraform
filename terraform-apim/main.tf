# Azure API Management Terraform Configuration

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

# Create resource group for APIM
resource "azurerm_resource_group" "apim_rg" {
  name     = "${var.project_name}-apim-rg"
  location = var.location
  tags     = var.tags
}

# Create virtual network for APIM
resource "azurerm_virtual_network" "apim_vnet" {
  name                = "${var.project_name}-${var.vnet_name}"
  address_space       = var.vnet_address_space
  location            = azurerm_resource_group.apim_rg.location
  resource_group_name = azurerm_resource_group.apim_rg.name
  tags                = var.tags
}

# Create subnet for APIM
resource "azurerm_subnet" "apim_subnet" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.apim_rg.name
  virtual_network_name = azurerm_virtual_network.apim_vnet.name
  address_prefixes     = var.subnet_address_prefixes
}

# Create Application Insights for APIM monitoring
resource "azurerm_application_insights" "apim_insights" {
  name                = "${var.project_name}-apim-insights"
  location            = azurerm_resource_group.apim_rg.location
  resource_group_name = azurerm_resource_group.apim_rg.name
  application_type    = "web"
  tags                = var.tags
}

# Create API Management instance
resource "azurerm_api_management" "apim" {
  name                = "${var.project_name}-apim"
  location            = azurerm_resource_group.apim_rg.location
  resource_group_name = azurerm_resource_group.apim_rg.name
  publisher_name      = var.publisher_name
  publisher_email     = var.publisher_email
  sku_name            = var.apim_sku

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}

# Create API Management Logger for Application Insights
resource "azurerm_api_management_logger" "apim_logger" {
  name                = "applicationinsights"
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = azurerm_resource_group.apim_rg.name

  application_insights {
    instrumentation_key = azurerm_application_insights.apim_insights.instrumentation_key
  }
}

# Create a sample API
resource "azurerm_api_management_api" "sample_api" {
  name                  = "sample-api"
  resource_group_name   = azurerm_resource_group.apim_rg.name
  api_management_name   = azurerm_api_management.apim.name
  revision              = "1"
  display_name          = "Sample API"
  path                  = "sample"
  protocols             = ["https"]
  description           = "Sample API for demonstration"
  service_url           = "https://jsonplaceholder.typicode.com"

  import {
    content_format = "openapi"
    content_value  = file("${path.module}/api-spec.json")
  }
}
