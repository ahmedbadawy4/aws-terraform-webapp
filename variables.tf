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

variable "destination_cidr_block" {
  description = "CIDR block for the route"
  type        = string
}

variable "aws_keypair_name" {
  description = "aws keypair pre-defined in aws"
  type        = string
}
