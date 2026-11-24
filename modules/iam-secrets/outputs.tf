output "kms_key_id" {
  description = "ID of the KMS key."
  value       = aws_kms_key.this.key_id
}

output "kms_key_arn" {
  description = "ARN of the KMS key."
  value       = aws_kms_key.this.arn
}

output "role_name" {
  description = "Name of the IAM role for the EC2 instance."
  value       = aws_iam_role.ec2.name
}

output "instance_profile_name" {
  description = "Name of the instance profile to attach to the EC2 instance."
  value       = aws_iam_instance_profile.this.name
}
