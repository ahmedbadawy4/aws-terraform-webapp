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

variable "allocated_storage" {
  description = "Allocated storage size in GB"
  type        = number
  default     = 20
}

variable "engine" {
  description = "Engine type"
  type        = string
  default     = "postgres"
}

variable "engine_version" {
  description = "Engine version"
  type        = map(string)
  default = {
    postgres = "17.2"
  }
}

variable "instance_class" {
  description = "Instance class"
  type        = string
  default     = "db.t2.micro"
}

variable "db_username" {
  description = "Database username"
  type        = string
  default     = "gfguser"
}

variable "db_sg_id" {
  description = "Postgres security group ID"
  type        = string
}

variable "db_subnet_id" {
  description = "Postgres subnet group ID"
  type        = string
}

variable "kms_key_id" {
  description = "KMS key ID for database master user password"
  type        = string
}
