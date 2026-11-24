terraform {
  required_version = ">= 1.10"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  # Bucket, key and region are passed when you run terraform init, see the README.
  backend "s3" {
    encrypt      = true
    use_lockfile = true
  }
}
