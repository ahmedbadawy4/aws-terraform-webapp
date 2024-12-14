variable "aws_region" {
  description = "aws region"
  type        = string
  default     = "us-east-1"
}

variable "application" {
  description = "application name"
  type        = string
}

variable "environment" {
  description = "environment name"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_1_cidr" {
  description = "Subnet for the first Availability Zone"
  type        = string
  default     = "10.0.1.0/24"
}

variable "subnet_2_cidr" {
  description = "Subnet for the second Availability Zone"
  type        = string
  default     = "10.0.2.0/24"
}

variable "az_1" {
  description = "First Availability Zone"
  type        = string
  default     = "us-east-1a"
}

variable "az_2" {
  description = "Second Availability Zone"
  type        = string
  default     = "us-east-1b"
}

variable "destination_cidr_block" {
  description = "CIDR block for the route"
  type        = string
}
