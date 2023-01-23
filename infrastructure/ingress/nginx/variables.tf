variable "namespace" {
  type        = string
  description = <<DESC
                  Namespace to be used to deploy the nginx ingress controller
                  The namespace should have been created before executing this
                DESC
}

variable "kube_config_file" {
  type        = string
  default     = "~/.kube/config"
  description = "Fully qualified path to kubeconfig file. This will be used by helm for chart deployment"
}
