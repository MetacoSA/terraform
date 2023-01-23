terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
  }
}

provider "helm" {
  # Configuration options
  kubernetes {
    config_path = var.kube_config_file
  }
}

provider "kubernetes" {
    # Configuration options
    config_path = var.kube_config_file
}
