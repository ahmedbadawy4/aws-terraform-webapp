output "private_key_path" {
  description = "Path to the private SSH key"
  value       = local_file.private_key.filename
}

output "public_key_path" {
  value = local_file.public_key.filename
}

output "public_key_value" {
  description = "Public SSH Key Value"
  value       = tls_private_key.ec2_key.public_key_openssh
}
