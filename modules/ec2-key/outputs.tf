output "key_name" {
  description = "Name of the EC2 key pair."
  value       = aws_key_pair.this.key_name
}

output "private_key_path" {
  description = "Path of the private key file."
  value       = local_sensitive_file.private_key.filename
}
