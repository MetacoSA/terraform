# Make a call to the module to get the contract generated
module "vault_contract" {
  source = "../contract_generator"
  logging_type                           = var.logging_type
  syslog_server_hostname                 = var.syslog_server_hostname
  syslog_server_port                     = var.syslog_server_port
  syslog_server_ca_cert_file             = var.syslog_server_ca_cert_file
  hpvs_contract_encryption_cert          = local.contract_encryption_cert
  container_registry                     = var.container_registry
  container_registry_user_id             = var.container_registry_user_id
  container_registry_password            = var.container_registry_password
  vault_container_image_repository       = var.vault_container_image_repository
  vault_container_image_sha256           = var.vault_container_image_sha256
  kmsconnect_container_image_repository  = var.kmsconnect_container_image_repository
  kmsconnect_container_image_sha256      = var.kmsconnect_container_image_sha256
  harmonize_api_endpoint                 = var.harmonize_api_endpoint
  notary_messaging_public_key            = var.notary_messaging_public_key
  crypto_server_type                     = var.crypto_server_type
  vault_uuid                             = var.vault_uuid
  cloudlogs_api_key                      = var.cloudlogs_api_key
  cloudlogs_ingestion_endpoint           = var.cloudlogs_ingestion_endpoint
}

locals {
  # Some reusable tags that identify the resources created
  tags = ["ibmcloud", "hpcr", "vault", var.prefix]
}

# Create a random ssh key pair although it's not used. However, due to IBM guidelines,
# need to pass an SSH key into the VSI. It will not be used, and hence it can be random
resource "tls_private_key" "vault_rsa_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Only need this because VPC expects it
resource "ibm_is_ssh_key" "vault_sshkey" {
  name               = format("%s-key", var.prefix)
  tags               = local.tags
  public_key         = tls_private_key.vault_rsa_key.public_key_openssh
  resource_group     = data.ibm_resource_group.resource_group.id
}

# Now spin up the Vault inside Hyper Protect Virtual Server on Cloud
resource "ibm_is_instance" "vault_hpvs_for_vpc" {
  name            = format("%s-vsi", var.prefix)
  profile         = var.profile
  tags            = local.tags
  vpc             = ibm_is_vpc.vault_vpc.id
  zone            = "${var.region}-${var.zone}"
  keys            = [ibm_is_ssh_key.vault_sshkey.id]
  image           = data.hpcr_image.hyper_protect_image.image
  resource_group  = data.ibm_resource_group.resource_group.id

  # user data field carries the contract.
  # It is upto the contract generator module to encrypt it
  user_data = module.vault_contract.user_data

  # Attach the network interface to the instance
  primary_network_interface {
    name            = "eth0"
    subnet          = ibm_is_subnet.vault_subnet.id
    security_groups = [ibm_is_security_group.vault_security_group.id]
  }
}

# Attach a floating IP since the Vault needs outbound connection.
# If floating IP is not desired, a gateway can also be deployed
resource "ibm_is_floating_ip" "vault_floating_ip" {
  name               = format("%s-floating-ip", var.prefix)
  tags               = local.tags
  resource_group     = data.ibm_resource_group.resource_group.id
  target             = ibm_is_instance.vault_hpvs_for_vpc.primary_network_interface[0].id
}
