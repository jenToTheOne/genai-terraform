# Azure Kubernetes Service (AKS) Terraform Configuration

# Include shared provider configuration
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

# Create resource group for AKS
resource "azurerm_resource_group" "aks_rg" {
  name     = "${var.project_name}-aks-rg"
  location = var.location
  tags     = var.tags
}

# Create virtual network for AKS
resource "azurerm_virtual_network" "aks_vnet" {
  name                = "${var.project_name}-${var.vnet_name}"
  address_space       = var.vnet_address_space
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
  tags                = var.tags
}

# Create subnet for AKS nodes
resource "azurerm_subnet" "aks_subnet" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.aks_rg.name
  virtual_network_name = azurerm_virtual_network.aks_vnet.name
  address_prefixes     = var.subnet_address_prefixes
}

# Create Log Analytics Workspace for AKS monitoring
resource "azurerm_log_analytics_workspace" "aks_logs" {
  name                = "${var.project_name}-aks-logs"
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  tags                = var.tags
}

# Create AKS cluster
resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${var.project_name}-aks"
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
  dns_prefix          = "${var.project_name}-aks"
  kubernetes_version  = var.kubernetes_version

  default_node_pool {
    name               = "default"
    node_count         = var.node_count
    vm_size            = var.node_vm_size
    vnet_subnet_id     = azurerm_subnet.aks_subnet.id
    enable_auto_scaling = true
    min_count          = 1
    max_count          = 5
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin = "azure"
    network_policy = "azure"
  }

  oms_agent {
    log_analytics_workspace_id = azurerm_log_analytics_workspace.aks_logs.id
  }

  tags = var.tags
}
