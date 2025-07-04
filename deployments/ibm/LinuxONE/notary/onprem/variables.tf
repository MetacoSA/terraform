variable "prefix" {
  type        = string
  description = "Prefix to be attached to name of all generated resources"
}

variable "libvirt_host" {
  type        = string
  description = "IP address or hostname of the libvirt host machine"
}

variable "libvirt_user" {
  type        = string
  description = "User name authorized by a SSH server in the libvirt host"
}

variable "hpvs_qcow2_image" {
  type        = string
  description = "Path to the Hyper Protect Container Runtime image downloaded from IBM"
}

variable "hpvs_contract_encryption_cert" {
  type        = string
  description =  <<DESC
                   Path to the Hyper Protect Container Runtime encryption certificate
                   downloaded from IBM. This will be used to encrypt the contract
                 DESC
}

variable "storage_pool_name" {
  type        = string
  description = "Name of the libvirt storage pool on the host"
}

variable "data_volume_size" {
   type    = number
   description = "Size of the data volume to be attached. Must be greater than 10GB"
   validation {
     condition  = ( var.data_volume_size > 10737418240 )
     error_message = "Data volume size must be greater than 10GB"
  }
}
      
variable "volume_encryption_seed_phrase_workload" {
  type        = string
  sensitive   = true
  description = "volume encryption seed phrase that is part of workload section"
}

variable "volume_encryption_seed_phrase_user" {
  type        = string
  sensitive   = true
  description = "volume encryption seed phrase that is part of env section"
}

variable "vsi_hostname" {
  type        = string
  description = "Hostname to be given to the created virtual machine."
}

variable "memory_in_mbs" {
  type        = string
  default     = 8192
  description = "Memory(in MBs) to be assigned to the VSI"
}

variable "num_vcpu" {
  type        = string
  default     = 2
  description = "Number of vCPUs to be assigned to the VSI"
}

variable "logging_type" {
  type        = string
  description = "Logging solution to which the Vault has to send the logs to"
  validation {
       condition  = ( var.logging_type == "cloudlogs" ||
                      var.logging_type == "syslog" )
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

variable "ssh_private_key_path" {
  type        = string
  default     = "~/.ssh/id_rsa"
  description = "Path to SSH private key file. Corresponding public key must be in libvirt host's authorised_keys"
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

variable "notary_container_image_repository" {
  type        = string
  description = <<DESC
                  Path of the repository having the image. Example:
                  xyz.icr.io/abcd/approval-notary
                DESC
}

variable "notary_container_image_sha256" {
  type        = string
  description = "sha256 of the notary container image"
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

variable "harmonize_notary_bridge_endpoint" {
  type        = string
  description = "Endpoint of the harmonize notary-bridge service"
}

variable "crypto_server_type" {
   type   = string
   description = "Whether the crypto service is on premise grep11 or cloud hpcs"
   validation {
       condition  = ( var.crypto_server_type == "grep11" ||
                      var.crypto_server_type == "hpcs" )
       error_message = "crypto server must either be grep11 or hpcs"
  }
}
