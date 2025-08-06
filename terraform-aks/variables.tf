variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "rg-genai-project"
}

variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "Southeast Asia"
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "genai-project"
}

variable "tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default = {
    Environment = "dev"
    Project     = "GenAI-AKS"
    Owner       = "DevOps-Team"
    CostCenter  = "IT"
  }
}

variable "kubernetes_version" {
  description = "Kubernetes version for AKS cluster"
  type        = string
  default     = "1.28.9"
}

variable "node_count" {
  description = "Initial number of nodes in the default node pool"
  type        = number
  default     = 2
}

variable "node_vm_size" {
  description = "VM size for AKS nodes"
  type        = string
  default     = "Standard_D2s_v3"
}

# Network Configuration Variables
variable "vnet_address_space" {
  description = "Address space for the virtual network"
  type        = list(string)
  default     = ["10.1.0.0/16"]
}

variable "subnet_address_prefixes" {
  description = "Address prefixes for the AKS nodes subnet"
  type        = list(string)
  default     = ["10.1.1.0/24"]
}

variable "vnet_name" {
  description = "Name of the virtual network (will be prefixed with project name)"
  type        = string
  default     = "aks-vnet"
}

variable "subnet_name" {
  description = "Name of the subnet for AKS nodes"
  type        = string
  default     = "aks-nodes-subnet"
}
