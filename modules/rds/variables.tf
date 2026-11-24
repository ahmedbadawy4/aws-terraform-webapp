variable "environment" {
  description = "Environment name, for example dev or prod."
  type        = string
}

variable "application" {
  description = "Application name."
  type        = string
}

variable "db_subnet_group_name" {
  description = "Name of the DB subnet group the instance is placed in."
  type        = string
}

variable "db_sg_id" {
  description = "ID of the security group attached to the database."
  type        = string
}

variable "kms_key_arn" {
  description = "ARN of the KMS key that encrypts the storage and the master password secret."
  type        = string
}

variable "engine_version" {
  description = "PostgreSQL version. A major version such as 17 lets RDS pick the current minor version."
  type        = string
  default     = "17"
}

variable "instance_class" {
  description = "RDS instance class."
  type        = string
  default     = "db.t3.micro"
}

variable "allocated_storage" {
  description = "Storage size in GiB. gp3 storage needs at least 20."
  type        = number
  default     = 20
}

variable "db_username" {
  description = "Master user name. RDS generates the password and keeps it in Secrets Manager."
  type        = string
  default     = "appadmin"
}

variable "multi_az" {
  description = "Run a standby instance in a second availability zone."
  type        = bool
  default     = false
}

variable "backup_retention_period" {
  description = "Days to keep automated backups. 0 turns backups off."
  type        = number
  default     = 7
}

variable "deletion_protection" {
  description = "Block deletion of the database. Turn it on before real data is stored."
  type        = bool
  default     = false
}

variable "skip_final_snapshot" {
  description = "Skip the final snapshot when the database is destroyed. Set to false to keep one."
  type        = bool
  default     = true
}
