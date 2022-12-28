resource "helm_release" "db" {
  name       = "hmz-db"

  repository = "https://charts.bitnami.com/bitnami"
  chart      = "postgresql"
  namespace  = var.namespace
  create_namespace = true

  set {
    name  = "service.type"
    value = "ClusterIP"
  }
}

data "kubernetes_secret" "db_password" {
  metadata {
    name = "${resource.helm_release.db.name}-postgresql"
    namespace  = var.namespace
  }
}

locals{
  db_password = data.kubernetes_secret.db_password.data.postgres-password
}

# output "db_password" {
#   value = nonsensitive(local.db_password)
# }