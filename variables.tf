# Required

variable "project_name" {
  type        = string
  description = "Name prefix for all resources."

  validation {
    condition     = length(var.project_name) <= 16
    error_message = "Must be 16 characters or fewer."
  }
}

variable "vpc_name" {
  type        = string
  description = "Name tag of the existing VPC to deploy into."
}

variable "aws_ami" {
  type = object({
    owner = string
    name  = string
  })
  description = "AMI owner and name filter for the HCP Terraform agent instances."
}

# Optional

variable "common_tags" {
  type        = map(string)
  description = "Tags to apply to all resources."
  default     = {}
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type for HCP Terraform agent nodes."
  default     = "t3.medium"
}

variable "tfc_agent_token" {
  type        = string
  description = "HCP Terraform agent token."
  sensitive   = true
}

variable "tfc_agent_version" {
  type        = string
  description = "Version of the HCP Terraform agent to install."
  default     = "1.28.7"

  validation {
    condition     = can(regex("^\\d+\\.\\d+\\.\\d+$", var.tfc_agent_version))
    error_message = "Must be a valid semver version (e.g., 1.28.7)."
  }
}

variable "agent_count" {
  type        = number
  description = "Desired number of HCP Terraform agent instances."
  default     = 2

  validation {
    condition     = var.agent_count >= 1
    error_message = "Must be at least 1."
  }
}
