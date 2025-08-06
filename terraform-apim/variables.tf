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
    Project     = "GenAI-APIM"
    Owner       = "DevOps-Team"
    CostCenter  = "IT"
  }
}

variable "publisher_name" {
  description = "Publisher name for API Management"
  type        = string
  default     = "GenAI Team"
}

variable "publisher_email" {
  description = "Publisher email for API Management"
  type        = string
  default     = "admin@company.com"
}

variable "apim_sku" {
  description = "SKU for API Management"
  type        = string
  default     = "Developer_1"
  validation {
    condition = contains([
      "Developer_1",
      "Basic_1", "Basic_2",
      "Standard_1", "Standard_2",
      "Premium_1", "Premium_2", "Premium_4", "Premium_8"
    ], var.apim_sku)
    error_message = "The apim_sku must be a valid API Management SKU."
  }
}

# Network Configuration Variables
variable "vnet_address_space" {
  description = "Address space for the virtual network"
  type        = list(string)
  default     = ["10.2.0.0/16"]
}

variable "subnet_address_prefixes" {
  description = "Address prefixes for the APIM subnet"
  type        = list(string)
  default     = ["10.2.1.0/24"]
}

variable "vnet_name" {
  description = "Name of the virtual network (will be prefixed with project name)"
  type        = string
  default     = "apim-vnet"
}

variable "subnet_name" {
  description = "Name of the subnet for APIM"
  type        = string
  default     = "apim-subnet"
}
