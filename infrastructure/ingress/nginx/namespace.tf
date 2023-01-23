# Namespace to which the controller needs to be installed.
data "kubernetes_namespace_v1" "nginx_namespace" {
  metadata {
    name = var.namespace
  }
}
