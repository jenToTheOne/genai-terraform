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
    Project     = "GenAI-Infrastructure"
    Owner       = "DevOps-Team"
    CostCenter  = "IT"
  }
}
