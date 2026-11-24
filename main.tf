locals {
  key_pair_name = coalesce(var.key_pair_name, "${var.environment}-${var.application}")
}

module "vpc" {
  source              = "./modules/vpc"
  environment         = var.environment
  application         = var.application
  allowed_cidr_blocks = var.allowed_cidr_blocks
}

module "rds" {
  source               = "./modules/rds"
  environment          = var.environment
  application          = var.application
  instance_class       = var.db_instance_class
  db_subnet_group_name = module.vpc.db_subnet_group_name
  db_sg_id             = module.vpc.sg_postgres_id
  kms_key_arn          = module.iam_secrets.kms_key_arn
}

# The key and the instance role live here. The role may read the database secret,
# which RDS creates, so this module takes the secret ARN from the rds module.
module "iam_secrets" {
  source        = "./modules/iam-secrets"
  environment   = var.environment
  application   = var.application
  db_secret_arn = module.rds.db_master_user_secret_arn
}

module "ec2_key" {
  source   = "./modules/ec2-key"
  key_name = local.key_pair_name
}

module "ec2" {
  source               = "./modules/ec2"
  environment          = var.environment
  application          = var.application
  instance_type        = var.instance_type
  subnet_id            = module.vpc.subnet_1_id
  key_pair_name        = module.ec2_key.key_name
  security_group_id    = module.vpc.sg_ec2_id
  iam_instance_profile = module.iam_secrets.instance_profile_name
}
