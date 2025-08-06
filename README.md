# OCBC GenAI Terraform Infrastructure

This repository contains Terraform configurations for deploying Azure infrastructure components for OCBC's GenAI initiative. The infrastructure is organized into separate modules for different Azure services.

## 🏗️ Project Structure

```
├── terraform-aks/           # Azure Kubernetes Service (AKS)
├── terraform-apim/          # Azure API Management
├── terraform-app-gateway/   # Azure Application Gateway
├── terraform-ai-services/   # Azure AI Services (Foundry & ML)
├── shared/                  # Shared configurations
└── README.md               # This file
```

## 📋 Prerequisites

1. **Azure CLI**: Install and configure
   ```bash
   az login
   az account set --subscription "your-subscription-id"
   ```

2. **Terraform**: Install Terraform (version 1.0 or later)
   - Download from [terraform.io](https://www.terraform.io/downloads.html)

3. **Azure Subscription**: Ensure you have contributor access

## 🚀 Deployment Options

### Option 1: Deploy Individual Services

Navigate to each service directory and deploy independently:

```bash
# Deploy AKS
cd terraform-aks
terraform init
terraform plan
terraform apply

# Deploy API Management
cd ../terraform-apim
terraform init
terraform plan
terraform apply

# Deploy Application Gateway
cd ../terraform-app-gateway
terraform init
terraform plan
terraform apply

# Deploy AI Services
cd ../terraform-ai-services
terraform init
terraform plan
terraform apply
```

## 🔧 Services Overview

### 1. Azure Kubernetes Service (AKS) - `terraform-aks/`
- **Purpose**: Container orchestration platform
- **Components**:
  - AKS cluster with auto-scaling
  - Virtual network and subnet
  - Log Analytics workspace
  - System-assigned managed identity
- **Network**: 10.1.0.0/16

### 2. Azure API Management - `terraform-apim/`
- **Purpose**: API gateway and management platform
- **Components**:
  - API Management instance
  - Application Insights integration
  - Virtual network integration
  - Sample API configuration
- **Network**: 10.2.0.0/16

### 3. Azure Application Gateway - `terraform-app-gateway/`
- **Purpose**: Web traffic load balancer and application delivery controller
- **Components**:
  - Application Gateway v2
  - Public IP address
  - HTTP/HTTPS listeners
  - Backend pools and health probes
- **Network**: 10.3.0.0/16

### 4. Azure AI Services - `terraform-ai-services/`
- **Purpose**: AI and ML services for GenAI workloads
- **Components**:
  - Azure Machine Learning workspace
  - Azure OpenAI Service
  - Cognitive Services
  - Container Registry
  - Key Vault and Storage Account
- **Models**: GPT-4o-mini, Text-Embedding-Ada-002

## 🔧 Configuration

Each service directory contains:
- `main.tf` - Main resource definitions
- `variables.tf` - Input variables
- `outputs.tf` - Output values

### Common Variables

All services share these common variables:
- `project_name` - Base name for resources (default: "ocbc-genai")
- `location` - Azure region (default: "Southeast Asia")
- `environment` - Environment tag (default: "dev")
- `tags` - Common resource tags

## 🌐 Network Architecture

The infrastructure uses separate virtual networks for each service:

```
┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐
│   AKS VNet      │  │   APIM VNet     │  │  App GW VNet    │  │ AI Services RG  │
│  10.1.0.0/16    │  │  10.2.0.0/16    │  │  10.3.0.0/16    │  │  (No VNet)      │
│                 │  │                 │  │                 │  │                 │
│ ┌─────────────┐ │  │ ┌─────────────┐ │  │ ┌─────────────┐ │  │ ┌─────────────┐ │
│ │ AKS Subnet  │ │  │ │ APIM Subnet │ │  │ │AppGW Subnet │ │  │ │  ML/AI      │ │
│ │10.1.1.0/24  │ │  │ │10.2.1.0/24  │ │  │ │10.3.1.0/24  │ │  │ │ Services    │ │
│ └─────────────┘ │  │ └─────────────┘ │  │ └─────────────┘ │  │ └─────────────┘ │
│ └─────────────┘ │  │ └─────────────┘ │  │ └─────────────┘ │  │ └─────────────┘ │
└─────────────────┘  └─────────────────┘  └─────────────────┘  └─────────────────┘
```

## 📊 Outputs

Each service provides outputs that can be used by other services or applications.

## 🔒 Security Considerations

1. **Managed Identities**: All services use system-assigned managed identities
2. **Key Vault**: Secrets stored in Azure Key Vault
3. **Network Security**: Services deployed in isolated virtual networks
4. **Access Controls**: RBAC configured for service access
5. **Monitoring**: Application Insights and Log Analytics enabled

## 💰 Cost Optimization

- AKS: Auto-scaling enabled (1-5 nodes)
- APIM: Developer tier for testing
- Application Gateway: Standard v2 with minimal capacity
- AI Services: Standard tiers with pay-as-you-go

## 🤝 Contributing

1. Create feature branch
2. Make changes
3. Test deployment in dev environment  
4. Submit pull request

## 📞 Support

For questions or issues:
- Create GitHub issue
- Contact: OCBC GenAI Team
