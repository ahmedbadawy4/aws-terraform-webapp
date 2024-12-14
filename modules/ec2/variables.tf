variable "aws_region" {
  description = "aws region"
  type        = string
  default     = "us-east-1"
}
variable "instance_type" {
  description = "instance_type"
  type        = string
  default     = "t2.micro"
}

variable "aws_keypair_name" {
  description = "aws keypair pre-defined in aws"
  type        = string
}

variable "ec2_volume_size" {
  description = "root volume size"
  type        = number
  default     = 20
}

variable "aws_subnet" {
  description = "subnet id"
  type        = string
}

variable "ec2_sg" {
  description = "security group ID"
  type        = string
}

variable "application" {
  description = "application name"
  type        = string
}

variable "environment" {
  description = "environment name"
  type        = string
}
