resource "kubernetes_namespace_v1" "harmonize" {
  metadata {
    name = var.namespace
  }
}
