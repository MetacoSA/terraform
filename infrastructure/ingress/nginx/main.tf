terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
  }
}

# Provider configurations are inherited from the calling(root) module
# If running this modue as stand-alone, un-comment below lines.
/*
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
*/
