variable "environment" {
  description = "Environment name, for example dev or prod."
  type        = string
}

variable "application" {
  description = "Application name."
  type        = string
}

variable "db_secret_arn" {
  description = "ARN of the Secrets Manager secret that holds the database master password."
  type        = string
}
