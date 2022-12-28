

terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.16.1"
    }
    helm = {
      source = "hashicorp/helm"
      version = "2.8.0"
    }
    random = {
      source = "hashicorp/random"
      version = "3.4.3"
    }
  }
}

provider "helm" {
  # Configuration options
  kubernetes {
    config_path = "~/.kube/config"
  }
}

provider "kubernetes" {
  # Configuration options
  config_path = "~/.kube/config"
}