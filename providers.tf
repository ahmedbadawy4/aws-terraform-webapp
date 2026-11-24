provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Application = var.application
      Environment = var.environment
      ManagedBy   = "terraform"
    }
  }
}
