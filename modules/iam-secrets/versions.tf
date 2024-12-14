provider "aws" {
  region = var.aws_region
}

terraform {
  required_version = "~> 1.3"
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
