resource "aws_db_instance" "default" {
  identifier                    = local.identifier
  allocated_storage             = var.allocated_storage
  engine                        = var.engine
  engine_version                = var.engine_version[var.engine]
  instance_class                = var.instance_class
  db_name                       = "${local.identifier}-db"
  username                      = var.db_username
  manage_master_user_password   = true
  master_user_secret_kms_key_id = var.kms_key_id
  vpc_security_group_ids        = [var.db_sg_id]
  db_subnet_group_name          = var.db_subnet_id
  skip_final_snapshot           = "true" # disable create snapshot when deleting RDS for cost saving.
}
