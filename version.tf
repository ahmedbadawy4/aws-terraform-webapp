provider "aws" {
  region = var.aws_region
}

terraform {
  backend "s3" {
    bucket         = "s3-bucket-name"
    key            = "path/to/your/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "lock-table"
    encrypt        = true
  }
  required_version = "~> 1.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
