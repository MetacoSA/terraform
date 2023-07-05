variable "hpvs_contract_encryption_key" {
  type        = string
  description =  <<DESC
                   Absolute path to the Hyper Protect Container Runtime encryption key 
                   downloaded from IBM. This will be used to encrypt the contract
                 DESC
}

variable "logging_type" {
  type        = string
  description = "Logging solution to which the Vault has to send the logs to"
  validation {
       condition  = ( var.logging_type == "logdna" ||
                      var.logging_type == "syslog" )
       error_message = "logging_type must be either syslog or logdna"
  }
}

variable "logdna_ingestion_key" {
  type        = string
  sensitive   = true
  default     = ""
  description = <<-DESC
                  Ingestion key for IBM Log Analysis instance. This can be 
                  obtained from "Linux/Ubuntu" section of "Logging resource" 
                  tab of IBM Log Analysis instance
                DESC
}

variable "logdna_log_endpoint" {
  type        = string
  default     = ""
  description = <<-DESC
                  rsyslog endpoint of IBM Log Analysis instance. 
                  Don't include the port. Example: 
                  syslog-a.<log_region>.logging.cloud.ibm.com
                  log_region is the region where IBM Log Analysis is deployed
                DESC
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

variable "container_image_repository" {
  type        = string
  description = <<DESC
                  Path of the repository having the image. Example:
                  abcd/vault-releases
                DESC
}

variable "container_image_sha256" {
  type        = string
  description = "sha256 of the image"
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

variable "crypto_server_ep11_host" {
  type        = string
  sensitive   = true
  description = <<DESC
                  For on-premise, it's GREP11 server IP / hostname.
                  For cloud, it's HPCS EP11 endpoint
                DESC
}

variable "crypto_server_ep11_port" {
  type        = string
  default     = "9876"
  sensitive   = true
  description = <<DESC
                  For on-premise, it's GREP11 server port.
                  For cloud, it's HPCS EP11 port
                DESC
}

variable "crypto_server_instance_id" {
  type        = string
  sensitive   = true
  default     = ""
  description = "Instance id of HPCS instance. Applicable ONLY for ibmcloud"
}

variable "crypto_server_access_api_key" {
  type        = string
  sensitive   = true
  default     = ""
  description = "Access key(apikey) to be used to communicate with HPCS. Applicable ONLY for ibmcloud"
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
