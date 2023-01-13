terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
  }
}

# This installs the nginx ingress controller on the k8s cluster that is pointed to by kube config
resource "helm_release" "nginx_ingress" {
    depends_on = [kubernetes_namespace_v1.harmonize]
    name      = "nginx-ingress"
    repository = "https://helm.nginx.com/stable"
    chart     = "nginx-ingress"
    namespace = var.namespace
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
