variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "rg-ocbc-genai"
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
  default     = "ocbc-genai"
}

variable "tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default = {
    Environment = "dev"
    Project     = "OCBC-GenAI-AppGW"
    Owner       = "OCBC"
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
