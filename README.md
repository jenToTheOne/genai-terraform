# Terraform Project

This Terraform project creates basic Azure infrastructure including a resource group, virtual network, and subnet.

## Prerequisites

1. **Azure CLI**: Install and configure the Azure CLI
2. **Terraform**: Install Terraform (version 1.0 or later)
3. **Azure Subscription**: Ensure you have access to an Azure subscription

## Setup Instructions

### 1. Install Terraform
Download and install Terraform from [terraform.io](https://www.terraform.io/downloads.html)

### 2. Azure Authentication
Login to Azure using the Azure CLI:
```bash
az login
```

Set your subscription (if you have multiple):
```bash
az account set --subscription "your-subscription-id"
```

### 3. Configure Variables
1. Copy the example variables file:
   ```bash
   copy terraform.tfvars.example terraform.tfvars
   ```

2. Edit `terraform.tfvars` with your desired values:
   ```hcl
   resource_group_name = "your-resource-group-name"
   location           = "East US"
   environment        = "dev"
   project_name       = "your-project-name"
   ```

### 4. Deploy Infrastructure

1. **Initialize Terraform**:
   ```bash
   terraform init
   ```

2. **Plan the deployment**:
   ```bash
   terraform plan
   ```

3. **Apply the configuration**:
   ```bash
   terraform apply
   ```

4. **Confirm the deployment** by typing `yes` when prompted.

### 5. Verify Deployment
Check the created resources in the Azure portal or using Azure CLI:
```bash
az group list --output table
```

## File Structure

- `main.tf` - Main Terraform configuration with resource definitions
- `variables.tf` - Variable declarations
- `outputs.tf` - Output values
- `terraform.tfvars.example` - Example variables file
- `README.md` - This documentation

## Resources Created

- **Resource Group**: Container for all resources
- **Virtual Network**: Network infrastructure with 10.0.0.0/16 address space
- **Subnet**: Internal subnet with 10.0.2.0/24 address space

## Cleanup

To destroy the created resources:
```bash
terraform destroy
```

## Customization

You can extend this project by:
- Adding virtual machines
- Creating storage accounts
- Setting up network security groups
- Adding load balancers
- Implementing Azure Key Vault

## Best Practices

1. Always run `terraform plan` before `terraform apply`
2. Use version control for your Terraform files
3. Store state files securely (consider using Azure Storage backend)
4. Use consistent naming conventions
5. Tag all resources appropriately

## Troubleshooting

- **Authentication issues**: Ensure you're logged into Azure CLI
- **Permission errors**: Verify you have contributor access to the subscription
- **Resource conflicts**: Check if resource names already exist in Azure
