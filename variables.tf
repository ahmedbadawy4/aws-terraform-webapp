variable "aws_region" {
  description = "AWS region for all resources."
  type        = string
  default     = "us-east-1"
}

variable "application" {
  description = "Application name. Lowercase letters, digits and single hyphens. It becomes part of every resource name."
  type        = string

  validation {
    condition     = length(var.application) <= 21 && can(regex("^[a-z][a-z0-9]*(-[a-z0-9]+)*$", var.application))
    error_message = "Use up to 21 characters: start with a lowercase letter, then lowercase letters, digits or single hyphens, and do not end with a hyphen."
  }
}

variable "environment" {
  description = "Environment name, for example dev or prod. Lowercase letters, digits and single hyphens."
  type        = string

  validation {
    condition     = length(var.environment) <= 21 && can(regex("^[a-z][a-z0-9]*(-[a-z0-9]+)*$", var.environment))
    error_message = "Use up to 21 characters: start with a lowercase letter, then lowercase letters, digits or single hyphens, and do not end with a hyphen."
  }
}

variable "allowed_cidr_blocks" {
  description = "CIDR blocks that may reach the instance on ports 22 and 80, for example your own public address as 203.0.113.10/32. The default is empty, so nothing outside the VPC can connect."
  type        = list(string)
  default     = []
}

variable "key_pair_name" {
  description = "Name of the EC2 key pair that Terraform creates. Defaults to <environment>-<application>."
  type        = string
  default     = null
}

variable "instance_type" {
  description = "EC2 instance type. It must be an x86_64 type."
  type        = string
  default     = "t3.micro"
}

variable "db_instance_class" {
  description = "RDS instance class."
  type        = string
  default     = "db.t3.micro"
}
