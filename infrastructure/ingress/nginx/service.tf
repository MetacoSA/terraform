# After deploying nginx ingress chart, a service also get deployed
# exporting either a hostname(example: AWS) or IP address(Azure)
data "kubernetes_service_v1" "nginx_service" {
  metadata {
    name = format("%s-%s", helm_release.nginx_ingress.name,
                           helm_release.nginx_ingress.chart)
    namespace = helm_release.nginx_ingress.namespace
  }
  depends_on = [helm_release.nginx_ingress]
}

output "ingress_ctrl_hostname" {
  value       = data.kubernetes_service_v1.nginx_service.status.0.load_balancer.0.ingress.0.hostname
  description = "hostname associated with the kubernetes service. It can be empty"
}

output "ingress_ctrl_ip_address" {
  value       = data.kubernetes_service_v1.nginx_service.status.0.load_balancer.0.ingress.0.ip
  description = "IP address associated with the kubernetes service. It can be empty"
}
