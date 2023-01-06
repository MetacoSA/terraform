variable "namespace" {
  type        = string
  description = "Namespace to deploy"
  default = "hmz-terraform"
}

variable "endpoints" {
  type        = object({
    frontend = string
    api      = string
    auth     = string
  })
  description = "Namespace to deploy"
}

variable "registry_server" {
  type        = string
  description = "Registry server used to pull Metaco SW"
  default     = "metaco.azurecr.io"
}

variable "registry_id" {
  type        = string
  description = "Client ID used to pull Metaco SW"
}

variable "registry_password" {
  type        = string
  description = "Client password used to pull Metaco SW"
}

variable "registry_email" {
  type        = string
  description = "Client email used to pull Metaco SW"
  default    = "fake@email.com"
}

variable "use_tls" {
  type        = bool
  description = "Deploy harmonize with TLS"
  default    = true
}

variable "notary_protocol" {
  type        = string
  description = "Protocol used by the Notary"
  default    = "grpc"
  validation {
    condition = contains(["http", "grpc"], var.notary_protocol)
    error_message = "Valid value is one of the following: http, grpc."
  }
}

variable "harmonize_helm_templates" {
  type        = list(
    object({
      path = string
      vars = map(string)
    })
  )
  description = "host for installed Harmonize instance"
}