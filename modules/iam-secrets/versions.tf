provider "aws" {
  region = var.aws_region
}

terraform {
  backend "s3" {}
  required_version = "~> 1.3"
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 2.3"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
