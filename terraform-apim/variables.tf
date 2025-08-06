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
    Project     = "OCBC-GenAI-APIM"
    Owner       = "OCBC"
    CostCenter  = "IT"
  }
}

variable "publisher_name" {
  description = "Publisher name for API Management"
  type        = string
  default     = "OCBC GenAI Team"
}

variable "publisher_email" {
  description = "Publisher email for API Management"
  type        = string
  default     = "admin@ocbc.com"
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
