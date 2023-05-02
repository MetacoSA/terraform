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

variable "hpvs_contract_encryption_key" {
  type        = string
  description =  <<DESC
                   Path to the Hyper Protect Container Runtime encryption key downloaded from IBM.
                   This will be used to encrypt the contract
                 DESC
}

variable "storage_pool_name" {
  type        = string
  description = "Name of the libvirt storage pool on the host"
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

variable "ssh_private_key_path" {
  type        = string
  default     = "~/.ssh/id_rsa"
  description = "Path to SSH private key file. Corresponding public key must be in libvirt host's authorised_keys"
}

variable "logdna_ingestion_key" {
  type        = string
  sensitive   = true
  description = <<-DESC
                  Ingestion key for IBM Log Analysis instance. This can be 
                  obtained from "Linux/Ubuntu" section of "Logging resource" 
                  tab of IBM Log Analysis instance
                DESC
}

variable "logdna_log_endpoint" {
  type        = string
  description = <<-DESC
                  rsyslog endpoint of IBM Log Analysis instance. 
                  Don't include the port. Example: 
                  syslog-a.<log_region>.logging.cloud.ibm.com
                  log_region is the region where IBM Log Analysis is deployed
                DESC
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
                  xyz.icr.io/abcd/vault-releases
                DESC
}

variable "container_image_sha256" {
  type        = string
  description = "sha256 of the container image"
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
  description = "GREP11 server IP / hostname"
}

variable "crypto_server_ep11_port" {
  type        = string
  default     = "9876"
  sensitive   = true
  description = "GREP11 server port"
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
