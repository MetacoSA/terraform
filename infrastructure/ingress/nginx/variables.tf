variable "namespace" {
  type = string
  description = "Namespace to be used to deploy the nginx ingress controller"
}

variable "kube_config_file" {
  type = string
  description = "Fully qualified path to kubeconfig file. This will be used by helm for chart deployment"
}
