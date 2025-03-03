module "vpc" {
  source                 = "./modules/vpc"
  environment            = var.environment
  application            = var.application
  destination_cidr_block = var.destination_cidr_block
}

module "rds" {
  source       = "./modules/rds"
  environment  = var.environment
  application  = var.application
  db_subnet_id = module.vpc.default_subnet_group_id
  db_sg_id     = module.vpc.sg_postgres_id
  kms_key_id   = module.iam-secrets.kms_key_id

}

module "ec2_key" {
  source     = "./modules/ec2-key/"
  aws_region = var.aws_region
  key_name   = var.aws_keypair_name
}

resource "aws_key_pair" "generated_key" {
  key_name   = "generated-key"
  public_key = module.ec2_key.public_key_value
}

module "ec2" {
  source           = "./modules/ec2/"
  environment      = var.environment
  application      = var.application
  aws_subnet       = module.vpc.main_subnet_id
  aws_keypair_name = aws_key_pair.generated_key.key_name
  ec2_sg           = module.vpc.sg_ec2_id

}

module "iam-secrets" {
  source      = "./modules/iam-secrets/"
  environment = var.environment
  application = var.application

}
