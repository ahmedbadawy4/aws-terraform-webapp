output "ec2role_name" {
  value = aws_iam_role.this.name
}

output "kms_key_id" {
  value = aws_kms_key.this.id
}
