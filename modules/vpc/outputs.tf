output "main_subnet_id" {
  value       = aws_subnet.subnet_1.id
  description = "main subnet 1 id"
}

output "sg_ec2_id" {
  value = aws_security_group.ec2.id
}

output "sg_postgres_id" {
  value = aws_security_group.postgres.id
}

output "default_subnet_group_id" {
  value = aws_db_subnet_group.default.id
}
output "subnet_1_id" {
  value = aws_subnet.subnet_1.id
}

output "subnet_2_id" {
  value = aws_subnet.subnet_2.id
}
