variable "hpvs_contract_encryption_cert" {
  type        = string
  description =  <<DESC
                   Contents of Contract encryption certificate downloaded from IBM.
                   This will be used to encrypt the contract
                 DESC
}

variable "logging_type" {
  type        = string
  description = "Logging solution to which the Notary has to send the logs to"
  validation {
    condition  = contains(["cloudlogs", "syslog"], var.logging_type)
    error_message = "logging_type must be either syslog or cloudlogs"
  }
}

variable "cloudlogs_api_key" {
  type        = string
  default     = ""
  sensitive   = true
  description = "API key used to access IBM Cloud Logs"
}

variable "cloudlogs_ingestion_endpoint" {
  type        = string
  default     = ""
  description = "Cloud Logs ingestion endpoint. Found under 'Endpoints' section"
}

variable "syslog_server_hostname" {
  type        = string
  default     = ""
  description = "syslog server hostname"
}

variable "syslog_server_port" {
  type        = number
  default     = 0
  description = "syslog server port"
}

variable "syslog_server_ca_cert_file" {
  type        = string
  default     = "/dev/null"
  description = "CA certificate that will be used while establishing a TLS session with syslog server"
}

variable "container_registry" {
  type        = string
  description = "Container registry to be used. Example: de.icr.io"
}

variable "container_registry_user_id" {
  type        = string
  sensitive   = true
  description = <<DESC
                  User ID to be used to login to the container registry that is hosting the image
                  Example: If the image is on IBM cloud and you want to use API key, then the
                  value is: iamapikey
                DESC
}

variable "container_registry_password" {
  type        = string
  sensitive   = true
  description = <<DESC
                  Password to be used to login to the container registry that is hosting the image
                  Example: If the image is on IBM cloud and you want to use API key, then the
                  password is the value of API Key
                DESC
}

variable "vault_container_image_repository" {
  type        = string
  description = <<DESC
                  Path of the repository having the image. Example:
                  abcd/vault-releases
                DESC
}

variable "vault_container_image_sha256" {
  type        = string
  description = "sha256 of the vault image"
}

variable "kmsconnect_container_image_repository" {
  type        = string
  description = <<DESC
                  Path of the repository having the image. Example:
                  xyz.icr.io/abcd/kms-ibm
                DESC
}

variable "kmsconnect_container_image_sha256" {
  type        = string
  description = "sha256 of the kmsconnect container image"
}

variable "notary_messaging_public_key" {
  type        = string
  sensitive   = true
  description = "Notary messaging public key obtained after genesis operation"
}

variable "harmonize_api_endpoint" {
  type        = string
  description = "Endpoint of the harmonize api service"
}

variable "crypto_server_type" {
   type        = string
   description = "Whether the crypto service is on premise grep11 or cloud hpcs"
   validation {
       condition  = ( var.crypto_server_type == "grep11" ||
                      var.crypto_server_type == "hpcs" )
       error_message = "crypto server must either be grep11 or hpcs"
  }
}

variable "vault_uuid" {
  type        = string
  description = "UUID to be associated with the Vault instance"
}
