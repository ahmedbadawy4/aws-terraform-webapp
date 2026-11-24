output "ec2_public_ip" {
  description = "Public IP address of the EC2 instance."
  value       = module.ec2.ec2_public_ip
}

output "ssh_private_key_path" {
  description = "Path of the private key file that Terraform wrote for the instance."
  value       = module.ec2_key.private_key_path
}

output "db_host" {
  description = "Address of the PostgreSQL instance."
  value       = module.rds.db_instance_address
}

output "db_name" {
  description = "Name of the database."
  value       = module.rds.db_name
}

output "db_username" {
  description = "Master user name of the database."
  value       = module.rds.db_username
}

output "db_master_user_secret_arn" {
  description = "ARN of the Secrets Manager secret that holds the master password."
  value       = module.rds.db_master_user_secret_arn
}
