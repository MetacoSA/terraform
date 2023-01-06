resource "kubernetes_secret" "repository_secret" {
  metadata {
    name = "metaco-registry"
    namespace  = var.namespace
  }
  depends_on = [resource.kubernetes_namespace_v1.harmonize]

  type = "kubernetes.io/dockerconfigjson"

  data = {
    ".dockerconfigjson" = jsonencode({
      auths = {
        "${var.registry_server}" = {
          "username" = var.registry_id
          "password" = var.registry_password
          "email"    = var.registry_email
          "auth"     = base64encode("${var.registry_id}:${var.registry_password}")
        }
      }
    })
  }
}

resource "random_string" "clientSecret" {
  length           = 16
  special          = true
}

resource "helm_release" "harmonize" {
  name       = "hmz"

  #repository = "https://charts.bitnami.com/bitnami"
  chart      = "../harmonize-helm/harmonize"
  namespace  = var.namespace
  depends_on = [resource.kubernetes_namespace_v1.harmonize]

  values = [
    for template in var.harmonize_helm_templates: templatefile(
      template.path, 
      merge(
        {
          db_password  = local.db_password
          clientSecret = resource.random_string.clientSecret.result
          harmonize_host = var.endpoints.frontend
          harmonize_frontend = var.endpoints.frontend
          harmonize_api = var.endpoints.api
          harmonize_auth = var.endpoints.auth
          harmonize_use_tls = var.use_tls
          harmonize_notary_protocol = var.notary_protocol
        },
        template.vars
      )
    )
  ]
}

output "BEARER_TOKEN" {
  value="$(curl --location --request POST http://${var.endpoints.auth}/token --header 'Content-Type: application/x-www-form-urlencoded' --data-urlencode 'grant_type=client_credentials' --data-urlencode 'client_id=${var.harmonize_helm_templates[0].vars.clientId}' --data-urlencode 'client_secret=${resource.random_string.clientSecret.result}' | jq -r '.access_token')"
}