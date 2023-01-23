terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.50.0"
    }
  }
}

# Configure AWS provider mapping to the region
provider "aws" {
  region     = var.aws_region
  access_key = var.aws_iam_access_key_id
  secret_key = var.aws_iam_secret_access_key
}
