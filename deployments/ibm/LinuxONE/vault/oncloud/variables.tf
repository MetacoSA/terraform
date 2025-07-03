variable "prefix" {
  type        = string
  description = "Prefix to be attached to name of all generated resources"
}

variable "region" {
  type        = string
  description = "Region to deploy to, e.g. eu-gb. Please consult IBM cloud document for latest information"
  validation {
    condition     = contains(["eu-gb", "br-sao",  "ca-tor", "jp-tok", "us-east"], var.region)
    error_message = "Value of region must be one of eu-gb/br-sao/ca-tor/jp-tok/us-east."
  }
}

variable "zone" {
  type        = string
  default     = "2"
  description = "Zone to deploy to, e.g. 2. Please consult IBM cloud document for latest information"
  validation {
    condition     = contains(["1", "2", "3"], var.zone)
    error_message = "Value of zone must be one of 1/2/3. Please consult IBM cloud document for latest information"
  }
}

variable "profile" {
  type        = string
  default     = "bz2e-1x4"
  description = <<-DESC
                  Profile used for instantiating the virtual server instance.
                  This has to be a secure execution profile in the format Xz2e-YxZ, e.g. bz2e-1x4
                  Please consult IBM cloud document for latest information
                DESC
}

variable "ibmcloud_api_key" {
  type       = string
  sensitive  = true
  description = <<-DESC
                  ApiKey used to login to IBM cloud to perform the operations
                  Reference: https://cloud.ibm.com/docs/account?topic=account-userapikey&interface=ui#create_user_key
                DESC
}

variable "resource_group" {
  type        = string
  description = "Resource group under which the instances will be created"
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
  sensitive   = true
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
                  xyz.icr.io/abcd/vault-releases
                DESC
}

variable "vault_container_image_sha256" {
  type        = string
  description = "sha256 of the vault container image"
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

variable "harmonize_api_endpoint" {
  type        = string
  description = "API endpoint of the Harmonize Core that this vault needs to connect to"
}

variable "notary_messaging_public_key" {
  type        = string
  sensitive   = true
  description = "Notary messaging public key obtained after genesis operation"
}

variable "crypto_server_type" {
   type        = string
   description = "Whether the crypto service is on premise grep11 or cloud hpcs"
   validation {
     condition = contains(["grep11", "hpcs"], var.crypto_server_type)
     error_message = "crypto server must either be grep11 or hpcs"
  }
}

variable "vault_uuid" {
  type        = string
  description = "UUID to be associated with the Vault instance"
}
