variable "environment" {
  description = "Environment name, for example dev or prod."
  type        = string
}

variable "application" {
  description = "Application name."
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block of the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_1_cidr" {
  description = "CIDR block of the first subnet. It is created in the first availability zone."
  type        = string
  default     = "10.0.1.0/24"
}

variable "subnet_2_cidr" {
  description = "CIDR block of the second subnet. It is created in the second availability zone."
  type        = string
  default     = "10.0.2.0/24"
}

variable "allowed_cidr_blocks" {
  description = "CIDR blocks that may reach the EC2 instance on ports 22 and 80. Empty means no access from outside the VPC."
  type        = list(string)
  default     = []

  validation {
    condition     = alltrue([for cidr in var.allowed_cidr_blocks : can(cidrhost(cidr, 0))])
    error_message = "Every entry must be a valid IPv4 CIDR block, for example 203.0.113.10/32."
  }
}
