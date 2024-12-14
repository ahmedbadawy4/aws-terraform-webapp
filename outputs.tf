output "Ec2_public_ip" {
  value = module.ec2.ec2_public_ip
}

output "db_host" {
  value = module.rds.db_instance_address
}
