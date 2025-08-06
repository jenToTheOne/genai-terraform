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
    Project     = "GenAI-AppGW"
    Owner       = "DevOps-Team"
    CostCenter  = "IT"
  }
}

variable "appgw_sku_name" {
  description = "SKU name for Application Gateway"
  type        = string
  default     = "Standard_v2"
}

variable "appgw_sku_tier" {
  description = "SKU tier for Application Gateway"
  type        = string
  default     = "Standard_v2"
}

variable "appgw_capacity" {
  description = "Capacity for Application Gateway"
  type        = number
  default     = 2
}

# Network Configuration Variables
variable "vnet_address_space" {
  description = "Address space for the virtual network"
  type        = list(string)
  default     = ["10.3.0.0/16"]
}

variable "subnet_address_prefixes" {
  description = "Address prefixes for the Application Gateway subnet"
  type        = list(string)
  default     = ["10.3.1.0/24"]
}

variable "vnet_name" {
  description = "Name of the virtual network (will be prefixed with project name)"
  type        = string
  default     = "appgw-vnet"
}

variable "subnet_name" {
  description = "Name of the subnet for Application Gateway"
  type        = string
  default     = "appgw-subnet"
}
