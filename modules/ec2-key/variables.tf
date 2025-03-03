variable "aws_region" {
  description = "aws region"
  type        = string
  default     = "us-east-1"
}

variable "key_name" {
  description = "The name of the key pair"
  type        = string
  default     = "ec2-key"
}
