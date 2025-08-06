# Azure AI Services (Azure Foundry and Azure ML) Terraform Configuration

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

# Create resource group for AI Services
resource "azurerm_resource_group" "ai_rg" {
  name     = "${var.project_name}-ai-rg"
  location = var.location
  tags     = var.tags
}

# Create storage account for ML workspace
resource "azurerm_storage_account" "ml_storage" {
  name                     = "${replace(var.project_name, "-", "")}mlstorage"
  resource_group_name      = azurerm_resource_group.ai_rg.name
  location                 = azurerm_resource_group.ai_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = var.tags
}

# Create Key Vault for ML workspace
resource "azurerm_key_vault" "ml_keyvault" {
  name                = "${var.project_name}-ml-kv"
  location            = azurerm_resource_group.ai_rg.location
  resource_group_name = azurerm_resource_group.ai_rg.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
    ]

    secret_permissions = [
      "Get",
    ]
  }

  tags = var.tags
}

# Create Application Insights for ML workspace
resource "azurerm_application_insights" "ml_insights" {
  name                = "${var.project_name}-ml-insights"
  location            = azurerm_resource_group.ai_rg.location
  resource_group_name = azurerm_resource_group.ai_rg.name
  application_type    = "web"
  tags                = var.tags
}

# Create Container Registry for ML workspace
resource "azurerm_container_registry" "ml_acr" {
  name                = "${replace(var.project_name, "-", "")}mlacr"
  resource_group_name = azurerm_resource_group.ai_rg.name
  location            = azurerm_resource_group.ai_rg.location
  sku                 = "Basic"
  admin_enabled       = false
  tags                = var.tags
}

# Create Machine Learning Workspace
resource "azurerm_machine_learning_workspace" "ml_workspace" {
  name                    = "${var.project_name}-ml-workspace"
  location                = azurerm_resource_group.ai_rg.location
  resource_group_name     = azurerm_resource_group.ai_rg.name
  storage_account_id      = azurerm_storage_account.ml_storage.id
  key_vault_id            = azurerm_key_vault.ml_keyvault.id
  application_insights_id = azurerm_application_insights.ml_insights.id
  container_registry_id   = azurerm_container_registry.ml_acr.id

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}

# Create Cognitive Services Account (for AI Foundry)
resource "azurerm_cognitive_account" "ai_foundry" {
  name                = "${var.project_name}-ai-foundry"
  location            = azurerm_resource_group.ai_rg.location
  resource_group_name = azurerm_resource_group.ai_rg.name
  kind                = "CognitiveServices"
  sku_name            = var.cognitive_services_sku

  tags = var.tags
}

# Create OpenAI Service
resource "azurerm_cognitive_account" "openai" {
  name                = "${var.project_name}-openai"
  location            = azurerm_resource_group.ai_rg.location
  resource_group_name = azurerm_resource_group.ai_rg.name
  kind                = "OpenAI"
  sku_name            = var.openai_sku

  tags = var.tags
}

# Create OpenAI Deployment for GPT model
resource "azurerm_cognitive_deployment" "gpt_deployment" {
  name                 = "gpt-4o-mini"
  cognitive_account_id = azurerm_cognitive_account.openai.id

  model {
    format  = "OpenAI"
    name    = "gpt-4o-mini"
    version = "2024-07-18"
  }

  sku {
    name = "Standard"
  }
}

# Create OpenAI Deployment for Embedding model
resource "azurerm_cognitive_deployment" "embedding_deployment" {
  name                 = "text-embedding-ada-002"
  cognitive_account_id = azurerm_cognitive_account.openai.id

  model {
    format  = "OpenAI"
    name    = "text-embedding-ada-002"
    version = "2"
  }

  sku {
    name = "Standard"
  }
}

# Get current client config
data "azurerm_client_config" "current" {}
