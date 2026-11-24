output "vpc_id" {
  description = "ID of the VPC."
  value       = aws_vpc.this.id
}

output "subnet_1_id" {
  description = "ID of the first subnet. The EC2 instance runs here."
  value       = aws_subnet.subnet_1.id
}

output "subnet_2_id" {
  description = "ID of the second subnet."
  value       = aws_subnet.subnet_2.id
}

output "sg_ec2_id" {
  description = "ID of the security group for the EC2 instance."
  value       = aws_security_group.ec2.id
}

output "sg_postgres_id" {
  description = "ID of the security group for the PostgreSQL instance."
  value       = aws_security_group.postgres.id
}

output "db_subnet_group_name" {
  description = "Name of the RDS subnet group."
  value       = aws_db_subnet_group.this.name
}
