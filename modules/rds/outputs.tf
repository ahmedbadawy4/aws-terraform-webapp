output "db_instance_id" {
  description = "Identifier of the RDS instance."
  value       = aws_db_instance.this.id
}

output "db_instance_address" {
  description = "DNS address of the PostgreSQL instance."
  value       = aws_db_instance.this.address
}

output "db_name" {
  description = "Name of the database."
  value       = aws_db_instance.this.db_name
}

output "db_username" {
  description = "Master user name."
  value       = aws_db_instance.this.username
}

output "db_master_user_secret_arn" {
  description = "ARN of the Secrets Manager secret that holds the master password."
  value       = aws_db_instance.this.master_user_secret[0].secret_arn
}
