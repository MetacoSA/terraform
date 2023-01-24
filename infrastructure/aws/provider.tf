terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
  }
}

provider "kubernetes" {
    # Configuration options
    config_path = var.kube_config_file
}

# This is needed by nginx, but then it has to be defined here as nginx is being used 
# as a terraform module
provider "helm" {
  # Configuration options
  kubernetes {
    config_path = var.kube_config_file
  }
}

# Configure AWS provider mapping to the region. This is needede by child modules.
# However, they need to be defined here since others are being used as terraform modules
provider "aws" {
  region     = var.aws_region
  access_key = var.aws_iam_access_key_id
  secret_key = var.aws_iam_secret_access_key
}
