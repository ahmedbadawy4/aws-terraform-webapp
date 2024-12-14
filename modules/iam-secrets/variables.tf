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
