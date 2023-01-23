# This installs the nginx ingress controller on the k8s cluster that is pointed to by kube config
resource "helm_release" "nginx_ingress" {
    depends_on = [data.kubernetes_namespace_v1.nginx_namespace]
    name      = "nginx-ingress"
    repository = "https://helm.nginx.com/stable"
    chart     = "nginx-ingress"
    namespace = var.namespace
}
